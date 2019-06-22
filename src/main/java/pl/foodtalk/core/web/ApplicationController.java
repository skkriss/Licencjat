package pl.foodtalk.core.web;

import pl.foodtalk.core.model.Application;
import pl.foodtalk.core.model.User;
import pl.foodtalk.core.model.Visit;
import pl.foodtalk.core.repository.ApplicationRepository;
import pl.foodtalk.core.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.stream.Collectors;

@Controller
public class ApplicationController {

	@Autowired
	private ApplicationRepository applicationRepository;

	@Autowired
	private UserService userService;

	@RequestMapping(value = {"/restauratorForm"}, method = RequestMethod.GET)
	public String management(Model model, Authentication auth) {

		if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));

		model.addAttribute("application", applicationRepository.findByUserId(this.userService.findByUsername(auth.getName()).getId()));


		return "restauratorForm";
	}

	@RequestMapping(value = {"/restauratorForm"}, method = RequestMethod.POST)
	public String application(Authentication authentication, @RequestParam("name") String name, @RequestParam("description") String description,
			@RequestParam("street") String street, @RequestParam("number") String number, @RequestParam("postcode") String postcode, 
			@RequestParam("city") String city) {

		Application application = new Application(name, description, street, number, postcode, city, userService.findByUsername(authentication.getName()));

		applicationRepository.save(application);
		
		return "redirect:/restauratorForm";
	}
}