package org.ITMO.s465676.validators;

import org.ITMO.s465676.exceptions.InputFault;

public class ParametersChecker {
    public static void checkParams(String xStr, String yStr, String rStr) throws InputFault {
        if (xStr == null || yStr == null || rStr == null || xStr.isEmpty() || yStr.isEmpty() || rStr.isEmpty()) {
            throw new InputFault("Отсутствуют параметры X, Y или R.");
        }

        // Проверка длины строкового представления
        if (xStr.length() > 10 || yStr.length() > 10 || rStr.length() > 10) {
            throw new InputFault("Параметры X, Y или R не должны превышать 10 символов.");
        }

        double x, y, R;
        try {
            x = Double.parseDouble(xStr);
            y = Double.parseDouble(yStr);
            R = Double.parseDouble(rStr);
        } catch (NumberFormatException e) {
            throw new InputFault("Неверный формат числа для параметров X, Y или R.");
        }

        // Валидация X: {-4, -3, -2, -1, 0, 1, 2, 3, 4}
        int[] validX = {-4, -3, -2, -1, 0, 1, 2, 3, 4};
        boolean xIsValid = false;
        for (int val : validX) {
            if (x == val) {
                xIsValid = true;
                break;
            }
        }
        if (!xIsValid) {
            throw new InputFault("Координата X должна быть одним из значений: -4, -3, -2, -1, 0, 1, 2, 3, 4.");
        }

        // Валидация Y: [-5, 3]
        if (y < -5 || y > 3) {
            throw new InputFault("Координата Y должна быть в диапазоне [-5, 3].");
        }

        // Валидация R: {1, 1.5, 2, 2.5, 3}
        double[] validR = {1, 1.5, 2, 2.5, 3};
        boolean rIsValid = false;
        for (double val : validR) {
            if (R == val) {
                rIsValid = true;
                break;
            }
        }
        if (!rIsValid) {
            throw new InputFault("Радиус R должен быть одним из значений: 1, 1.5, 2, 2.5, 3.");
        }
    }
}

