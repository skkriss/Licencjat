package pl.foodtalk.core.model;

import javax.persistence.*;

@Entity
@Table(name = "address")
public class Address {
    private Long id;
    private String street;
    private String number;
    private String post_code;
    private String city;

	public Address() { super(); }

	public Address(String street, String number, String post_code, String city) {
		super();
		this.street = street;
		this.number = number;
		this.post_code = post_code;
		this.city = city;
	}

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getPost_code() {
		return post_code;
	}

	public void setPost_code(String post_code) {
		this.post_code = post_code;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
}
