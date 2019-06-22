package pl.foodtalk.core.web;

import org.springframework.web.bind.annotation.*;
import pl.foodtalk.core.model.*;
import pl.foodtalk.core.repository.DishRepository;
import pl.foodtalk.core.repository.MenuRepository;
import pl.foodtalk.core.repository.RestaurantRepository;
import pl.foodtalk.core.repository.VisitRepository;
import pl.foodtalk.core.service.UserService;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller
public class RestaurantController {
    @Autowired
    private DishRepository dishRepository;

    @Autowired
    private RestaurantRepository restaurantRepository;
    
    @Autowired
    private VisitRepository visitRepository;
    
    @Autowired
    private MenuRepository menuRepository;
    
    @Autowired
    private UserService userService;
    
    @RequestMapping(value = {"/restaurants/{cat}"}, method = RequestMethod.GET)
    public String restaurants(@PathVariable("cat") String cat, Model model, Authentication auth) {
    	ArrayList<Restaurant> listRestaurants = new ArrayList<Restaurant>();
    	
    	model.addAttribute("restaurant", new Restaurant());
    	for(Dish d : this.dishRepository.findByCategoryName(cat)) {
    		if(!listRestaurants.contains(d.getMenu().getRestaurant()))
    			listRestaurants.add(d.getMenu().getRestaurant());
    	}
		model.addAttribute("listRestaurants", listRestaurants);

		if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));
		
        return "restaurants";
    }

    @RequestMapping(value = "/restaurants", method = RequestMethod.GET)
    public String findAll(Model model, Authentication auth) {
        model.addAttribute("restaurant", new Restaurant());
        model.addAttribute("listRestaurants", restaurantRepository.findAll());

		if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));
        
        return "restaurant";
    }
    
    @RequestMapping(value = {"/restaurant/{res}"}, method = RequestMethod.GET)
    public String menu(@PathVariable("res") String res, Model model, Authentication auth) {
    	
    	HashMap<Menu, List<Dish>> menuMap = new HashMap<Menu, List<Dish>>();
        ArrayList<Visit> futureVisits = new ArrayList<Visit>();
    	model.addAttribute("dish", new Dish());
    	model.addAttribute("menu", new Menu());
    	model.addAttribute("visit", new Visit());
    	model.addAttribute("visitForm", new Visit());
    	model.addAttribute("restaurant", restaurantRepository.findByName(res));
    
    	for(Menu m : this.menuRepository.findByRestaurantName(res))
    		menuMap.put(m, this.dishRepository.findByMenuId(m.getId()));

        model.addAttribute("menuMap", menuMap);

        for(Visit v : this.visitRepository.findByRestaurantName(res)) {
            if(v.getStart_date().compareTo(new Date()) > 0) {
                futureVisits.add(v);
            }
        }

        model.addAttribute("futureVisits", futureVisits);

		if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));

        return "restaurant";
    }
    
	@RequestMapping(value = "/restaurant/{res}", method = RequestMethod.POST)
    public String visit(@ModelAttribute("visitForm") Visit visitForm, @PathVariable("res") String res, Authentication auth) throws ParseException {
    
    	DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); 
    	
    	visitForm.setRestaurant(this.restaurantRepository.findByName(res));
    	visitForm.setUser(this.userService.findByUsername(auth.getName()));
    	visitForm.setStart_date(new Date(formatter.parse(visitForm.getStart_dateString()).getTime()));
        visitForm.setEnd_date(new Date(formatter.parse(visitForm.getStart_dateString()).getTime() + 7200000));
        visitRepository.save(visitForm);

        System.out.println(visitForm.getStart_dateString() + "   " + visitForm.getEnd_dateString());
        System.out.println(visitForm.getStart_date() + "   "+visitForm.getEnd_date());
        
        
        return "redirect:/restaurant/"+res;
	}
}
