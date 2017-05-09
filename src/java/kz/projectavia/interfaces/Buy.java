package kz.projectavia.interfaces;

import kz.projectavia.objects.Flight;
import kz.projectavia.objects.Passenger;
import kz.projectavia.spr.objects.Place;



public interface Buy {
    
    boolean buyTicket(Flight flight, Place place, Passenger passenger, String addInfo);

}
