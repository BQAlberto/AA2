package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.BikeDao;
import com.svalero.wdyride.dao.Database;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/remove-bike")

public class RemoveBike extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String SERIAL_NUMBER = request.getParameter("SERIAL_NUMBER");

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(BikeDao.class,
                    dao -> dao.removeBike(SERIAL_NUMBER));
            response.sendRedirect("index.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }
}
