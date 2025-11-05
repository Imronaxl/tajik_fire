<%--
  Created by IntelliJ IDEA.
  User: imeon
  Date: 07.10.2025
  Time: 12:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="org.ITMO.s465676.Result" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!doctype html>
<html lang="ru">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Лабораторная работа 2</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif; /* Изменено на стандартный шрифт */
                color: #333;
                line-height: 1.6;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
                overflow-x: hidden; 
            }

            .header {
                width: 90%; 
                max-width: 1200px; 
                margin: 30px auto 40px auto;
                padding: 25px;
                background: linear-gradient(135deg, #4a69bd 0%, #667eea 100%); 
                color: white;
                border-radius: 12px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.25);
                text-align: center;
                position: relative;
                overflow: hidden;
                animation: fadeInDown 1s ease-out;
            }

            .header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(255, 255, 255, 0.1);
                z-index: 1;
                pointer-events: none;
                transform: skewY(-2deg);
                transform-origin: top left;
            }

            .header h1 {
                font-family: serif; 
                font-size: 2.8em; 
                margin-bottom: 12px;
                color: #fff;
                text-shadow: 3px 3px 8px rgba(0,0,0,0.4);
                letter-spacing: 1.5px;
                position: relative;
                z-index: 2;
            }

            .header p {
                font-size: 1.2em;
                margin: 8px 0;
                color: #e0e0e0;
                position: relative;
                z-index: 2;
            }

            .main-container {
                display: flex;
                justify-content: center;
                gap: 30px;
                padding: 0 20px 40px 20px; 
                flex-wrap: wrap;
            }

            .container-panel {
                background: white;
                padding: 35px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.18);
                flex: 1;
                min-width: 350px;
                max-width: 550px;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .container-panel:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
            }

            .container-panel h2 {
                font-size: 2em;
                font-weight: 800;
                color: #2c3e50;
                margin-bottom: 35px;
                text-align: center;
                position: relative;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .container-panel h2::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px; 
                height: 5px; 
                background: linear-gradient(90deg, #667eea, #764ba2);
                border-radius: 3px;
            }

            .form-table {
                width: 100%;
                border-collapse: collapse;
            }

            .form-table td {
                padding: 12px 0; 
                vertical-align: middle;
            }

            .form-table label {
                font-weight: 700;
                color: #4a5568;
                font-size: 1.15em;
                margin-bottom: 8px;
                display: block;
            }

            .radio-group {
                display: flex;
                flex-wrap: wrap;
                gap: 10px; 
                margin-top: 10px;
            }

            .radio-group input[type="radio"] {
                position: absolute;
                opacity: 0;
                cursor: pointer;
            }

            .radio-group label {
                display: block;
                padding: 12px 20px;
                background: #e9ecef; 
                border: 2px solid #ced4da;
                border-radius: 10px; 
                font-weight: 600;
                color: #495057;
                transition: all 0.3s ease;
                min-width: 50px;
                text-align: center;
                cursor: pointer;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .radio-group input[type="radio"]:checked + label {
                background: linear-gradient(135deg, #5672d6 0%, #764ba2 100%); 
                color: white;
                border-color: #5672d6;
                box-shadow: 0 8px 25px rgba(86, 114, 214, 0.5);
                transform: translateY(-3px) scale(1.02);
            }

            .radio-group label:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(86, 114, 214, 0.3);
            }

            .fancy-input {
                width: 100%;
                padding: 12px; 
                border: 2px solid #cce5ff; 
                border-radius: 10px;
                box-sizing: border-box;
                transition: border-color 0.3s ease, box-shadow 0.3s ease, background-color 0.3s ease;
                font-family: Arial, sans-serif;
                font-size: 1.05em;
                background-color: #f8f9fa;
            }

            .fancy-input:focus {
                border-color: #3498db; 
                box-shadow: 0 0 12px rgba(52, 152, 219, 0.6);
                outline: none;
                background-color: #e6f7ff;
            }

            .fancy-input::placeholder {
                color: #8c98a6;
            }

            button[type="submit"] {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%); 
                color: white;
                border: none;
                padding: 14px 30px;
                border-radius: 10px;
                cursor: pointer;
                font-size: 1.2em; 
                font-weight: 700;
                width: 100%;
                transition: all 0.3s ease;
                margin-top: 25px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            }

            button[type="submit"]:hover {
                background: linear-gradient(135deg, #2980b9 0%, #3498db 100%); 
                transform: translateY(-3px) scale(1.02);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            }

            .error {
                color: #e74c3c;
                font-size: 0.95em;
                margin-top: 10px;
                min-height: 1.5em;
                text-align: left;
                font-weight: 600;
            }

            #areaCanvas {
                display: block;
                margin: 25px auto;
                border: 3px solid #e0e0e0; 
                border-radius: 12px;
                background: #ffffff;
                box-shadow: inset 0 0 10px rgba(0,0,0,0.15);
                width: 400px;
                height: 400px;
            }

            .results-wrapper { width: 100%; overflow-x: auto; }
            .results-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 25px;
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden; 
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                table-layout: fixed;
                word-wrap: break-word;
            }

            .results-table th,
            .results-table td {
                border: 1px solid #f0f0f0;
                padding: 12px; 
                text-align: left;
                font-size: 0.95em;
                color: #495057;
            }

            .results-table th {
                background-color: #f8f9fa;
                font-weight: bold;
                color: #2c3e50;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .results-table tr:nth-child(even) {
                background-color: #fefefe;
            }

            .results-table tr:hover {
                background-color: #eef2f7;
                transform: scale(1.005);
                transition: background-color 0.2s ease, transform 0.2s ease;
            }

            .hit {
                color: #28a745; 
                font-weight: 700;
            }

            .miss {
                color: #dc3545; 
                font-weight: 700;
            }

            @media (max-width: 1024px) {
                .header {
                    width: 95%;
                    margin: 20px auto;
                    padding: 20px;
                }
                .main-container {
                    flex-direction: column;
                    align-items: center;
                    gap: 25px;
                }
                .container-panel {
                    max-width: 95%;
                    min-width: 300px;
                    padding: 25px;
                }
                .container-panel h2 {
                    font-size: 1.8em;
                    margin-bottom: 20px;
                }
                .container-panel h2::after {
                    bottom: -10px;
                    width: 60px;
                    height: 4px;
                }
                #areaCanvas {
                    width: 90%;
                    height: auto;
                    max-height: 350px;
                }
                .form-table label {
                    font-size: 1em;
                }
                .radio-group label {
                    padding: 8px 15px;
                    min-width: 40px;
                    font-size: 0.95em;
                }
                button[type="submit"] {
                    padding: 12px 25px;
                    font-size: 1em;
                }
                .results-table th,
                .results-table td {
                    padding: 10px;
                    font-size: 0.85em;
                }
            }

            @media (max-width: 600px) {
                .header {
                    padding: 15px;
                }
                .header h1 {
                    font-size: 1.6em;
                }
                .header p {
                    font-size: 0.9em;
                }
                .container-panel {
                    padding: 15px;
                }
                .container-panel h2 {
                    font-size: 1.5em;
                    margin-bottom: 15px;
                }
                .radio-group {
                    gap: 5px;
                }
                .radio-group label {
                    padding: 6px 10px;
                    min-width: 30px;
                    font-size: 0.85em;
                }
                .fancy-input {
                    padding: 8px;
                    font-size: 0.9em;
                }
                button[type="submit"] {
                    padding: 10px 20px;
                    font-size: 0.95em;
                }
                #areaCanvas {
                    width: 100%;
                    max-height: 250px;
                }
                .results-table th,
                .results-table td {
                    padding: 8px;
                    font-size: 0.75em;
                }
            }

            @keyframes fadeInDown {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <header class="header">
            <h1>Гулахмадзода Имрон • P3232 • Вариант 465676</h1>
        </header>

        <div class="main-container">
            <div class="container-panel">
                <h2>Введите данные точки и радиус</h2>
                <canvas id="areaCanvas" width="400" height="400" class="areas-canvas"></canvas>
                <form id="pointForm" method="post" action="${pageContext.request.contextPath}/controller">
                    <table class="form-table">
                        <tr>
                            <td colspan="2">
                                <c:if test="${not empty errorMessage}">
                                    <div class="error">${errorMessage}</div>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td><label>Координата X:</label></td>
                            <td>
                                <div class="radio-group">
                                    <input type="radio" name="x" value="-4" id="x-4" />
                                    <label for="x-4">-4</label>
                                    <input type="radio" name="x" value="-3" id="x-3" />
                                    <label for="x-3">-3</label>
                                    <input type="radio" name="x" value="-2" id="x-2" />
                                    <label for="x-2">-2</label>
                                    <input type="radio" name="x" value="-1" id="x-1" />
                                    <label for="x-1">-1</label>
                                    <input type="radio" name="x" value="0" id="x0" />
                                    <label for="x0">0</label>
                                    <input type="radio" name="x" value="1" id="x1" />
                                    <label for="x1">1</label>
                                    <input type="radio" name="x" value="2" id="x2" />
                                    <label for="x2">2</label>
                                    <input type="radio" name="x" value="3" id="x3" />
                                    <label for="x3">3</label>
                                    <input type="radio" name="x" value="4" id="x4" />
                                    <label for="x4">4</label>
                                </div>
                                <div id="xErr" class="error"></div>
                            </td>
                        </tr>
                        <tr>
                            <td><label for="y">Координата Y:</label></td>
                            <td>
                                <input type="text" name="y" id="y" class="fancy-input" placeholder="Введите число от -5 до 3" />
                                <div id="yErr" class="error"></div>
                            </td>
                        </tr>
                        <tr>
                            <td><label>Радиус R:</label></td>
                            <td>
                                <div class="radio-group">
                                    <input type="radio" name="r" value="1" id="r1" />
                                    <label for="r1">1</label>
                                    <input type="radio" name="r" value="1.5" id="r1_5" />
                                    <label for="r1_5">1.5</label>
                                    <input type="radio" name="r" value="2" id="r2" />
                                    <label for="r2">2</label>
                                    <input type="radio" name="r" value="2.5" id="r2_5" />
                                    <label for="r2_5">2.5</label>
                                    <input type="radio" name="r" value="3" id="r3" />
                                    <label for="r3">3</label>
                                </div>
                                <div id="rErr" class="error"></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="hidden" name="canvasX" id="canvasX" />
                                <input type="hidden" name="canvasY" id="canvasY" />
                                <button type="button" id="submitBtn">Проверить попадание</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>

            <div class="container-panel">
                <h2>Результаты проверок</h2>
                <div id="respErr" class="error"></div>
                <div class="results-wrapper">
                <table class="results-table">
                    <thead>
                        <tr><th>X</th><th>Y</th><th>R</th><th>Попадание</th><th>Время</th><th>Затрачено (мс)</th></tr>
                    </thead>
                    <tbody id="resultsBody">
                        <c:forEach var="row" items="${sessionScope.history}">
                            <tr>
                                <td>${row.x}</td>
                                <td>${row.y}</td>
                                <td>${row.r}</td>
                                <td class="${row.getIsHit() ? 'hit' : 'miss'}">${row.getIsHit() ? 'Да' : 'Нет'}</td>
                                <td>${row.curTime}</td>
                                <td>${row.execTime}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </div>
            </div>
        </div>

        <input type="hidden" id="initialR" value="${not empty param.r ? param.r : (not empty requestScope.result.r ? requestScope.result.r : (not empty sessionScope.history ? sessionScope.history[0].r : 1))}" />
        <c:if test="${not empty param.y}">
            <input type="hidden" id="paramY" value="${param.y}" />
        </c:if>
        <c:if test="${requestScope.result != null}">
            <div id="resultData" data-x="${requestScope.result.x}" data-y="${requestScope.result.y}" data-hit="${requestScope.result.isHit}"></div>
        </c:if>

        <script src="${pageContext.request.contextPath}/resources/app.js"></script>
        <c:if test="${not empty errorMessage}">
        </c:if>
    </body>
</html>


