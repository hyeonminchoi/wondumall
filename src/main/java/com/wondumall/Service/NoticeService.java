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

	public int getCount(Map<String, Object> map) {
		return noticeDAO.getCount(map);
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

	public void countUp(int n_no) {
		noticeDAO.countUp(n_no);
	}

	public int containLike(NoticeDTO noticeDTO) {
		return noticeDAO.containLike(noticeDTO);
	}

	public void deleteLike(NoticeDTO noticeDTO) {
		noticeDAO.deleteLike(noticeDTO);
	}

	public void insertLike(NoticeDTO noticeDTO) {
		noticeDAO.insertLike(noticeDTO);
	}

	public int like(int n_no) {
		return noticeDAO.like(n_no);
	}

	public void updateLike(int n_no) {
		noticeDAO.updateLike(n_no);
	}
	
	
}
