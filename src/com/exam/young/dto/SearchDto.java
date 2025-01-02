package com.exam.young.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor
public class SearchDto {
	private String keyword;
	private String type;
	private int pageNumber;
	private int pageSize;
}
