package kz.projectavia.spr.objects;

import java.util.List;


//Bean Aircraft (Представление таблицы http://localhost:3306/avia.spr_aircraft)

public class Aircraft {

    
    private long id;
    private String name;
    private String desc;
    private List<Place> placeList;
    private List<Place> freePlaceList;
    private Company company;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public int getPlaceCount() {
        return getPlaceList().size();
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public List<Place> getPlaceList() {
        return placeList;
    }

    public void setPlaceList(List<Place> placeList) {
        this.placeList = placeList;
    }

    public List<Place> getFreePlaceList() {
        return freePlaceList;
    }

    public void setFreePlaceList(List<Place> freePlaceList) {
        this.freePlaceList = freePlaceList;
    }
    
   
}
