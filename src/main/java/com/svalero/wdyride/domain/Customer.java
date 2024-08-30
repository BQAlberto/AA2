package com.svalero.wdyride.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Customer {
    private int CUSTOMER_ID;
    private String FIRST_NAME;
    private String LAST_NAME;
    private String USERNAME;
    private String PASSWORD;
    private String ROLE;
}
