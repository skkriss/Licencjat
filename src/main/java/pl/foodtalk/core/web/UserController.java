package pl.foodtalk.core.web;

import org.springframework.web.bind.annotation.*;
import pl.foodtalk.core.model.Opinion;
import pl.foodtalk.core.model.Restaurant;
import pl.foodtalk.core.model.User;
import pl.foodtalk.core.model.Visit;
import pl.foodtalk.core.repository.OpinionRepository;
import pl.foodtalk.core.repository.RestaurantRepository;
import pl.foodtalk.core.repository.VisitRepository;
import pl.foodtalk.core.service.*;
import pl.foodtalk.core.validator.UserValidator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.stream.Collectors;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private VisitRepository visitRepository;

    @Autowired
    private OpinionRepository opinionRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @RequestMapping(value = "/registration", method = RequestMethod.GET)
    public String registration(Model model) {
        model.addAttribute("userForm", new User());

        return "registration";
    }

    @RequestMapping(value = "/registration", method = RequestMethod.POST)
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult, Model model) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "registration";
        }

        userService.save(userForm);

        securityService.autologin(userForm.getUsername(), userForm.getPasswordConfirm());

        return "redirect:/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, String error, String logout) {


        if (error != null)
            model.addAttribute("error", "Nazwa użytkownika lub hasło niepoprawne.");

        if (logout != null)
            model.addAttribute("message", "Zostales wylogowany.");

        return "login";
    }

    @RequestMapping(value = "/user", method = RequestMethod.GET)
    public String user(Model model, Authentication auth) {

        User currentUser = userService.findByUsername(auth.getName());

        model.addAttribute("visit", new Visit());
        model.addAttribute("restaurant", new Restaurant());
        model.addAttribute("opinion", new Opinion());
        
        ArrayList<Visit> prevVisits = new ArrayList<Visit>();
        ArrayList<Visit> futureVisits = new ArrayList<Visit>();
        
        for(Visit v : visitRepository.findByUserId(currentUser.getId())) {
        	if(v.getEnd_date().compareTo(new Date())< 0)
        		prevVisits.add(v);
        	else  futureVisits.add(v);
        }
        
        model.addAttribute("previousVisits", prevVisits);
        model.addAttribute("futureVisits", futureVisits);
        model.addAttribute("listOpinions", opinionRepository.findByUserId(currentUser.getId()));

        if(auth != null)
            model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));
        
        return ("user");
    }

    //ZARZADZANIE WIZYTAMI USERA

    @RequestMapping(value = {"/user/editVisit"}, method = RequestMethod.POST)
    public String editVisit(@RequestParam("visitId") Long visitId,
                            @RequestParam("newDesc") String newDesc, @RequestParam("start_dateString") String startDateString) throws ParseException {

        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        Visit visit = visitRepository.findById(visitId);

        if (startDateString.length() != 0) {
            visit.setStart_date(new Date(formatter.parse(startDateString).getTime()));
            visit.setEnd_date(new Date(formatter.parse(startDateString).getTime() + 7200000));
        }
        if (newDesc.length() != 0)
            visit.setDescription(newDesc);
        visitRepository.save(visit);
        

        return "redirect:/user";
    }

    @RequestMapping(value = {"/user/deleteVisit"}, method = RequestMethod.POST)
    public String deleteVisit(@RequestParam("visitId") Long visitId) {

        visitRepository.deleteById(visitId);

        return "redirect:/user";
    }

    //ZARZADZANIE OPINIAMI USERA

    @RequestMapping(value = {"/user/addOpinion"}, method = RequestMethod.POST)
    public String addOpinion(Authentication authentication, @RequestParam("restaurantId") Long restaurantId,
                             @RequestParam("star") int star, @RequestParam("name") String name, @RequestParam("desc") String desc) {

        User currentUser = userService.findByUsername(authentication.getName());
        Restaurant restaurant = restaurantRepository.findById(restaurantId);
        Opinion opinion = new Opinion(star, name, desc, restaurant, currentUser);
        opinionRepository.save(opinion);

        return "redirect:/user";
    }

    @RequestMapping(value = {"/user/editOpinion"}, method = RequestMethod.POST)
    public String editOpinion(@RequestParam("opinionId") Long opinionId,
                              @RequestParam("newStar") int newStar, @RequestParam("newName") String newName,
                              @RequestParam("newDesc") String newDesc) {

        Opinion opinion = opinionRepository.findById(opinionId);

        if (newStar > 0)
            opinion.setStar(newStar);
        if (newName.length() != 0)
            opinion.setName(newName);
        if (newDesc.length() != 0)
            opinion.setDescription(newDesc);
        opinionRepository.save(opinion);

        return "redirect:/user";
    }

    @RequestMapping(value = {"/user/deleteOpinion"}, method = RequestMethod.POST)
    public String deleteOpinion(@RequestParam("opinionId") Long opinionId) {

        opinionRepository.deleteById(opinionId);

        return "redirect:/user";
    }

    @RequestMapping(value = "/joinVisit", method = RequestMethod.POST)
    public String joinVisit(Authentication auth, @RequestParam("restaurantName") String restaurantName, @RequestParam("visitId") Long visitId) {
        User currentUser = userService.findByUsername(auth.getName());
        Visit visit = visitRepository.findById(visitId);

        visit.getGuests().add(currentUser);
        currentUser.getVisits().add(visit);
        visitRepository.save(visit);

        return "redirect:/restaurant/"+restaurantName;
    }
}