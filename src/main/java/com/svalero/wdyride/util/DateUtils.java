package com.svalero.wdyride.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import static com.svalero.wdyride.util.Constants.DATE_PATTERN;

public class DateUtils {

    public static String format(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
        dateFormat.format(date);
        return dateFormat.format(date);
    }

    public static Date parse(String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat(DATE_PATTERN);
        return new Date(dateFormat.parse(date).getTime());
    }
}
