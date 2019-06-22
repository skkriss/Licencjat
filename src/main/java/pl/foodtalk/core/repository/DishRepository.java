package pl.foodtalk.core.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import pl.foodtalk.core.model.Dish;

public interface DishRepository extends JpaRepository<Dish, Long>{
	List<Dish> findByCategoryName(String name);
	List<Dish> findByMenuId(Long id);
	Dish findById(Long id);
	@Transactional
	Long deleteById(Long id);
}
