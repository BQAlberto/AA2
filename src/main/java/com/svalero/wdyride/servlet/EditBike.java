package com.svalero.wdyride.servlet;

import com.svalero.wdyride.dao.Database;
import com.svalero.wdyride.dao.BikeDao;
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

@WebServlet("/edit-bike")
@MultipartConfig
public class EditBike extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession currentSession = request.getSession();
        if (currentSession.getAttribute("ROLE") == null || !currentSession.getAttribute("ROLE").equals("ADMIN")) {
            response.sendRedirect("/wdyRide");
            return;  // Exit the method if the user is not an admin
        }

        try {
            // Verifica si el SERIAL_NUMBER está vacío
            String SERIAL_NUMBER = request.getParameter("SERIAL_NUMBER");
            if (SERIAL_NUMBER == null || SERIAL_NUMBER.isBlank()) {
                sendError("Serial Number is required", response);
                return;
            }

            // Verifica si el MODEL está vacío
            String MODEL = request.getParameter("MODEL");
            if (MODEL == null || MODEL.isBlank()) {
                sendError("Model is required", response);
                return;
            }

            // Obtiene los demás parámetros de la solicitud
            String CONDITION = request.getParameter("CONDITION");
            String BRAND = request.getParameter("BRAND");
            Part PICTUREPART = request.getPart("PICTURE");

            String imagePath = request.getServletContext().getInitParameter("image-path");
            String filename = null;
            if (PICTUREPART.getSize() == 0) {
                filename = "no-image.jpg";
            } else {
                filename = UUID.randomUUID() + ".jpg";
                InputStream fileStream = PICTUREPART.getInputStream();
                Files.copy(fileStream, Path.of(imagePath + File.separator + filename));
            }

            // Conecta a la base de datos y busca una bicicleta existente
            Database.connect();
            final Bike existingBike = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBike(SERIAL_NUMBER));
            final String finalFilename = filename;

            if (existingBike == null) {
                // Inserta una nueva bicicleta si no existe
                final int affectedRows = Database.jdbi.withExtension(BikeDao.class,
                        dao -> dao.addBike(SERIAL_NUMBER, CONDITION, BRAND, MODEL, finalFilename));
                if (affectedRows > 0) {
                    sendMessage("Bike added successfully!", response);
                } else {
                    sendError("Failed to add bike", response);
                }
            } else {
                // Actualiza la bicicleta existente
                final int affectedRows = Database.jdbi.withExtension(BikeDao.class,
                        dao -> dao.updateBike(CONDITION, BRAND, MODEL, finalFilename, SERIAL_NUMBER));
                if (affectedRows > 0) {
                    sendMessage("Bike modified successfully!", response);
                } else {
                    sendError("Failed to modify bike", response);
                }
            }

        } catch (ClassNotFoundException cncfe) {
            cncfe.printStackTrace();
            sendError("Internal server error", response);
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            sendError("Database error", response);
        }
    }
}