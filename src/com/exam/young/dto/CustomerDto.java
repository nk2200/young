package com.exam.young.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CustomerDto {
	private String customerid;
	private String customer_name;
	private String password;
	private String customer_address;
}
