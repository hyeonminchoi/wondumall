package com..DTO;

import lombok.Data;

@Data
public class ChatDTO {
	private int chat_no, u_no, room_no;
	private String chat_msg, chat_date;
}
