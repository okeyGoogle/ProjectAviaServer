package kz.projectavia.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.spr.objects.FlightClass;


//Класс для работы с стаблицей БД http://localhost:3306/avia.spr_flight_class. Singleton Pattern.

public class FlightClassDB extends AbstractObjectDB<FlightClass> {

    public final static String TABLE_SPR_FLIGHT_CLASS = "spr_flight_class";

    private FlightClassDB() {
        super(TABLE_SPR_FLIGHT_CLASS);
    }
    private static FlightClassDB instance;

    
    //Публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static FlightClassDB getInstance() {
        //Ленивая инициализация
        if (instance == null) {
            instance = new FlightClassDB();
        }

        return instance;
    }

    
    //Заполнение полей объекта flightClass
    
    @Override
    public FlightClass fillObject(ResultSet rs) throws SQLException {
        FlightClass flightClass = new FlightClass();
        flightClass.setId(rs.getLong("id"));
        flightClass.setName(rs.getString("name"));
        flightClass.setDesc(rs.getString("desc"));
        return flightClass;
    }
    
    
}
