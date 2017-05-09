package kz.projectavia.interfaces;

import kz.projectavia.objects.Reservation;



public interface Check {
    
    Reservation checkReservationByCode(String code);

      /*
    После покупки билета, пользователь может вызвать нижеуказанный метод, туда вбить уникальный
    код брони который присвоился ему после резерва и получить значения переменных объекта Reservation, 
    которые он вводил когда вызвал метод buyTicket интерфейса Buy.  
    */
    
}
