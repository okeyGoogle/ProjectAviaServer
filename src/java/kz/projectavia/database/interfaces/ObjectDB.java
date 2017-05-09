package kz.projectavia.database.interfaces;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


//интерфейс для выделения общих методов у объектов

public interface ObjectDB<T> {
    
    //поведение для вставки объекта 
    int insert(PreparedStatement stmt)  throws SQLException;
    
    //поведение для получения одного объекта 
    T executeObject(PreparedStatement stmt) throws SQLException;
    
    //поведение для получения списка объектов, переданного типа <T>
    ArrayList<T> executeList(PreparedStatement stmt) throws SQLException;   

    //поведение для заполнения полей объекта и передачей ему набора результатов (rs)
    T fillObject(ResultSet rs) throws SQLException;
    
    //запрос на поиск объекта по id
    PreparedStatement getObjectByID(long id) throws SQLException;
    
    //запрос на поиск всех объектов
    PreparedStatement getAllObjects() throws SQLException;
    
}
