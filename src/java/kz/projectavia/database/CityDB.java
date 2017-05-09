package kz.projectavia.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.spr.objects.City;
import kz.projectavia.spr.objects.Country;

/*Класс для работы с стаблицей БД http://localhost:3306/avia.spr_city, 
будет возвращать объект типа City родительскому классу. Singleton Pattern.*/

public class CityDB extends AbstractObjectDB<City> {

    public final static String TABLE_SPR_CITY = "spr_city";

    private CityDB() {
        super(TABLE_SPR_CITY);
    }
    private static CityDB instance;

    //публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static CityDB getInstance() {
        //ленивая инициализация
        if (instance == null) {
            instance = new CityDB();
        }
        return instance;
    }

    //подготовленный запрос для получения города по его названию
   
    public PreparedStatement getStmtByName(String name) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("select * from " + TABLE_SPR_CITY + " where name=?");
        stmt.setString(1, name);
        return stmt;
    }

    
    //заполнение полей объекта city
    
    @Override
    public City fillObject(ResultSet rs) throws SQLException {
        City city = new City();
        city.setId(rs.getLong("id"));
        city.setCode(rs.getString("code"));

        Country country = CountryDB.getInstance().executeObject(CountryDB.getInstance().getObjectByID(rs.getLong("country_id")));
        
        city.setCountry(country);
        city.setDesc(rs.getString("desc"));
        city.setName(rs.getString("name"));
        return city;
    }

   
}
