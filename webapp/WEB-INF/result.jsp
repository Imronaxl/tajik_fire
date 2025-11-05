<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.ITMO.s465676.Result" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Результат проверки</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css"/>
    <style>
        body {
            font-family: 'Minecraft 1.1', Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .result-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 80%;
            max-width: 600px;
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 25px;
            font-size: 2em;
        }
        .result-wrapper { width: 100%; overflow-x: auto; }
        .result-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 30px;
            table-layout: fixed;
            word-wrap: break-word;
        }
        .result-table th, .result-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        .result-table th {
            background-color: #e2e8f0;
            font-weight: bold;
        }
        .result-table tr:nth-child(even) {
            background-color: #f8f8f8;
        }
        .hit-yes {
            color: #38a169;
            font-weight: 600;
        }
        .hit-no {
            color: #e53e3e;
            font-weight: 600;
        }
        .back-button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="result-container">
        <h1>Результат проверки точки</h1>

        <c:set var="history" value="${sessionScope.history}" />
        <c:if test="${not empty history}">
            <c:set var="latestResult" value="${history[0]}" />
            <div class="result-wrapper">
            <table class="result-table">
                <tr>
                    <th>Параметр</th>
                    <th>Значение</th>
                </tr>
                <tr>
                    <td>Координата X:</td>
                    <td>${latestResult.x}</td>
                </tr>
                <tr>
                    <td>Координата Y:</td>
                    <td>${latestResult.y}</td>
                </tr>
                <tr>
                    <td>Радиус R:</td>
                    <td>${latestResult.r}</td>
                </tr>
                <tr>
                    <td>Попадание:</td>
                    <td class="${latestResult.isHit ? 'hit-yes' : 'hit-no'}">
                        ${latestResult.isHit ? 'Да' : 'Нет'}
                    </td>
                </tr>
                <tr>
                    <td>Время проверки:</td>
                    <td>${latestResult.curTime}</td>
                </tr>
                <tr>
                    <td>Затрачено времени:</td>
                    <td>${latestResult.execTime} мс</td>
                </tr>
            </table>
            </div>
        </c:if>
        <c:if test="${empty history}">
            <p>Нет данных о последнем запросе.</p>
        </c:if>

        <a href="${pageContext.request.contextPath}/" class="back-button">Вернуться к форме</a>
    </div>
</body>
</html>





