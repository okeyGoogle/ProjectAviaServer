package kz.projectavia.spr.objects;

import javax.xml.bind.annotation.XmlMimeType;

//Bean Country (Представление таблицы http://localhost:3306/avia.spr_country) 

public class Country {

    private long id;
    private String name;
    private String desc;
    

    private byte[] flag; // формат byte для хранения изображения флага 
    private String code;

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

    public byte[] getFlag() {
        return flag;
    }

    public void setFlag(byte[] flag) {
        this.flag = flag;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

   
    
    
}
