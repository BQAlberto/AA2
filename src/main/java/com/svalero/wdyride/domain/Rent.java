package com.svalero.wdyride.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;



@Data
@NoArgsConstructor
@AllArgsConstructor

public class Rent {
    private int RENT_ID;
    private Bike SERIAL_NUMBER;
    private Customer CUSTOMER_ID;
}
