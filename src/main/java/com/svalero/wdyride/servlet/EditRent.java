package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.CustomerDao;
import com.svalero.wdyride.dao.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static com.svalero.wdyride.util.ErrorUtils.sendError;
import static com.svalero.wdyride.util.ErrorUtils.sendMessage;

@WebServlet("/edit-rent")
@MultipartConfig
public class EditRent extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("ROLE") == null || !currentSession.getAttribute("ROLE").equals("ADMIN")) {
            response.sendRedirect("/wdyRide");
            return;  // Exit the method if the user is not an admin
        }

        try {
            // Obtiene parámetros de la solicitud
            int CUSTOMER_ID = Integer.parseInt(request.getParameter("CUSTOMER_ID"));
            String FIRST_NAME = request.getParameter("FIRST_NAME");
            String LAST_NAME = request.getParameter("LAST_NAME");

            // Actualiza usuario existente
            final int affectedRows = Database.jdbi.withExtension(CustomerDao.class,
                    dao -> dao.updateCustomer(FIRST_NAME, LAST_NAME, CUSTOMER_ID));
            if (affectedRows > 0) {
                sendMessage("Customer modified successfully!", response);
            } else {
                sendError("Failed to modify customer", response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            sendError("An error occurred", response);
        }
    }
}
