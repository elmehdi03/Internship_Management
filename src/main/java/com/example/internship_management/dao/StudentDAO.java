package com.example.internship_management.dao;

import com.example.internship_management.entity.Student;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import java.util.List;
import java.util.Optional;

@ApplicationScoped
public class StudentDAO {

    @PersistenceContext
    private EntityManager em;

    public Optional<Student> findById(Long id) {
        return Optional.ofNullable(em.find(Student.class, id));
    }

    public List<Student> findAll() {
        return em.createQuery("SELECT s FROM Student s", Student.class)
                .getResultList();
    }

    public Optional<Student> findByEmail(String email) {
        try {
            Student student = em.createQuery("SELECT s FROM Student s WHERE s.email = :email", Student.class)
                    .setParameter("email", email)
                    .getSingleResult();
            return Optional.ofNullable(student);
        } catch (NoResultException ex) {
            return Optional.empty();
        }
    }

    public Student save(Student student) {
        if (student.getId() == null) {
            em.persist(student);
            return student;
        } else {
            return em.merge(student);
        }
    }

    public void deleteById(Long id) {
        Student s = em.find(Student.class, id);
        if (s != null) {
            em.remove(s);
        }
    }
}
