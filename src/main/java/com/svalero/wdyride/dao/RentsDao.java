package com.svalero.wdyride.dao;

import com.svalero.wdyride.domain.Customer;
import com.svalero.wdyride.domain.Rent;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.Date;
import java.util.List;

public interface RentsDao {

    @SqlQuery("SELECT * FROM RENTS WHERE CUSTOMER_ID = ?")
    @UseRowMapper(RentMapper.class)
    List<Rent> getRentsByCustomer(int CUSTOMER_ID);

    @SqlQuery("SELECT * FROM RENTS WHERE RENT_ID LIKE '%' || :searchTerm || '%' " +
            "OR SERIAL_NUMBER LIKE '%' || :searchTerm || '%'" + "OR CUSTOMER_ID LIKE '%' || :searchTerm || '%'")
    @UseRowMapper(RentMapper.class)
    List<Rent> getRentsearch(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM RENTS WHERE RENT_ID = ?")
    @UseRowMapper(RentMapper.class)
    Rent getRent(int RENT_ID);

    @SqlUpdate("INSERT INTO RENTS (SERIAL_NUMBER, CUSTOMER_ID) VALUES (?, ?)")
    int addRent(String SERIAL_NUMBER, int CUSTOMER_ID);

    @SqlUpdate("UPDATE RENTS SET SERIAL_NUMER = ? WHERE RENT_ID = ?")
    int updateRent(String SERIAL_NUMBER, int RENT_ID);

    @SqlUpdate("DELETE FROM RENTS WHERE RENT_ID = ?")
    int removeRENT(int RENT_ID);
}
