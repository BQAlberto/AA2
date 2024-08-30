package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.BikeDao;
import com.svalero.wdyride.dao.CustomerDao;
import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.domain.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

import static com.svalero.wdyride.util.ErrorUtils.sendError;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        String USERNAME = request.getParameter("USERNAME");
        String PASSWORD = request.getParameter("PASSWORD");

        if (USERNAME == null || USERNAME.trim().isEmpty() || PASSWORD == null || PASSWORD.trim().isEmpty()) {
            sendError("Username or password cannot be empty", response);
            return;
        }

        try {
            Database.connect();
            Customer customer = Database.jdbi.withExtension(CustomerDao.class,
                    dao -> dao.getCustomer(USERNAME, PASSWORD));
            if (customer != null) {
                HttpSession session = request.getSession();
                session.setAttribute("USERNAME", customer.getUSERNAME());
                session.setAttribute("ROLE", customer.getROLE());
                response.getWriter().print("ok");
            } else {
                sendError("User doesn´t exist", response);
            }

        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
            sendError("Internal server error", response);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            sendError("Database error", response);
        }
    }
}
