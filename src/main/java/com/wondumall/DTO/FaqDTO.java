package com.wondumall.DTO;

import lombok.Data;

@Data
public class FaqDTO {
	private int faq_no, u_no, fc_no;
	private String faq_question, faq_answer, faq_date, u_nickname, fc_category;
}
