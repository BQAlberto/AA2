package com.svalero.wdyride.dao;

import com.svalero.wdyride.domain.Bike;
import com.svalero.wdyride.domain.Customer;
import com.svalero.wdyride.domain.Rent;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class RentMapper implements RowMapper<Rent> {

    @Override
    public Rent map(ResultSet rs, StatementContext ctx) throws SQLException {
        Bike SERIAL_NUMBER = Database.jdbi.withExtension(BikeDao.class, dao -> dao.getBike(rs.getString("SERIAL_NUMBER")));
        Customer CUSTOMER_ID = Database.jdbi.withExtension(CustomerDao.class, dao -> dao.getCustomer(rs.getInt("CUSTOMER_ID")));


        return new Rent(rs.getInt("RENT_ID"),
                SERIAL_NUMBER,
                CUSTOMER_ID);
    }
}
