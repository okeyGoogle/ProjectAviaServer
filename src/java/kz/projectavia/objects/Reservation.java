package kz.projectavia.objects;

import java.util.Calendar;
import kz.projectavia.spr.objects.Place;

//Bean Reservation (Представление таблицы http://localhost:3306/avia.reservation)

public class Reservation {

    private long id;
    private Flight flight;
    private Passenger passenger;
    private Place place;
    private String addInfo;
    private Calendar reserveDateTime; // выбран формат Calendar т.к. удобно хранить время и дату
    private String code;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Flight getFlight() {
        return flight;
    }

    public void setFlight(Flight flight) {
        this.flight = flight;
    }

    public Passenger getPassenger() {
        return passenger;
    }

    public void setPassenger(Passenger passenger) {
        this.passenger = passenger;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public String getAddInfo() {
        return addInfo;
    }

    public void setAddInfo(String addInfo) {
        this.addInfo = addInfo;
    }

    public Calendar getReserveDateTime() {
        return reserveDateTime;
    }

    public void setReserveDateTime(Calendar reserveDateTime) {
        this.reserveDateTime = reserveDateTime;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
