package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.BikeDao;
import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.dao.RentsDao;
import com.svalero.wdyride.domain.Bike;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/rent-bike")

public class RentBike extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String SERIAL_NUMBER = request.getParameter("SERIAL_NUMBER");
        HttpSession session = request.getSession();
        int CUSTOMER_ID = Integer.parseInt(session.getAttribute("CUSTOMER_ID").toString());

        try {
            Database.connect();

            Bike bike = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBike(SERIAL_NUMBER));
            Database.jdbi.withExtension(RentsDao.class, dao -> dao.addRent(SERIAL_NUMBER, CUSTOMER_ID));

            response.sendRedirect("rents.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

    }
}
