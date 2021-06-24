package com.lyf.controller;

import com.lyf.entity.Admin;
import com.lyf.service.AdminService;
import com.lyf.utils.MD5Utils;
import com.lyf.utils.MapControl;
import org.apache.ibatis.annotations.Param;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
//@ResponseBody 支持对象响应到客户端JSON
/**
 * @author zzz
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    /**
     * 采用页面跳转的方式进行（已舍弃）
     * @param admin
     * @return
     */
    @GetMapping("/create")
    public String v_create(Admin admin){
        return "admin/create";
    }

    /**
     * 采用Ajax异步数据加载的方式进行
     * @param admin
     * @return
     */
    @PostMapping("/create")
    @ResponseBody
    public Map<String, Object> create(@RequestBody Admin admin) {
        int result = adminService.create(admin);
        if (result <= 0) {
            return MapControl.getInstance().error().getMap();
        }
        return MapControl.getInstance().success().getMap();
    }

    @PostMapping ("/query")
    @ResponseBody
    public Map<String, Object> query(@RequestBody Admin admin, ModelMap modelMap) {
        List<Admin> list = adminService.query(admin);
        Integer count = adminService.count(admin);
        return MapControl.getInstance().page(list, count).getMap();
    }

    @PostMapping("/delete")
    @ResponseBody
    public Map<String,Object> delete(@RequestBody String ids){
        ids = ids.replaceAll("%5B","").replaceAll("%2C",",").replaceAll("%5D","").replace("=","");
        System.out.println(ids);
        int result = adminService.deleteBatch(ids);
        if(result<=0){
            //失败的情况下
            return MapControl.getInstance().error().getMap();
        }
        return MapControl.getInstance().success().getMap();
    }

    @PostMapping("/update")
    @ResponseBody
    public Map<String, Object> update(@RequestBody Admin admin){
        System.out.println(admin);
        int result = adminService.update(admin);
        if(result<=0){
            //失败的情况下
            return MapControl.getInstance().error().getMap();
        }
        return MapControl.getInstance().success().getMap();
    }

    @GetMapping("/list")
    public String list(){
       return  "admin/list";
    }

    @GetMapping("/detail")
    public String detail(Integer id,ModelMap modelMap){
        Admin admin = adminService.detail(id);
        modelMap.addAttribute("admin",admin);
        return "admin/update";
    }

}
