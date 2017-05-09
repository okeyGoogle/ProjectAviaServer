package kz.projectavia.webservice;

import java.util.ArrayList;
import java.util.Calendar;
import javax.jws.WebService;
import javax.xml.ws.BindingType;
import javax.xml.ws.soap.MTOM;
import javax.xml.ws.soap.SOAPBinding;
import kz.projectavia.interfaces.Buy;
import kz.projectavia.interfaces.Check;
import kz.projectavia.interfaces.Search;
import kz.projectavia.interfaces.impls.BuyImpl;
import kz.projectavia.interfaces.impls.CheckImpl;
import kz.projectavia.interfaces.impls.SearchImpl;
import kz.projectavia.objects.Flight;
import kz.projectavia.objects.Passenger;
import kz.projectavia.objects.Reservation;
import kz.projectavia.spr.objects.City;
import kz.projectavia.spr.objects.Place;
import kz.projectavia.utilsclasses.GMTCalendar;


@MTOM //отправка SOAP сообщений с использованием MIME part (для передачи изображений флагов стран)
@WebService(serviceName = "SearchWS")//аннотация указывающая на класс реализующий веб-сервис
@BindingType(value = SOAPBinding.SOAP12HTTP_MTOM_BINDING) //Постоянное представление идентификационных данных SOAP 1.2 по HTTP-связыванию с MTOM

//в этом классе объедены все реализации интерфейсов сервиса для веб-службы
public class SearchWS implements Search, Buy, Check {

    private SearchImpl searchImpl = new SearchImpl();
    private BuyImpl buyImpl = new BuyImpl();
    private CheckImpl checkImpl = new CheckImpl();

    //все методы класса являются веб- методами службы
      
    @Override
    public ArrayList<Flight> searchFlight(long date, City cityFrom, City cityTo) {

        ArrayList<Flight> list = new ArrayList<>();
        Calendar c = GMTCalendar.getInstance();
        c.setTimeInMillis(date);

        list.addAll(searchImpl.searchFlight(date, cityFrom, cityTo));

        return list;
    }

    @Override
    public ArrayList<City> getAllCities() {
        ArrayList<City> list = new ArrayList<>();
        list.addAll(searchImpl.getAllCities());
        return list;
    }

    @Override
    public boolean buyTicket(Flight flight, Place place, Passenger passenger, String addInfo) {
        boolean result = false;

        result = buyImpl.buyTicket(flight, place, passenger, addInfo);

        return result;
    }

    @Override
    public Reservation checkReservationByCode(String code) {
        return checkImpl.checkReservationByCode(code);
    }
}
