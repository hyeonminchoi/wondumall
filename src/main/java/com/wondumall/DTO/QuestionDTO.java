package com.wondumall.DTO;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@NoArgsConstructor
public class QuestionDTO {
	private int q_no, u_no, q_del, q_commentCount;
	private String q_date;
	
	@NonNull
	private String q_title, q_content, u_nickname;
}
