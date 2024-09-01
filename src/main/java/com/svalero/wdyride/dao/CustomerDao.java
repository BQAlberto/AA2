package com.svalero.wdyride.dao;

import com.svalero.wdyride.domain.Bike;
import com.svalero.wdyride.domain.Customer;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.util.List;

public interface CustomerDao {

    @SqlQuery("SELECT * FROM CUSTOMER")
    @UseRowMapper(CustomerMapper.class)
    List<Customer>getAllCustomers();

    @SqlQuery("SELECT * FROM CUSTOMER WHERE USERNAME LIKE '%' || :searchTerm || '%' " +
            "OR FIRST_NAME LIKE '%' || :searchTerm || '%'" + "OR LAST_NAME LIKE '%' || :searchTerm || '%'")
    @UseRowMapper(CustomerMapper.class)
    List<Customer> getCustomersearch(@Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM CUSTOMER WHERE USERNAME = ?")
    @UseRowMapper(CustomerMapper.class)
    Customer getCustomerByUsername(String USERNAME);

    @SqlQuery("SELECT * FROM CUSTOMER WHERE CUSTOMER_ID = ?")
    @UseRowMapper(CustomerMapper.class)
    Customer getCustomer(int CUSTOMER_ID);

    @SqlQuery("SELECT * FROM CUSTOMER WHERE USERNAME = ? AND PASSWORD = SHA1_HASH(?)")
    @UseRowMapper(CustomerMapper.class)
    Customer getCustomer(String USERNAME, String PASSWORD);

    @SqlUpdate("INSERT INTO CUSTOMER (FIRST_NAME, LAST_NAME, USERNAME, PASSWORD, ROLE) VALUES (?, ?, ?, SHA1_HASH(?), ?)")
    int addCustomer(String FIRST_NAME, String LAST_NAME, String USERNAME, String PASSWORD, String ROLE);

    @SqlUpdate("UPDATE CUSTOMER SET FIRST_NAME = ?, LAST_NAME = ?, USERNAME = ?, ROLE = ? WHERE CUSTOMER_ID = ?")
    int updateCustomer(String FIRST_NAME, String LAST_NAME, String USERNAME, String ROLE);

    @SqlUpdate("DELETE FROM CUSTOMER WHERE CUSTOMER_ID = ?")
    int removeCustomer(int CUSTOMER_ID);
}
