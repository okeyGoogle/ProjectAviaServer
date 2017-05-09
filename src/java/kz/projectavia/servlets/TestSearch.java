/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package kz.projectavia.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kz.projectavia.database.CityDB;
import kz.projectavia.database.FlightDB;
import kz.projectavia.database.PassengerDB;
import kz.projectavia.database.PlaceDB;
import kz.projectavia.interfaces.impls.SearchImpl;
import kz.projectavia.objects.Flight;
import kz.projectavia.objects.Passenger;
import kz.projectavia.spr.objects.City;
import kz.projectavia.spr.objects.Place;

//сервлет для тестирования веб-службы
@WebServlet(name = "TestSearch", urlPatterns = {"/TestSearch"})
public class TestSearch extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {

            Flight flight = FlightDB.getInstance().executeObject(FlightDB.getInstance().getObjectByID(1));

            Place place = PlaceDB.getInstance().executeObject(PlaceDB.getInstance().getObjectByID(2));

            Passenger passenger = PassengerDB.getInstance().executeObject(PassengerDB.getInstance().getObjectByID(1));

            City c1 = CityDB.getInstance().executeObject(CityDB.getInstance().getObjectByID(1));
            City c2 = CityDB.getInstance().executeObject(CityDB.getInstance().getObjectByID(2));

            SearchImpl search = new SearchImpl();
            ArrayList<Flight> list = search.searchFlight(1328191800000L,c1, c2);

            System.out.println(list);

      
        } catch (SQLException ex) {
            Logger.getLogger(TestSearch.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
