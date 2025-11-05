package org.ITMO.s465676.logging;

import org.jboss.logging.Logger;

public class AppLog {
    public static void error(Class<?> clazz, String message, Throwable t) {
        Logger.getLogger(clazz).error(message, t);
    }
}

