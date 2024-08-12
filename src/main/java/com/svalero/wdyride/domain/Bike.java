package com.svalero.wdyride.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Bike {
    private String SERIAL_NUMBER;
    private String CONDITION;
    private String BRAND;
    private String MODEL;
    private String PICTURE;
}
