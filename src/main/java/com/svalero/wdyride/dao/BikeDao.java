package com.svalero.wdyride.dao;

import com.svalero.wdyride.domain.Bike;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface BikeDao {
    @SqlQuery("SELECT * FROM BIKE")
    @UseRowMapper(BikeMapper.class)
    List<Bike>getBikes();

    @SqlQuery("SELECT * FROM BIKE WHERE SERIAL_NUMBER = ?")
    @UseRowMapper(BikeMapper.class)
    Bike getBike(String SERIAL_NUMBER);

    @SqlUpdate("INSERT INTO BIKE (SERIAL_NUMBER, CONDITION, BRAND, MODEL, PICTURE) VALUES (?, ?, ?, ?, ?)")
    int addBike(String SERIAL_NUMBER, String CONDITION, String BRAND, String MODEL, String PICTURE);

    @SqlUpdate("UPDATE BIKE SET CONDITION = ?, BRAND = ?, MODEL = ?, PICTURE = ? WHERE SERIAL_NUMBER = ?")
    int updateBike(String SERIAL_NUMBER, String CONDITION, String BRAND, String MODEL, String PICTURE);

    @SqlUpdate("DELETE FROM BIKE WHERE SERIAL_NUMBER = ?")
    int removeBike(String SERIAL_NUMBER);
}
