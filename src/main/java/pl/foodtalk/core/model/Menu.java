package pl.foodtalk.core.model;

import javax.persistence.*;

@Entity
@Table(name = "menu")
public class Menu {
    private Long id;
    private String name;
    private Restaurant restaurant;
    
    public Menu() {
		super();
	}

	public Menu(String name, Restaurant restaurant) {
		super();
		this.name = name;
		this.restaurant = restaurant;
	}

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="restaurant_id")
    public Restaurant getRestaurant() {
    	return restaurant;
    }
    
    public void setRestaurant(Restaurant restaurant) {
    	this.restaurant = restaurant;
    }
}
