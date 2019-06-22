package pl.foodtalk.core.model;

import javax.persistence.*;

@Entity
@Table(name = "application")
public class Application {
    private Long id;
    private String name;
    private String description;
    private String street;
    private String number;
    private String post_code;
    private String city;
    private User user;

    public Application(String name, String description, String street, String number, String postcode, String city, User user) {
		super();
		this.name = name;
		this.description = description;
		this.street = street;
		this.number = number;
		this.post_code = postcode;
		this.city = city;
		this.user = user;
	}

	public Application() {
		super();
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

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    public User getUser() { 
    	return user; }

    public void setUser(User user) { 
    	this.user = user; }

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getPost_code() {
		return post_code;
	}

	public void setPost_code(String postcode) {
		this.post_code = postcode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}
}
