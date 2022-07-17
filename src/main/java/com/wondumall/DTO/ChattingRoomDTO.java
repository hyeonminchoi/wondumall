package com..DTO;

import lombok.Data;

@Data
public class ChattingRoomDTO {
	private int room_no, user_no, admin_no, room_count;
	private String room_lastChattingTime, user_nickname, admin_nickname;
}
