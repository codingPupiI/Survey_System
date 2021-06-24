package com.lyf.mapper;

import java.util.List;
import java.util.Map;

import com.lyf.entity.Admin;

public interface AdminDao {

    public int create(Admin admin);

    public int delete(Map<String, Object> paramMap);

    public int update(Map<String, Object> paramMap);

    public List<Admin> query(Map<String, Object> paramMap);

    public Admin detail(Map<String, Object> paramMap);

    public int count(Map<String, Object> paramMap);
}