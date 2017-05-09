package kz.projectavia.utilsclasses;

import java.util.Calendar;
import java.util.TimeZone;

public class GMTCalendar {

    
    //Метод "getInstance()" возвращает объект Calendar в формате часового пояса GMT.
    //P.S. В БД также используется GMT формат.
    
    public static Calendar getInstance() {
        return Calendar.getInstance(TimeZone.getTimeZone("GMT"));
    }

    
    //Метод для распечатки текущего значения календаря
    public static void print(Calendar c) {
        
        int day = c.get(Calendar.DAY_OF_MONTH);
        int month = c.get(Calendar.MONTH);
        int year = c.get(Calendar.YEAR);

        int minute = c.get(Calendar.MINUTE);
        int hour = c.get(Calendar.HOUR);

        System.out.println("Current date is  " + day + "/" + month + "/" + year+"  "+hour + " : " + minute);
    }
}
