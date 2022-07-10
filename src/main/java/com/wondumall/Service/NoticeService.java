package com..Service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com..DAO.NoticeDAO;
import com..DTO.NoticeDTO;

@Service
public class NoticeService {
	@Autowired private NoticeDAO noticeDAO;

	public int getCount() {
		return noticeDAO.getCount();
	}

	public List<NoticeDTO> getNoticeList(Map<String, Object> map) {
		return noticeDAO.getNoticeList(map);
	}

	public NoticeDTO getDetail(int n_no) {
		return noticeDAO.getDetail(n_no);
	}

	public int write(NoticeDTO noticeDTO) {
		return noticeDAO.write(noticeDTO);
	}

	public int delete(NoticeDTO noticeDTO) {
		return noticeDAO.delete(noticeDTO);
	}

	public int edit(NoticeDTO noticeDTO) {
		return noticeDAO.edit(noticeDTO);
	}
	
	
}
