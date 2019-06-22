package pl.foodtalk.core.model;

import javax.persistence.*;

@Entity
@Table(name = "dish")
public class Dish {
    private Long id;
    private Float price;
    private String name;
    private String description;
    private Category category;
    private Menu menu;

     
    
    public Dish() {
		super();
	}

	public Dish(Float price, String name, String description, Category category, Menu menu) {
		super();
		this.price = price;
		this.name = name;
		this.description = description;
		this.category = category;
		this.menu = menu;
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
    @JoinColumn(name="category_id")
    public Category getCategory() {
    	return category;
    }
    
    public void setCategory(Category category) {
    	this.category = category;
    }
    
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name="menu_id")
    public Menu getMenu() {
    	return menu;
    }
    
    public void setMenu(Menu menu) {
    	this.menu = menu;
    }

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
    
    
}
