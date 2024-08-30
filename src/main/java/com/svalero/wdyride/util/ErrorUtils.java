package com.svalero.wdyride.util;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ErrorUtils {

    // Método que envía un mensaje de error en formato HTML
    public static void sendError(String message, HttpServletResponse response) throws IOException {
        response.getWriter().println("<div class='alert alert-danger' role='alert'>" + message + "</div>");
    }

    // Método que envía un mensaje de éxito en formato HTML
    public static void sendMessage(String message, HttpServletResponse response) throws IOException {
        response.getWriter().println("<div class='alert alert-success' role='alert'>" + message + "</div>");
    }
}
