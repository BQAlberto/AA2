package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.BikeDao;
import com.svalero.wdyride.dao.CustomerDao;
import com.svalero.wdyride.dao.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/remove-customer")

public class RemoveCustomer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String CUSTOMER_ID = request.getParameter("CUSTOMER_ID");

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(CustomerDao.class,
                    dao -> dao.removeCustomer(Integer.parseInt(CUSTOMER_ID)));
            response.sendRedirect("customers.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}
