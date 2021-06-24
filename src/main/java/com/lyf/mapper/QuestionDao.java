package com.lyf.mapper;

import java.util.List;
import java.util.Map;

import com.lyf.entity.Question;

public interface QuestionDao {
	public int create(Question pi);
	public int delete(Map<String, Object> paramMap);
	public int update(Map<String, Object> paramMap);
	public List<Question> query(Map<String, Object> paramMap);
	public Question detail(Map<String, Object> paramMap);
	public int count(Map<String, Object> paramMap);
}