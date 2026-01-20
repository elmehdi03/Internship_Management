package com.example.internship_management.servlet;

import com.example.internship_management.service.InternshipService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/internships")
public class InternshipServlet extends HttpServlet {

    @Inject
    private InternshipService internshipService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("internships", internshipService.getAllInternships());
        request.getRequestDispatcher("/internships.jsp").forward(request, response);
    }
}
