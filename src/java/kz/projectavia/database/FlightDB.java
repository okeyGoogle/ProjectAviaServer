package kz.projectavia.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.objects.Flight;
import kz.projectavia.spr.objects.Aircraft;
import kz.projectavia.spr.objects.City;
import kz.projectavia.spr.objects.Place;
import kz.projectavia.utilsclasses.GMTCalendar;


//Класс для работы с стаблицей БД http://localhost:3306/avia.spr_flight. Singleton Pattern.

public class FlightDB extends AbstractObjectDB<Flight> {
    
    //определяется таблица с которой будет работать объект
    public final static String TABLE_FLIGHT = "flight";
    
    private FlightDB() {
        super(TABLE_FLIGHT);
    }
        
    private static FlightDB instance;

    //публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static FlightDB getInstance() {
        //ленивая инициализация
        if (instance == null) {
            instance = new FlightDB();
        }

        return instance;
    }
    
    //константы для вывод значений времени
    private static final String MIN = " мин.";
    private static final String HOUR = " ч.  ";
    private static final String DAY = " д.  ";

    
    //заполнение полей объекта dateCome и объекта dateDepart
    
    @Override
    public Flight fillObject(ResultSet rs) throws SQLException {
        Calendar dateDepart = GMTCalendar.getInstance();
        Calendar dateCome = GMTCalendar.getInstance();

        dateDepart.setTimeInMillis(rs.getLong("date_depart"));
        dateCome.setTimeInMillis(rs.getLong("date_come"));
             
        Flight flight = new Flight();             //                
        flight.setId(rs.getLong("id"));           //  
        flight.setCode(rs.getString("code"));     //Заполнение полей объекта flight
        flight.setDateDepart(dateDepart);         //  
        flight.setDateCome(dateCome);             //

        //привязка самолёта к рейсу
        Aircraft aircraft = AircraftDB.getInstance().executeObject(AircraftDB.getInstance().getObjectByID(rs.getLong("aircraft_id")));
        flight.setAircraft(aircraft);
        
        //привязка мест к самолёту + список со свободными и занятыми местами рейса 
        ArrayList<Place> placeList = PlaceDB.getInstance().executeList(PlaceDB.getInstance().getPlaceStmtBusy(aircraft.getId(), flight.getId()));
        aircraft.setPlaceList(placeList);
        
        ArrayList<Place> freePlaceList = new ArrayList<>();
            
          //проверка, если в списке есть хоть одно свободное место, то весь рейс помечаем как рейс с наличием свободный мест
          for (Place place : placeList) {
            if (!place.isBusy()){
                flight.setExistFreePlaces(true);
                freePlaceList.add(place);
            }
        }
                    
        aircraft.setFreePlaceList(freePlaceList);//заполнение коллекции свободными местами
       
        //объектом типа City указывается пункт отправления
        City city_from = CityDB.getInstance().executeObject(CityDB.getInstance().getObjectByID(rs.getLong("city_from_id")));
        flight.setCityFrom(city_from);

        //объектом типа City указывается пункт прибытия
        City city_to = CityDB.getInstance().executeObject(CityDB.getInstance().getObjectByID(rs.getLong("city_to_id")));
        flight.setCityTo(city_to);

        
        //блок программы для расчёта времени длительности полёта 
        
        StringBuilder sb = new StringBuilder();

        
        //высчитываем разницу во времени
        
        int dayDiff = dateCome.get(Calendar.DAY_OF_YEAR) - dateDepart.get(Calendar.DAY_OF_YEAR);
        int hourDiff = dateCome.get(Calendar.HOUR_OF_DAY) - dateDepart.get(Calendar.HOUR_OF_DAY);
        int minDiff = dateCome.get(Calendar.MINUTE) - dateDepart.get(Calendar.MINUTE);

        
        //если эта разница больше нуля то выводим разницу
        
        if (dayDiff > 0) {
            sb.append(dayDiff).append(DAY);
        }

        if (hourDiff > 0) {
            sb.append(hourDiff).append(HOUR);
        }

        if (minDiff > 0) {
            sb.append(minDiff).append(MIN);
        }

        flight.setDuration(sb.toString());

        return flight;
    }
    
    
    /*Запрос рейса по дате + направление полёта, возвращает этот подготовленный 
    запрос и передаёт его родительским методам executeList, executeObject.*/           
    public PreparedStatement getStmt(Calendar dateTime, City cityFrom, City cityTo) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        
        
        //Запрос возвращает результаты - дату вылета и пункты отправления и прибытия.
        
        PreparedStatement stmt = conn.prepareStatement("select * from " + TABLE_FLIGHT + " where date_depart>=? and  date_depart<? and city_from_id=? and city_to_id=?");


        // значение dateTime обнуляется, оставляется только дата, чтобы искать рейсы за все 24 часа
        
        dateTime.set(Calendar.HOUR_OF_DAY, 0);
        dateTime.set(Calendar.MINUTE, 0);
        dateTime.set(Calendar.SECOND, 0);
        dateTime.set(Calendar.MILLISECOND, 0);


        /* Для поиска рейсов в пределах суток, создаём ещё один объект типа Calendar с помощью клонирования, 
        в каком после выполнения метода "dateTime.clone()" получаем вышеуказанные значения и прибавляем INTERVAL 
        со значением "1". Далее эти значения мы передаём вверх в запрос stmt, в зависимости от того как будет реализован интерфейс. */
        
        Calendar dateTimeInterval = (Calendar) (dateTime.clone());
        dateTimeInterval.add(Calendar.DATE, INTERVAL);


        stmt.setLong(1, dateTime.getTimeInMillis());
        stmt.setLong(2, dateTimeInterval.getTimeInMillis());
        stmt.setLong(3, cityFrom.getId());
        stmt.setLong(4, cityTo.getId());
        return stmt;
    }

    /*Запрос рейса по дате вылета, возвращает этот подготовленный 
    запрос и передаёт его родительскому методу executeList либо executeObject.*/ 
    public PreparedStatement getStmtByDateDepart(Calendar dateDepart) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("select * from " + TABLE_FLIGHT + " where date_from>=? and  date_depart<?");


        // оставить только дату, чтобы искать рейсы за все 24 часа        
        clearTime(dateDepart);

        
        //в каком интервали искать (по-умолчанию - в пределах суток)        
        Calendar dateTimeInterval = (Calendar) (dateDepart.clone());
        dateTimeInterval.add(Calendar.DATE, INTERVAL);


        stmt.setLong(1, dateDepart.getTimeInMillis());
        stmt.setLong(2, dateTimeInterval.getTimeInMillis());
        return stmt;
    }

   
  
    
}
