package org.ITMO.s465676;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.ITMO.s465676.logging.AppLog;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.LinkedList;
import java.util.List;

@WebServlet("/area-check")
public class AreaCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) {
        try {
            processRequest(req, res);
        } catch(ServletException | IOException e) {
            AppLog.error(AreaCheckServlet.class, e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) {
        try {
            processRequest(req, res);
        } catch (ServletException | IOException e) {
            AppLog.error(AreaCheckServlet.class, e.getMessage(), e);
        }
    }

    private void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String xStr = req.getParameter("x");
        String yStr = req.getParameter("y");
        String rStr = req.getParameter("r");

        if (xStr == null || yStr == null || rStr == null || xStr.isEmpty() || yStr.isEmpty() || rStr.isEmpty()) {
            req.setAttribute("errorMessage", "Отсутствуют параметры X, Y или R.");
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }

        Double x, y, R; 
        try {
            x = Double.parseDouble(xStr);
            y = Double.parseDouble(yStr);
            R = Double.parseDouble(rStr);
        } catch (NumberFormatException ex) {
            req.setAttribute("errorMessage", "Неверный формат числа для параметров X, Y или R.");
            req.getRequestDispatcher("/index.jsp").forward(req, res);
            return;
        }
        boolean hit;
        HttpSession session = req.getSession();
        long start = System.nanoTime();

        if (checkQ1Triangle(x, y, R) || checkQ2Rectangle(x, y, R) || checkQ3Circle(x, y, R)) {
            hit = true;
        } else {
            hit = false;
        }

        long end = System.nanoTime();
        Double calTime = (end - start) / 1000000.0;
        LocalDateTime releaseTime = LocalDateTime.now();
        Result result = new Result(x, y, R, hit, calTime, releaseTime);

        @SuppressWarnings("unchecked")
        List<Result> curHistory;

        try {
            curHistory = (List<Result>)session.getAttribute("history");
            if(curHistory == null) {
                curHistory = new LinkedList<>();
            }
            curHistory.add(0, result); 
            session.setAttribute("history", curHistory);
        } catch(ClassCastException e) {
            curHistory = new LinkedList<>();
            curHistory.add(0, result);
            session.setAttribute("history", curHistory);
        }
        System.out.println("Result: hit=" + hit + ", x=" + x + ", y=" + y + ", R=" + R);
        System.out.println("History size: " + curHistory.size());
        System.out.println("Forwarding to result.jsp");
        
    

        req.setAttribute("result", result); 
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/result.jsp"); 
        dispatcher.forward(req, res);
    }

    // Q1 (x >= 0, y >= 0): Треугольник с вершинами (0,0), (R,0), (0,R/2)
    private boolean checkQ1Triangle(Double x, Double y, Double R) {
        // Условие границы: линия между (R,0) и (0,R/2) => 2*y + x <= R
        return x >= 0 && y >= 0 && (2 * y + x <= R);
    }

    // Q2 (x <= 0, y >= 0): Прямоугольник от x=-R до x=0, от y=0 до y=R/2
    private boolean checkQ2Rectangle(Double x, Double y, Double R) {
        return x <= 0 && y >= 0 && x >= -R && y <= R/2;
    }

    // Q3 (x <= 0, y <= 0): Четверть круга x² + y² <= R²
    private boolean checkQ3Circle(Double x, Double y, Double R) {
        return x <= 0 && y <= 0 && (x * x + y * y <= R * R);
    }

}
