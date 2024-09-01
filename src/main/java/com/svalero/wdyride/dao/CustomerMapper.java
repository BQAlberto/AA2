
package com.svalero.wdyride.dao;

import com.svalero.wdyride.domain.Bike;
import com.svalero.wdyride.domain.Customer;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerMapper implements RowMapper<Customer> {

    @Override
    public Customer map(ResultSet rs, StatementContext ctx) throws SQLException {

        return new Customer(rs.getInt("CUSTOMER_ID"),
                rs.getString("FIRST_NAME"),
                rs.getString("LAST_NAME"),
                rs.getString("USERNAME"),
                rs.getString("PASSWORD"),
                rs.getString("ROLE"));
    }
}
