package com.example.internship_management.rest;

import com.example.internship_management.entity.Internship;
import com.example.internship_management.service.InternshipService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/internships")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class InternshipResource {

    @Inject
    private InternshipService internshipService;

    @GET
    public List<Internship> getAllInternships() {
        return internshipService.findAll();
    }

    @GET
    @Path("/{id}")
    public Response getInternship(@PathParam("id") Long id) {
        Internship internship = internshipService.findById(id);
        if (internship == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(internship).build();
    }

    @POST
    public Response createInternship(Internship internship) {
        internshipService.save(internship);
        return Response.status(Response.Status.CREATED).entity(internship).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateInternship(@PathParam("id") Long id, Internship internship) {
        Internship existing = internshipService.findById(id);
        if (existing == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        internship.setId(id);
        internshipService.update(internship);
        return Response.ok(internship).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteInternship(@PathParam("id") Long id) {
        Internship internship = internshipService.findById(id);
        if (internship == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        internshipService.delete(id);
        return Response.noContent().build();
    }
}
