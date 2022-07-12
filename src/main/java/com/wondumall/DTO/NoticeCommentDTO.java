package com..DTO;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@RequiredArgsConstructor
public class NoticeCommentDTO {
	private int nc_no, u_no, n_no;
	private String nc_date;
	
	@NonNull
	private String nc_comment, u_nickname;
}
