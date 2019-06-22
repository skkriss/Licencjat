package pl.foodtalk.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.foodtalk.core.model.Address;
import pl.foodtalk.core.model.Restaurant;

import javax.transaction.Transactional;

public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {
    Restaurant findByName(String name);
    Restaurant findByUserUsername(String name);
    @Transactional
    Long deleteById(Long id);
    Restaurant findById(Long id);
}
