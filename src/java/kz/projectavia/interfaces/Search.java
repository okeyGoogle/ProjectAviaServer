package kz.projectavia.interfaces;

import java.util.ArrayList;
import kz.projectavia.objects.Flight;
import kz.projectavia.spr.objects.City;



public interface Search {
    
    //запрос на поиск по дате и по направлению полёта
    ArrayList<Flight> searchFlight(long date, City cityFrom, City cityTo); 
    /*
    После запроса на поиск получаем коллекцию переменных объекта Flight.
    long - универсален, сможет взаимодействовать с любым форматом программ (Web, C#, Android).
    */
    
    ArrayList<City> getAllCities();

}
