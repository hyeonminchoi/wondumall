package com.wondumall.DTO;

import lombok.Data;

@Data
public class AnswerDTO {
	private int a_no, u_no, q_no;
	private String a_answer, a_date, u_nickname;
}
