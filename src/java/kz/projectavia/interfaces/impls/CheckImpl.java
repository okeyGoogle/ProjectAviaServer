package kz.projectavia.interfaces.impls;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import kz.projectavia.database.ReservationDB;
import kz.projectavia.interfaces.Check;
import kz.projectavia.objects.Reservation;


//реализация сервиса Check
public class CheckImpl implements Check{

    private ReservationDB reservDB = ReservationDB.getInstance();

    @Override
    public Reservation checkReservationByCode(String code) {
        Reservation reserv = null;
        try {
            reserv = reservDB.executeObject(reservDB.getStmtByCode(code));
        } catch (SQLException ex) {
            Logger.getLogger(CheckImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return reserv;
    }   

}
