package kz.projectavia.spr.objects;


//Bean Place (Представление таблицы http://localhost:3306/avia.spr_place) 

public class Place {

    private long id;
    private String seatLetter;
    private int seatNumber;    
    private FlightClass flightClass;
    private boolean busy;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public FlightClass getFlightClass() {
        return flightClass;
    }

    public void setFlightClass(FlightClass flightClass) {
        this.flightClass = flightClass;
    }

    public String getSeatLetter() {
        return seatLetter;
    }

    public void setSeatLetter(String seatLetter) {
        this.seatLetter = seatLetter;
    }

    public int getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(int seatNumber) {
        this.seatNumber = seatNumber;
    }

    public boolean isBusy() {
        return busy;
    }

    public void setBusy(boolean busy) {
        this.busy = busy;
    }

    
    
 

}
