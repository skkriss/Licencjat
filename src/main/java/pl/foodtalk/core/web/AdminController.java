package pl.foodtalk.core.web;

import java.util.HashSet;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import pl.foodtalk.core.model.Address;
import pl.foodtalk.core.model.Application;
import pl.foodtalk.core.model.Category;
import pl.foodtalk.core.model.Restaurant;
import pl.foodtalk.core.model.Role;
import pl.foodtalk.core.model.User;
import pl.foodtalk.core.repository.*;
import pl.foodtalk.core.service.UserService;

@Controller
public class AdminController {

    @Autowired
    private RestaurantRepository restaurantRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private RoleRepository roleRepository;
    
    @Autowired
    private ApplicationRepository applicationService;

    @RequestMapping(value = {"/admin"}, method = RequestMethod.GET)
    public String admin(Model model, Authentication auth) {
        model.addAttribute("category", new Category());
        model.addAttribute("listCategories", this.categoryRepository.findAll());
        model.addAttribute("restaurant", new Restaurant());
        model.addAttribute("listRestaurants", this.restaurantRepository.findAll());
        model.addAttribute("user", new User());
        model.addAttribute("listUsers", userService.findAll());
        model.addAttribute("role", new Role());
        model.addAttribute("listRoles", roleRepository.findAll());
        model.addAttribute("application", new Application());
        model.addAttribute("listApplications", applicationService.findAll());

        if(auth != null)
            model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));
        
        return "admin";
    }

    //ZARZADZANIE KATEGORIAMI

    @RequestMapping(value = {"/admin/addCategory"}, method = RequestMethod.POST)
    public String addCategory(@RequestParam("categoryName") String categoryName) {
        Category category = new Category(categoryName);
        categoryRepository.save(category);

        return "redirect:/admin";
    }

    @RequestMapping(value = {"/admin/editCategory"}, method = RequestMethod.POST)
    public String editCategory(@RequestParam("newName") String newName, @RequestParam("categoryId") Long categoryId) {
        Category category = categoryRepository.findById(categoryId);

        if(newName.length() != 0)
            category.setName(newName);
        categoryRepository.save(category);

        return "redirect:/admin";
    }

    @RequestMapping(value = {"/admin/deleteCategory"}, method = RequestMethod.POST)
    public String deleteCategory(@RequestParam("categoryId") Long categoryId) {
        categoryRepository.deleteById(categoryId);

        return "redirect:/admin";
    }

    //ZARZADZANIE RESTAURACJAMI

    @RequestMapping(value = {"/admin/addRestaurant"}, method = RequestMethod.POST)
    public String addRestaurant(@RequestParam("restaurantName") String name,
                                @RequestParam("desc") String desc, @RequestParam("street") String street,
                                @RequestParam("number") String number, @RequestParam("code") String code,
                                @RequestParam("city") String city, @RequestParam("username") String username) {

        Address address = new Address(street,number,code,city);
        addressRepository.save(address);
        User user = userService.findByUsername(username);

        Restaurant restaurant = new Restaurant(name,address,user,desc);
        restaurantRepository.save(restaurant);

        return "redirect:/admin";
    }

    @RequestMapping(value = {"/admin/editRestaurant"}, method = RequestMethod.POST)
    public String editRestaurant(@RequestParam("restaurantId") Long restaurantId,
                                 @RequestParam("newName") String newName, @RequestParam("newDesc") String newDesc,
                                 @RequestParam("newStreet") String newStreet, @RequestParam("newNumber") String newNumber,
                                 @RequestParam("newCode") String newCode, @RequestParam("newCity") String newCity) {

        Restaurant restaurant = restaurantRepository.findById(restaurantId);
        Address address = restaurant.getAddress();

        if(newName.length() != 0)
            restaurant.setName(newName);
        if(newDesc.length() != 0)
            restaurant.setDescription(newDesc);
        if(newStreet.length() != 0)
            address.setStreet(newStreet);
        if(newNumber.length() != 0)
            address.setNumber(newNumber);
        if(newCode.length() != 0)
            address.setPost_code(newCode);
        if(newCity.length() != 0)
            address.setCity(newCity);

        addressRepository.save(address);
        restaurantRepository.save(restaurant);

        return "redirect:/admin";
    }

    @RequestMapping(value = {"/admin/deleteRestaurant"}, method = RequestMethod.POST)
    public String deleteRestaurant(@RequestParam("restaurantId") Long restaurantId) {

        restaurantRepository.deleteById(restaurantId);

        return "redirect:/admin";
    }
    
    //ZARZADZANIE UZYTKOWNIKAMI
    
    @RequestMapping(value = {"/admin/editUser"}, method = RequestMethod.POST)
    public String editUser(@RequestParam("userId") Long userId,
                                 @RequestParam("newUsername") String newUsername, @RequestParam("newRole") Long newRole) {

        User user = userService.findById(userId);

        if(newUsername.length() != 0)
            user.setUsername(newUsername);
        if(newRole != null)
        	user.setRoles(new HashSet<>(roleRepository.findById(newRole)));

        userRepository.save(user);

        return "redirect:/admin";
    }
    
    @RequestMapping(value = {"/admin/deleteUser"}, method = RequestMethod.POST)
    public String deleteUser(@RequestParam("userId") Long userId) {

        userService.deleteById(userId);

        return "redirect:/admin";
    }
    
    //ZARZADZANIE WNIOSKAMI
    @RequestMapping(value = {"/admin/approveApp"}, method = RequestMethod.POST)
    public String approveApp(@RequestParam("applicationId") Long applicationId) {

        Application application = applicationService.findById(applicationId);
        
        Address address = new Address(application.getStreet(), application.getNumber(), application.getPost_code(), application.getCity());
        addressRepository.save(address);
        
        Restaurant restaurant = new Restaurant(application.getName(), address, application.getUser(), application.getDescription());
        restaurantRepository.save(restaurant);

        User user = userService.findById(application.getUser().getId());
        user.setRoles(new HashSet<>(roleRepository.findById((long) 2)));
        userRepository.save(user);

        applicationService.deleteById(applicationId);
        
        return "redirect:/admin";
    }
    
    @RequestMapping(value = {"/admin/discardApp"}, method = RequestMethod.POST)
    public String discardApp(@RequestParam("applicationId") Long applicationId) {

        applicationService.deleteById(applicationId);

        return "redirect:/admin";
    }
    
}
