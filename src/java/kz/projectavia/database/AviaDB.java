package kz.projectavia.database;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//Класс для соединения с БД. Singleton Pattern.
public class AviaDB {

    private static Connection conn;
    private static InitialContext ic;
    private static DataSource ds;
    public static final String JDBC_JNDI = "java:comp/env/jdbc/Avia";

    //Приватный конструктор 
    private AviaDB() {
    }
    private static AviaDB instance;

    //Публичный метод "getInstance()" который возвращает единственный экземпляр на всю программу
    public static AviaDB getInstance() {
        //Ленивая инициализация
        if (instance == null) {
            instance = new AviaDB();
        }

        return instance;
    }


     /*Публичный метод "getConnection()" который создаёт новоё подключение с помощью драйвера 
     если оно равно нулю или оно закрыто.*/
     public Connection getConnection() {

        try {

            if (conn == null || conn.isClosed()) {

                ic = new InitialContext();
                ds = (DataSource) ic.lookup(JDBC_JNDI);
                conn = ds.getConnection();

            }

        } catch (SQLException ex) {
            Logger.getLogger(AviaDB.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
            Logger.getLogger(AviaDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return conn;
    }

    //Публичный метод "closeConnection()" закрывает подключение если оно не равно нулю     
    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                Logger.getLogger(AviaDB.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}


