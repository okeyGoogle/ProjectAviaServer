package kz.projectavia.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.spr.objects.Country;


//Класс для работы с стаблицей БД http://localhost:3306/avia.spr_country. Singleton Pattern.

public class CountryDB extends AbstractObjectDB<Country> {

    public final static String TABLE_SPR_COUNTRY = "spr_country";

    private CountryDB() {
        super(TABLE_SPR_COUNTRY);
    }
    private static CountryDB instance;
    
    //публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static CountryDB getInstance() {
        //ленивая инициализация
        if (instance == null) {
            instance = new CountryDB();
        }

        return instance;
    }

    //заполнение полей объекта country
    @Override
    public Country fillObject(ResultSet rs) throws SQLException {
        Country country = new Country();
        country.setId(rs.getLong("id"));
        country.setCode(rs.getString("code"));
        country.setFlag(rs.getBytes("flag"));
        country.setDesc(rs.getString("desc"));
        country.setName(rs.getString("name"));
        return country;
    }
}
