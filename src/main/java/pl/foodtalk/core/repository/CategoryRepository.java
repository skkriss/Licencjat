package pl.foodtalk.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.transaction.annotation.Transactional;

import pl.foodtalk.core.model.Category;

public interface CategoryRepository extends JpaRepository<Category, Long> {
    Category findById(Long id);
    @Transactional
    Long deleteById(Long id);
}
