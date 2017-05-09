package kz.projectavia.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import kz.projectavia.database.abstracts.AbstractObjectDB;
import kz.projectavia.objects.Flight;
import kz.projectavia.objects.Passenger;
import kz.projectavia.objects.Reservation;
import kz.projectavia.spr.objects.Place;
import kz.projectavia.utilsclasses.GMTCalendar;


//Класс для работы с стаблицей БД http://localhost:3306/avia.reservation. Singleton Pattern.

public class ReservationDB extends AbstractObjectDB<Reservation> {

    public final static String TABLE_RESERVATION = "reservation";

    private ReservationDB() {
        super(TABLE_RESERVATION);
    }
    private static ReservationDB instance;

    //публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static ReservationDB getInstance() {
        //ленивая инициализация
        if (instance == null) {
            instance = new ReservationDB();
        }

        return instance;
    }

    //метод реализующий бронирование места
    public PreparedStatement getInsertStmt(Reservation reservation) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("insert into "+TABLE_RESERVATION+"(flight_id, passenger_id, place_id, add_info, reserve_datetime, code) values (?,?,?,?,?,?)");
        stmt.setLong(1, reservation.getFlight().getId());
        stmt.setLong(2, reservation.getPassenger().getId());
        stmt.setLong(3, reservation.getPlace().getId());
        stmt.setString(4, reservation.getAddInfo());
        stmt.setLong(5, reservation.getReserveDateTime().getTimeInMillis());
        stmt.setString(6, reservation.getCode());
        return stmt;
    }
    
    //метод для получения информации о резерве по номеру документа
     public PreparedStatement getStmtByDocumentNumber(String docNumber) throws SQLException {
        
        Connection conn = AviaDB.getInstance().getConnection();
        
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * FROM reservation r inner join passenger p on p.id=r.passenger_id ");
        sb.append(" where p.document_number=?");
        
        PreparedStatement stmt = conn.prepareStatement(sb.toString());
        stmt.setString(1, docNumber);
        
        return stmt;
    }
    
     //метод для получения информации о резерве по фамилии
     public PreparedStatement getStmtByFamilyName(String familyName) throws SQLException {
        
        Connection conn = AviaDB.getInstance().getConnection();
        
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT * FROM reservation r inner join passenger p on p.id=r.passenger_id ");
        sb.append(" where p.family_name=?");
        
        PreparedStatement stmt = conn.prepareStatement(sb.toString());
        stmt.setString(1, familyName);
        
        return stmt;
    }
     
     
      //метод для получения информации о резерве по уникальному номеру брони
      public PreparedStatement getStmtByCode(String code) throws SQLException {
        
        Connection conn = AviaDB.getInstance().getConnection();
        
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM reservation r inner join passenger p on p.id=r.passenger_id where r.code=?");
        stmt.setString(1, code);
        
        return stmt;
    }

      //метод для получения информации о резерве по дате бронирования
       public PreparedStatement getStmtByDateReserv(Calendar dateReserv) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM reservation where reserve_datetime>=? and  reserve_datetime<?");


        // оставить только дату
        clearTime(dateReserv);

        // в каком интервали искать (по-умолчанию - в пределах суток)
        Calendar dateTimeInterval = (Calendar) (dateReserv.clone());
        dateTimeInterval.add(Calendar.DATE, INTERVAL);


        stmt.setLong(1, dateReserv.getTimeInMillis());
        stmt.setLong(2, dateTimeInterval.getTimeInMillis());
        return stmt;
    } 
      
    //заполнение полей объекта reservation  
    @Override
    public Reservation fillObject(ResultSet rs) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setId(rs.getLong("id"));

        Flight flight = FlightDB.getInstance().executeObject(FlightDB.getInstance().getObjectByID(rs.getLong("flight_id")));
        reservation.setFlight(flight);

        Passenger passenger = PassengerDB.getInstance().executeObject(PassengerDB.getInstance().getObjectByID(rs.getLong("passenger_id")));
        reservation.setPassenger(passenger);

        Place place = PlaceDB.getInstance().executeObject(PlaceDB.getInstance().getObjectByID(rs.getLong("place_id")));
        reservation.setPlace(place);

        Calendar c = GMTCalendar.getInstance();
        c.setTimeInMillis(rs.getLong("reserve_datetime"));

        reservation.setReserveDateTime(c);

        reservation.setCode(rs.getString("code"));
        reservation.setAddInfo(rs.getString("add_info"));

        return reservation;
    }


    
}
