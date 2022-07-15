package com..DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class BusinessDAO {
	
	@Autowired
	private SqlSession sqlSession;
}
