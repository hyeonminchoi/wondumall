package com..DTO;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@NoArgsConstructor

public class BoardDTO {
	private int b_no, cate_no, u_no, b_count, b_like, b_del, b_commentCount;
	private String b_date;
	
	@NonNull
	private String b_title, b_content, u_nickname;
}
