package com.svalero.wdyride.dao;

import com.svalero.wdyride.domain.Bike;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;

public class BikeMapper implements RowMapper<Bike> {
    @Override
    public Bike map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Bike(rs.getString("SERIAL_NUMBER"),
                rs.getString("CONDITION"),
                rs.getString("BRAND"),
                rs.getString("MODEL"),
                rs.getString("PICTURE"));
    }
}
