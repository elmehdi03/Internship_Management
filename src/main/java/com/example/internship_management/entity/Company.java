package com.example.internship_management.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "company")
public class Company {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Le nom de l'entreprise est obligatoire")
    @Column(nullable = false, length = 150)
    private String name;

    @NotBlank(message = "Le secteur est obligatoire")
    @Column(nullable = false, length = 100)
    private String sector;

    @NotBlank(message = "La ville est obligatoire")
    @Column(nullable = false, length = 100)
    private String city;

    @JsonIgnore
    @OneToMany(mappedBy = "company", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Internship> internships = new ArrayList<>();

    public Company() {}

    public Company(String name, String sector, String city) {
        this.name = name;
        this.sector = sector;
        this.city = city;
    }

    // --- Getters & Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSector() { return sector; }
    public void setSector(String sector) { this.sector = sector; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public List<Internship> getInternships() { return internships; }
    public void setInternships(List<Internship> internships) { this.internships = internships; }

    // Alias getters/setters for REST API compatibility
    public String getIndustry() {
        return sector;
    }

    public void setIndustry(String industry) {
        this.sector = industry;
    }

    public String getLocation() {
        return city;
    }

    public void setLocation(String location) {
        this.city = location;
    }
}
