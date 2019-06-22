package pl.foodtalk.core.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.foodtalk.core.model.Visit;

import javax.transaction.Transactional;

public interface VisitRepository extends JpaRepository<Visit, Long>{
    List<Visit> findByRestaurantName(String name);
    List<Visit> findByUserId(Long id);
    @Transactional
    Long deleteById(Long id);
    Visit findById(Long id);
}
