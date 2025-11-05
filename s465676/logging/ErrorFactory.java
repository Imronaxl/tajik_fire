package org.ITMO.s465676.logging;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ErrorFactory {
    public static final String BAD_REQUEST = "Bad Request";

    public static void feedbackError(HttpServletRequest req, HttpServletResponse res, int status, String title, String msg) throws ServletException, IOException {
        res.setStatus(status);
        req.setAttribute("javax.servlet.error.status_code", status);
        req.setAttribute("javax.servlet.error.message", msg);
        req.setAttribute("javax.servlet.error.exception_type", title);
        req.getRequestDispatcher("/error.jsp").forward(req, res);
    }
}

