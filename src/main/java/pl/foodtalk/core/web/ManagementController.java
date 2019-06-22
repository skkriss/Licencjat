package pl.foodtalk.core.web;

import pl.foodtalk.core.model.Dish;
import pl.foodtalk.core.model.Menu;
import pl.foodtalk.core.repository.CategoryRepository;
import pl.foodtalk.core.repository.DishRepository;
import pl.foodtalk.core.repository.MenuRepository;
import pl.foodtalk.core.repository.RestaurantRepository;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.ServletContext;

@Controller
public class ManagementController {
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private MenuRepository menuRepository;

	@Autowired
	private DishRepository dishRepository;

	@Autowired
	private RestaurantRepository restaurantRepository;

	@Autowired
	private CategoryRepository categoryRepository;

	@RequestMapping(value = {"/manage"}, method = RequestMethod.GET)
	public String management(Model model, Authentication auth) {

		HashMap<Menu, List<Dish>> menuMap = new HashMap<Menu, List<Dish>>();
		model.addAttribute("dish", new Dish());
		model.addAttribute("menu", new Menu());
		
		if(restaurantRepository.findByUserUsername(auth.getName()) != null) {
			for(Menu m : menuRepository.findByRestaurantName(restaurantRepository.findByUserUsername(auth.getName()).getName()))
				menuMap.put(m, dishRepository.findByMenuId(m.getId()));
			model.addAttribute("restaurant", restaurantRepository.findByUserUsername(auth.getName()));
		}
		model.addAttribute("menuMap", menuMap);
		model.addAttribute("listCategories", categoryRepository.findAll());

		if(auth != null)
			model.addAttribute("role", auth.getAuthorities().stream().map(r -> r.getAuthority()).collect(Collectors.toSet()));

		return "manage";
	}

	//ZARZADZANIE MENU

	@RequestMapping(value = {"/manage/editMenu"}, method = RequestMethod.POST)
	public String editMenu(@RequestParam("newName") String newName, @RequestParam("menuId") Long menuId) {

		Menu menu = menuRepository.findById(menuId);
		if(newName.length() != 0)
			menu.setName(newName);
		menuRepository.save(menu);

		return "redirect:/manage";
	}

	@RequestMapping(value = {"/manage/deleteMenu"}, method = RequestMethod.POST)
	public String deleteMenu(@RequestParam("menuId") Long menuId) {

		menuRepository.deleteById(menuId);

		return "redirect:/manage";
	}

	@RequestMapping(value = {"/manage/addMenu"}, method = RequestMethod.POST)
	public String addMenu(Authentication authentication, @RequestParam("menuName") String menuName) {

		Menu menu = new Menu(menuName, restaurantRepository.findByUserUsername(authentication.getName()));
		menuRepository.save(menu);

		return "redirect:/manage";
	}

	//ZARZADZANIE DISH

	@RequestMapping(value = {"/manage/editDish"}, method = RequestMethod.POST)
	public String editDish(@RequestParam("newName") String newName, @RequestParam("newPrice") Float newPrice,
						   @RequestParam("newDesc") String newDesc, @RequestParam("dishId") Long dishId,
						   @RequestParam("restaurantId") Long restaurantId, @RequestParam("file") MultipartFile file) {

		Dish dish = dishRepository.findById(dishId);
		if(newName.length() != 0)
			dish.setName(newName);
		if(newDesc.length() != 0)
			dish.setDescription(newDesc);
		if(newPrice != null)
			dish.setPrice(newPrice);
		dishRepository.save(dish);
		saveDishImage(file, restaurantId, dishId);

		return "redirect:/manage";
	}

	@RequestMapping(value = {"/manage/addDish"}, method = RequestMethod.POST)
	public String addDish(@RequestParam("newName") String newName, @RequestParam("newPrice") Float newPrice,
						  @RequestParam("newDesc") String newDesc, @RequestParam("menuId") Long menuId, @RequestParam("cat") Long categoryId, 
						  @RequestParam("restaurantId") Long restaurantId, @RequestParam("file") MultipartFile file) throws IllegalStateException {

		System.out.println("\n\n" + servletContext.getRealPath("/resources/img/") + "\n\n");
		
		Dish dish = new Dish(newPrice, newName, newDesc, categoryRepository.findById(categoryId), menuRepository.findById(menuId));
		dishRepository.save(dish);
		saveDishImage(file, restaurantId, dish.getId());

		return "redirect:/manage";
	}

	@RequestMapping(value = {"/manage/deleteDish"}, method = RequestMethod.POST)
	public String deleteDish(@RequestParam("dishId") Long dishId) {

		dishRepository.deleteById(dishId);

		return "redirect:/manage";
	}

	@RequestMapping(value = {"/manage/changePhoto"}, method = RequestMethod.POST)
	public String changePhoto(@RequestParam("restaurantId") Long restaurantId, @RequestParam("file") MultipartFile file) {

		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				File dir = new File(servletContext.getRealPath("resources/img/restaurants") + "/restaurant" + restaurantId);
				if (!dir.exists())
					dir.mkdirs();

				File imageFile = new File(dir.getAbsolutePath() + "/main.jpg");
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(imageFile));
				stream.write(bytes);
				stream.close();

			} catch (Exception e) {
				System.err.println("Upload obrazka zakonczony niepowodzeniem:\n" + e.getMessage());
			}
		}

		return "redirect:/manage";
	}

	private void saveDishImage(MultipartFile file, Long restaurantId, Long dishId){
		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				File dir = new File(servletContext.getRealPath("resources/img/restaurants") + "/restaurant" + restaurantId + "/dishes/");
				if (!dir.exists())
					dir.mkdirs();

				File imageFile = new File(dir.getAbsolutePath() + File.separator + dishId + ".jpg");
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(imageFile));
				stream.write(bytes);
				stream.close();

			} catch (Exception e) {
				System.err.println("Upload obrazka zakonczony niepowodzeniem:\n" + e.getMessage());
			}
		}
	}

}