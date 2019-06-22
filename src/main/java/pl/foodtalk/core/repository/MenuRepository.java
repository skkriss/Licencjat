package pl.foodtalk.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import pl.foodtalk.core.model.Menu;

import java.util.List;

public interface MenuRepository extends JpaRepository<Menu, Long>{
    List<Menu> findByRestaurantName(String name);
    Menu findById(Long id);
    @Transactional
    Long deleteById(Long id);
}
