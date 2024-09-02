package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.CustomerDao;
import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.dao.RentsDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/remove-rent")

public class RemoveRent extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String RENT_ID = request.getParameter("RENT_ID");

        try {
            Database.connect();
            int affectedRows = Database.jdbi.withExtension(RentsDao.class,
                    dao -> dao.removeRENT(Integer.parseInt(RENT_ID)));
            response.sendRedirect("rents.jsp");
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }
}
