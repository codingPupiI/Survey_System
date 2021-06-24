package com.lyf.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInterceptor;
import com.google.common.base.Splitter;
import com.google.common.collect.Maps;
import com.lyf.entity.Admin;
import com.lyf.mapper.AdminDao;
import com.lyf.utils.BeanMapUtils;
import com.lyf.utils.MapParameter;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.jws.Oneway;
import javax.management.ObjectName;
import java.util.*;
import java.util.Map;

/**
 * @program: survey
 * @description:
 * @author: Leng
 **/
@Service
@Transactional(rollbackFor = Exception.class)
public class AdminService {
    @Autowired
    private AdminDao adminDao;

    public int create(Admin admin) {
        return adminDao.create(admin);
    }

    public int delete(Integer id) {
        return adminDao.delete(MapParameter.getInstance().addId(id).getMap());
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    public int deleteBatch(String ids) {
        List<String> list = Splitter.on(",").splitToList(ids);
        System.out.println("搁这3");
        int flag = 0;
        for (String s : list) {
            adminDao.delete(MapParameter.getInstance().addId(Integer.parseInt(s)).getMap());
            flag ++;
        }
        System.out.println("搁这4");
        return flag;
    }

    public int update(Admin admin) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMapForUpdate(admin)).addId(admin.getId()).getMap();
        return adminDao.update(paramMap);
    }

    public List<Admin> query(Admin admin) {
        PageHelper.startPage(admin.getPage(), admin.getLimit());
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMap(admin)).getMap();
        return adminDao.query(paramMap);
    }

    public Admin detail(Integer id) {
        Map<String, Object> paramMap = MapParameter.getInstance().addId(id).getMap();
        return adminDao.detail(paramMap);
    }

    public int count(Admin admin) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMap(admin)).getMap();
        return adminDao.count(paramMap);
    }

    public Admin login(String account, String password) {
        Map<String, Object> paramMap = MapParameter.getInstance().add("account", account).add("password", password).getMap();
        return adminDao.detail(paramMap);
    }
}
