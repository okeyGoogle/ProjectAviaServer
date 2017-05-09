package kz.projectavia.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.objects.Flight;
import kz.projectavia.spr.objects.Aircraft;
import kz.projectavia.spr.objects.FlightClass;
import kz.projectavia.spr.objects.Place;

/*Класс для работы с с таблицами БД http://localhost:3306/avia.spr_place, 
и с таблицей http://localhost:3306/avia.spr_aircraft_place. 
Singleton Pattern.*/
public class PlaceDB extends AbstractObjectDB<Place> {


   
    public final static String TABLE_SPR_PLACE = "spr_place";
    public final static String TABLE_SPR_AIRCRAFT_PLACE = "spr_aircraft_place";
    

    private PlaceDB() {
        super(TABLE_SPR_PLACE);
    }
        
    private static PlaceDB instance;

    //публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static PlaceDB getInstance() {
        //ленивая инициализация
        if (instance == null) {
            instance = new PlaceDB();
        }

        return instance;
    }
    
    
    //Получить все места по определённому классу полёта

    public PreparedStatement getStmtByFlightClass(long flightClassId) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("select * from "+TABLE_SPR_PLACE+" where flight_class_id=?");
        stmt.setLong(1, flightClassId);
        return stmt;
    }

    
    /*Получить все места у самолёта по id самолёта, через таблицу "TABLE_SPR_PLACE"
    и промежуточною таблицы "TABLE_SPR_AIRCRAFT_PLACE".*/ 
        
    public PreparedStatement getStmtByAircraftID(long aircraftId) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM "+TABLE_SPR_PLACE+" where id in (select place_id from "+TABLE_SPR_AIRCRAFT_PLACE +" where aircraft_id=?) order by flight_class_id, seat_letter");
        stmt.setLong(1, aircraftId);
        return stmt;
    }
    
    
    //(ТЕСТОВЫЙ МЕТОД) Вставка занятых мест. Если по определённому рейсу и месту есть запись в таблице reservation тогда значение поля "busy" в таблице spr_place равно единицы, иначе нуль.
    
    public PreparedStatement getPlaceStmtBusy(long aircraftId, long flightId) throws SQLException{
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT p.id, p.seat_letter, p.seat_number,p.flight_class_id, " +
            "if ((select r.id from "+ReservationDB.TABLE_RESERVATION+" r where r.flight_id=? and r.place_id=p.id)>1,1,0) as busy " +
            "FROM "+TABLE_SPR_PLACE+" p where id in (select place_id from "+TABLE_SPR_AIRCRAFT_PLACE+" a1 where a1.aircraft_id=?)  order by flight_class_id, seat_letter");
        stmt.setLong(1, flightId);
        stmt.setLong(2, aircraftId);
        return stmt;
    }
    

    //заполнение полей объекта place

    @Override
    public Place fillObject(ResultSet rs) throws SQLException {
        Place place = new Place();
        place.setId(rs.getLong("id"));
        place.setSeatLetter(rs.getString("seat_letter"));
        place.setSeatNumber(rs.getInt("seat_number"));
              
        //проверяем стоит ли в поле "busy" единица если да то возвратиться true иначе false
        try {
            place.setBusy(getBooleanFromInt(rs.getInt("busy"))); //"getBooleanFromInt()" метод родительский который из целого числа возвращает логическое значение
        } catch (Exception e) {
            place.setBusy(false); //по-умолчанию false (место - свободно)
        }
        
        FlightClass fc = FlightClassDB.getInstance().executeObject(FlightClassDB.getInstance().getObjectByID(rs.getInt("flight_class_id")));
        
        place.setFlightClass(fc);
        return place;
    }



}
