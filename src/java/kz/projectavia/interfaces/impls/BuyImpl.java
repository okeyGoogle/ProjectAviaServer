package kz.projectavia.interfaces.impls;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import kz.projectavia.database.PassengerDB;
import kz.projectavia.database.ReservationDB;
import kz.projectavia.interfaces.Buy;
import kz.projectavia.objects.Flight;
import kz.projectavia.objects.Passenger;
import kz.projectavia.objects.Reservation;
import kz.projectavia.spr.objects.Place;
import kz.projectavia.utilsclasses.GMTCalendar;

//реализация сервиса Buy
public class BuyImpl implements Buy {
    
    private ReservationDB reservDB = ReservationDB.getInstance();
    private PassengerDB passengerDB = PassengerDB.getInstance();

    @Override
    //выбран тип возвращаемого объекта "boolean" для того чтобы знать - удалось ли записать данные.
    public boolean buyTicket(Flight flight, Place place, Passenger passenger, String addInfo) {

        try {

            Reservation reserv = new Reservation();
            
            //заполняем все поля объекта reserv 
            reserv.setAddInfo(addInfo);
            reserv.setCode(UUID.randomUUID().toString());
            reserv.setPassenger(passenger);

            Calendar c = GMTCalendar.getInstance();
            reserv.setReserveDateTime(c);

            reserv.setPlace(place);
            reserv.setFlight(flight);
            
            int id = passengerDB.insert(passengerDB.getInsertStmt(passenger)); //вставляем пассажира в таблицу "passenger"
            passenger.setId(id); //получаем его id                 
            
            reservDB.insert(reservDB.getInsertStmt(reserv)); //создаём запись о резерве
                        
            //возвращается "true" если всё нормально выполнилось
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(BuyImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        //если возникнет "catch" тогда вернётся "false"
        return false;
    }
}
