package pl.foodtalk.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.foodtalk.core.model.Application;

import javax.transaction.Transactional;

public interface ApplicationRepository extends JpaRepository<Application, Long> {
    Application findById(Long id);
    Application findByUserId(Long id);
    @Transactional
    Long deleteById(Long id);
}
