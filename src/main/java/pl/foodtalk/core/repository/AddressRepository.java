package pl.foodtalk.core.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import pl.foodtalk.core.model.Address;

import javax.transaction.Transactional;

public interface AddressRepository extends JpaRepository<Address, Long> {
    Address findById(Long id);
    @Transactional
    Long deleteById(Long id);
}
