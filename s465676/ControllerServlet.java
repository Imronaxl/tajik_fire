package org.ITMO.s465676;

import jakarta.servlet.http.HttpSession;
import org.ITMO.s465676.logging.AppLog;
import org.ITMO.s465676.exceptions.InputFault;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.ITMO.s465676.validators.ParametersChecker;

import java.io.IOException;

@WebServlet("/controller")
public class ControllerServlet extends HttpServlet {
    public ControllerServlet(){}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) {
        try {
            process(req, res);
        } catch(ServletException | IOException e) {
            AppLog.error(ControllerServlet.class, e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        try {
            process(req, res);
        } catch(ServletException | IOException e) {
            AppLog.error(ControllerServlet.class, e.getMessage(), e);
        }
    }

    private void process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String x = req.getParameter("x");
        String y = req.getParameter("y");
        String R = req.getParameter("r"); 
        if (x != null && !x.isEmpty() && y != null && !y.isEmpty() && R != null && !R.isEmpty()) {
            try {
                ParametersChecker.checkParams(x, y, R);
                res.sendRedirect(req.getContextPath() + "/area-check?x=" + x + 
                               "&y=" + y + "&r=" + R);
            } catch(InputFault e) {
                req.setAttribute("errorMessage", e.getMessage());
                RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
                dispatcher.forward(req, res);
            }
        } else {
            req.setAttribute("errorMessage", "Отсутствуют параметры X, Y или R.");
            RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, res);
        }
    }
}





