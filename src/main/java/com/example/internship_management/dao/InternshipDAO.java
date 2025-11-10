package com.example.internship_management.dao;

import com.example.internship_management.entity.Internship;
import jakarta.ejb.Stateless;
import java.util.List;

@Stateless
public class InternshipDAO extends GenericDAO<Internship> {

    public InternshipDAO() {
        super(Internship.class);
    }

    public List<Internship> findByStudentId(Long studentId) {
        return em.createQuery(
                        "SELECT i FROM Internship i WHERE i.student.id = :studentId", Internship.class)
                .setParameter("studentId", studentId)
                .getResultList();
    }
}
