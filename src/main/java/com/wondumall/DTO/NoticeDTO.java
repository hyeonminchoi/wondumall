package com.wondumall.DTO;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@RequiredArgsConstructor
@NoArgsConstructor
public class NoticeDTO {
	private int n_no, n_count, n_like, u_no, n_commentCount;
	private String n_date;
	
	@NonNull
	private String n_title, n_content, u_nickname;
}
