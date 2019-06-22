package pl.foodtalk.core.web;

import pl.foodtalk.core.model.Category;
import pl.foodtalk.core.repository.CategoryRepository;

import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CategoryController {
    @Autowired
    private CategoryRepository categoryRepository;

    @RequestMapping(value = {"/category"}, method = RequestMethod.GET)
    public String categoryIMG(Model model, Authentication auth) {
    	
    	model.addAttribute("category", new Category());
		model.addAttribute("listCategories", this.categoryRepository.findAll());

		if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));

        return "category";
    }
}
