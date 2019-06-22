package pl.foodtalk.core.web;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.stream.Collectors;

@Controller
public class MainController {

    @RequestMapping(value = {"/", "/welcome"}, method = RequestMethod.GET)
    public String welcome(Model model, Authentication auth) {
    	if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));

        return "welcome";
    }
    
    @RequestMapping(value = {"/accessDenied"}, method = RequestMethod.GET)
    public String accessDenied() {
        return "accessDenied";
    }
    
    @RequestMapping(value = {"/notFound"}, method = RequestMethod.GET)
    public String notFound() {
        return "notFound";
    }
}
