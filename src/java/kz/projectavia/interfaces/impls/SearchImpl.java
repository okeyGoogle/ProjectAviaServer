package kz.projectavia.interfaces.impls;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jws.WebService;
import kz.projectavia.database.CityDB;
import kz.projectavia.database.FlightDB;
import kz.projectavia.interfaces.Search;
import kz.projectavia.objects.Flight;
import kz.projectavia.spr.objects.City;
import kz.projectavia.utilsclasses.GMTCalendar;

//реализация сервиса Search
public class SearchImpl implements Search {
    
    private FlightDB flightDB = FlightDB.getInstance();
    private CityDB cityDB = CityDB.getInstance();

    
    //реализация метода "searchFlight()"
    @Override
    public ArrayList<Flight> searchFlight(long date, City cityFrom, City cityTo) {
        
        //создаём пустой список для того чтобы он возвращался пустым если не будет найдено записей
        ArrayList<Flight> list = new ArrayList<>();
        
        
        try {
            Calendar c = GMTCalendar.getInstance();//из формата long переменной "date" преобразует в формат календарь
            c.setTimeInMillis(date);//метод позволяющий задать дату вылета
            
            /* В метод "getStmt()" передаются значения даты вылета и направление полёта, 
            которые были указанны пользователем, после чего найденные элементы добавляем в коллекцию. */
            list.addAll(flightDB.executeList(flightDB.getStmt(c, cityFrom, cityTo)));
        } catch (SQLException ex) {
            Logger.getLogger(SearchImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return list;
    }    

    //получить все имеющиеся в БД города
    @Override
    public ArrayList<City> getAllCities() {
        ArrayList<City> list = new ArrayList<>();
        
            try {
            
            list.addAll(cityDB.executeList(cityDB.getAllObjects()));
        } catch (SQLException ex) {
            Logger.getLogger(SearchImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return list;
    }

    
}
