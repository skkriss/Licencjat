package pl.foodtalk.core.model;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "visit")
public class Visit {
    private Long id;
    private String description;
    private Date start_date;
    private Date end_date;
    private String start_dateString;
    private String end_dateString;
    private User user;
    private Restaurant restaurant;
    private Set<User> guests;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    public Long getId() { return id; }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getStart_date() {
        return start_date;
    }

    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "restaurant_id")
    public Restaurant getRestaurant() {
        return restaurant;
    }

    public void setRestaurant(Restaurant restaurant) {
        this.restaurant = restaurant;
    }

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "user_visit", joinColumns = @JoinColumn(name = "visit_id"), inverseJoinColumns =  @JoinColumn(name = "user_id"))
    public Set<User> getGuests() {
        return guests;
    }

    public void setGuests(Set<User> guests) {
        this.guests = guests;
    }

    @Transient
	public String getStart_dateString() {
		return start_dateString;
	}

	public void setStart_dateString(String start_dateString) {
		this.start_dateString = start_dateString;
	}

	@Transient
	public String getEnd_dateString() {
		return end_dateString;
	}

	public void setEnd_dateString(String end_dateString) {
		this.end_dateString = end_dateString;
	}
    
}