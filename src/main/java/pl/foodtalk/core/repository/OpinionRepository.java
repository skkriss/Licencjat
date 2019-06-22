package pl.foodtalk.core.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import pl.foodtalk.core.model.Opinion;

import javax.transaction.Transactional;

public interface OpinionRepository extends JpaRepository<Opinion, Long>{
    List<Opinion> findByUserId(Long id);
    Opinion findById(Long id);
    @Transactional
    Long deleteById(Long id);
}
