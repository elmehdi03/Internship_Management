package com.example.internship_management.rest;

import com.example.internship_management.entity.Student;
import com.example.internship_management.service.StudentService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/students")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class StudentResource {

    @Inject
    private StudentService studentService;

    @GET
    public List<Student> getAllStudents() {
        return studentService.findAll();
    }

    @GET
    @Path("/{id}")
    public Response getStudent(@PathParam("id") Long id) {
        Student student = studentService.findById(id);
        if (student == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(student).build();
    }

    @POST
    public Response createStudent(Student student) {
        studentService.save(student);
        return Response.status(Response.Status.CREATED).entity(student).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateStudent(@PathParam("id") Long id, Student student) {
        Student existing = studentService.findById(id);
        if (existing == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        student.setId(id);
        studentService.update(student);
        return Response.ok(student).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteStudent(@PathParam("id") Long id) {
        Student student = studentService.findById(id);
        if (student == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        studentService.delete(id);
        return Response.noContent().build();
    }
}
