package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.BikeDao;
import com.svalero.wdyride.dao.CustomerDao;
import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.domain.Bike;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.UUID;

import static com.svalero.wdyride.util.ErrorUtils.sendError;
import static com.svalero.wdyride.util.ErrorUtils.sendMessage;

@WebServlet("/edit-customer")
@MultipartConfig
public class EditCustomer extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("ROLE") == null || !currentSession.getAttribute("ROLE").equals("ADMIN")) {
            response.sendRedirect("/wdyRide");
            return;  // Exit the method if the user is not an admin
        }

        try {
            // Obtiene los parámetros de la solicitud
            int CUSTOMER_ID = Integer.parseInt(request.getParameter("CUSTOMER_ID"));
            String FIRST_NAME = request.getParameter("FIRST_NAME");
            String LAST_NAME = request.getParameter("LAST_NAME");

            // Actualiza el usuario existente
            final int affectedRows = Database.jdbi.withExtension(CustomerDao.class,
                    dao -> dao.updateCustomer(FIRST_NAME, LAST_NAME, CUSTOMER_ID));
            if (affectedRows > 0) {
                sendMessage("Customer modified successfully!", response);
            } else {
                sendError("Failed to modify customer", response);
            }

        } catch (Exception e) {  // Captura genérica si es necesario
            e.printStackTrace();
            sendError("An error occurred", response);
        }
    }
}
