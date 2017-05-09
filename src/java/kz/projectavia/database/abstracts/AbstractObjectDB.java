package kz.projectavia.database.abstracts;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import kz.projectavia.database.AviaDB;
import kz.projectavia.database.interfaces.ObjectDB;


/*Абстрактный класс реализующий общий интерфейс ObjectDB для возможности 
использования всех его методов дочерними классами.*/

public abstract class AbstractObjectDB<T> implements ObjectDB<T> {

    public static final int INTERVAL = 1;
    
    //переменная для определения названия таблицы
    private String tableName;

    public AbstractObjectDB(String tableName) {
        this.tableName = tableName;
    }
    
    
    //реализация метода для вставки объекта 
    @Override
    public int insert(PreparedStatement stmt) throws SQLException {
        int result = -1;
        ResultSet rs = null;

        try {
            result = stmt.executeUpdate();

            rs = stmt.getGeneratedKeys(); //
                                          //
            rs.next();                    //вернуть id вставленной записи
            if (rs.isFirst()) {           //  
                result = rs.getInt(1);    // 
            }

            

        } finally {
            if (stmt != null) {
                stmt.close();
            }

            if (rs != null) {
                rs.close();
            }
        }

        return result;
    }


    /*реализация метода для получения списка объектов, возвращает переданный ему список 
    объектов от дочернего класса*/ 
    @Override
    public ArrayList<T> executeList(PreparedStatement stmt) throws SQLException {

        ArrayList<T> list = new ArrayList<>();
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery();

            while (rs.next()) {
                list.add(fillObject(rs));
            }

        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return list;
    }

    
    /*реализация метода для получения одного объекта, возвращает переданный ему объект 
    от дочернего класса*/
    @Override
    public T executeObject(PreparedStatement stmt) throws SQLException {
        T obj = null;
        ResultSet rs = null;

        try {
            rs = stmt.executeQuery();

            rs.next();
            if (rs.isFirst()) {
                obj = fillObject(rs);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }

        return obj;
    }

    
    /*Реализация запроса на поиск объекта по id, при подстановки в SQL запрос имени 
    нужной таблицы "tableName".*/
    @Override
    public PreparedStatement getObjectByID(long id) throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("select * from " + tableName + " where id=?");
        stmt.setLong(1, id);
        return stmt;
    }

    
     /*Реализация запроса на поиск всех объектов, при подстановки в 
     SQL запрос имени нужнойтаблицы "tableName".*/
    @Override
    public PreparedStatement getAllObjects() throws SQLException {
        Connection conn = AviaDB.getInstance().getConnection();
        PreparedStatement stmt = conn.prepareStatement("select * from " + tableName);
        return stmt;
    }

    //Служебный метод "clearTime()", нужен для использования в определённых классах.
    protected void clearTime(Calendar c) {
        c.set(Calendar.HOUR_OF_DAY, 0);
        c.set(Calendar.MINUTE, 0);
        c.set(Calendar.SECOND, 0);
        c.set(Calendar.MILLISECOND, 0);
    }

    //метод "getBooleanFromInt()" который из целого числа возвращает логическое значение
    protected boolean getBooleanFromInt(int number) {
        if (number > 0) {
            return true;
        } else {
            return false;
        }
    }
}
