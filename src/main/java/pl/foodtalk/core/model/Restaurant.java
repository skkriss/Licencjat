package pl.foodtalk.core.model;

import javax.persistence.*;

@Entity
@Table(name = "restaurant")
public class Restaurant {
    private Long id;
    private String name;
    private Address address;
    private User user;
    private String description;

    public Restaurant() { super(); }

    public Restaurant(String name, Address address, User user, String description) {
        super();
        this.name = name;
        this.address = address;
        this.user = user;
        this.description = description;
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

    @ManyToOne(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER)
    @JoinColumn(name="address_id")
    public Address getAddress() {
    	return address;
    }
    
    public void setAddress(Address address) {
    	this.address = address;
    }

    @ManyToOne(cascade = CascadeType.REMOVE, fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    public User getUser() { return user; }

    public void setUser(User user) { this.user = user; }

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
