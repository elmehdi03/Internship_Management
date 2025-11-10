package com.example.internship_management.dao;

import com.example.internship_management.entity.Company;
import jakarta.ejb.Stateless;

@Stateless
public class CompanyDAO extends GenericDAO<Company> {

    public CompanyDAO() {
        super(Company.class);
    }
}
