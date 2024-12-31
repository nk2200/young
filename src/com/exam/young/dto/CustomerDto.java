package com.exam.young.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class CustomerDto {
	private String customerid;
    private String customerName;
    private String password;
    private String customerAddress;
}
