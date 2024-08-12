package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.dao.BikeDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/edit-bike")

public class EditBike extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            if (hasvalidationErrors(request, response))
                return;

            String SERIAL_NUMBER = request.getParameter("SERIAL_NUMBER");
            String CONDITION = request.getParameter("CONDITION");
            String BRAND = request.getParameter("BRAND");
            String MODEL = request.getParameter("MODEL");
            String PICTURE = request.getParameter("PICTURE");

            Database.connect();
            int affectedRows = Database.jdbi.withExtension(BikeDao.class,
                    dao -> dao.addBike(SERIAL_NUMBER, CONDITION, BRAND, MODEL, PICTURE));
            sendMessage("Bike updated successfully!", response);
        } catch (ClassNotFoundException cncfe) {
            cncfe.printStackTrace();
            sendError("Internal server error", response);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            sendError("Database error", response);
        }
    }

    private boolean hasvalidationErrors(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean hasErrors = false;

        if (request.getParameter("SERIAL_NUMBER").isBlank()) {
            sendError("Serial Number is blank", response);
            hasErrors = true;
        }
        return hasErrors;
    }

    private void sendError(String message, HttpServletResponse response) throws IOException {
        response.getWriter().println("<div class='alert alert-danger' role='alert'>" + message + "</div>");
    }

    private void sendMessage(String message, HttpServletResponse response) throws IOException {
        response.getWriter().println("<div class='alert alert-success' role='alert'>" + message + "</div>");
    }
}
