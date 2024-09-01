package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.CustomerDao;
import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.domain.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

import static com.svalero.wdyride.util.ErrorUtils.sendError;
import static com.svalero.wdyride.util.ErrorUtils.sendMessage;

@WebServlet("/register-user")
@MultipartConfig
public class RegisterCustomer extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession currentSession = request.getSession();

        try {
            // Verifica si algún campo imprescindible está vacío
            String USERNAME = request.getParameter("USERNAME");
            String PASSWORD = request.getParameter("PASSWORD");

            if (USERNAME == null || USERNAME.isBlank()) {
                sendError("Username is required", response);
                return;
            }

            if (PASSWORD == null || PASSWORD.isBlank()) {
                sendError("Password is required", response);
                return;
            }

            // Obtiene los demás parámetros de la solicitud
            String FIRST_NAME = request.getParameter("FIRST_NAME");
            String LAST_NAME = request.getParameter("LAST_NAME");
            String ROLE = request.getParameter("ROLE");

            // Asigna un valor por defecto si ROLE es nulo o está en blanco
            if (ROLE == null || ROLE.isBlank()) {
                ROLE = "USER";
            }

            // Conecta a la base de datos y busca un usuario existente con el mismo USERNAME
            Database.connect();
            final Customer existingCustomer = Database.jdbi.withExtension(CustomerDao.class, dao -> dao.getCustomerByUsername(USERNAME));

            if (existingCustomer != null) {
                sendError("Username already exists", response);
                return;
            }

            // Registra el nuevo usuario
            final String finalROLE = ROLE;
            Database.jdbi.withExtension(CustomerDao.class, dao -> dao.addCustomer(FIRST_NAME, LAST_NAME, USERNAME, PASSWORD, finalROLE));

            sendMessage("User registered successfully", response);

        } catch (ClassNotFoundException cncfe) {
            cncfe.printStackTrace();
            sendError("Internal server error", response);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            sendError("Database error", response);
        }
    }
}
