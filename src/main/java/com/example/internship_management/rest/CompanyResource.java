package com.example.internship_management.rest;

import com.example.internship_management.entity.Company;
import com.example.internship_management.service.CompanyService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/companies")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class CompanyResource {

    @Inject
    private CompanyService companyService;

    @GET
    public List<Company> getAllCompanies() {
        return companyService.findAll();
    }

    @GET
    @Path("/{id}")
    public Response getCompany(@PathParam("id") Long id) {
        Company company = companyService.findById(id);
        if (company == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(company).build();
    }

    @POST
    public Response createCompany(Company company) {
        companyService.save(company);
        return Response.status(Response.Status.CREATED).entity(company).build();
    }

    @PUT
    @Path("/{id}")
    public Response updateCompany(@PathParam("id") Long id, Company company) {
        Company existing = companyService.findById(id);
        if (existing == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        company.setId(id);
        companyService.update(company);
        return Response.ok(company).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteCompany(@PathParam("id") Long id) {
        Company company = companyService.findById(id);
        if (company == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        companyService.delete(id);
        return Response.noContent().build();
    }
}
