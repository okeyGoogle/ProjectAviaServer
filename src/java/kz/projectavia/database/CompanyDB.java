package kz.projectavia.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.spr.objects.Company;


//Класс для работы с стаблицей БД http://localhost:3306/avia.spr_company. Singleton Pattern.

public class CompanyDB extends AbstractObjectDB<Company> {

    
    public final static String TABLE_SPR_COMPANY = "spr_company";

    private CompanyDB() {
        super(TABLE_SPR_COMPANY);
    }
    private static CompanyDB instance;

    //публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static CompanyDB getInstance() {
        //ленивая инициализация
        if (instance == null) {
            instance = new CompanyDB();
        }

        return instance;
    }

    //заполнение полей объекта company
    @Override
    public Company fillObject(ResultSet rs) throws SQLException {
        Company company = new Company();
        company.setId(rs.getLong("id"));
        company.setName(rs.getString("name"));
        company.setDesc(rs.getString("desc"));
        return company;
    }

}
