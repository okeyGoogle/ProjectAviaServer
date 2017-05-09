package kz.projectavia.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.spr.objects.Aircraft;
import kz.projectavia.spr.objects.Company;


//Класс для работы с стаблицей БД http://localhost:3306/avia.spr_aircraft. Singleton Pattern.

public class AircraftDB extends AbstractObjectDB<Aircraft> {

    public final static String TABLE_SPR_AIRCRAFT = "spr_aircraft";

    private AircraftDB() {
        super(TABLE_SPR_AIRCRAFT);
    }    
    private static AircraftDB instance;
    
    
    //Публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
            
    public static AircraftDB getInstance() {
        //Ленивая инициализация
        if (instance == null) {
            instance = new AircraftDB();
        }
        return instance;
    }

    
    //Заполнение полей объекта aircraft
    @Override
    public Aircraft fillObject(ResultSet rs) throws SQLException {
        Aircraft aircraft = new Aircraft();
        aircraft.setId(rs.getLong("id"));
        aircraft.setDesc(rs.getString("desc"));
        aircraft.setName(rs.getString("name"));

        Company comp = CompanyDB.getInstance().executeObject(CompanyDB.getInstance().getObjectByID(rs.getInt("company_id")));

        aircraft.setCompany(comp);
        return aircraft;
    }
}
