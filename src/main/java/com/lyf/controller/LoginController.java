package com.lyf.controller;

import com.google.common.base.Strings;
import com.lyf.entity.Admin;
import com.lyf.service.AdminService;
import com.lyf.utils.MD5Utils;
import com.lyf.utils.MapControl;
import com.lyf.utils.MapParameter;
import com.lyf.utils.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    private AdminService adminService;


    @GetMapping("/login")
    public String v_login() {
        return "login";
    }


    /**
     * 前端提交的是json对象的字符串，后端如何转换为对象或map对象
     * @param map
     * @param request
     * @return
     */
    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(@RequestBody Map<String, Object> map, HttpServletRequest request, HttpServletResponse response){
        String account = map.get("account") + "";
        String password = map.get("password") + "";
        String rememberMe = map.get("rememberMe") + "";
        Boolean re = Boolean.parseBoolean(rememberMe);
        if (Strings.isNullOrEmpty(account) || Strings.isNullOrEmpty(password)) {
            return MapControl.getInstance().error("账号或密码不能为空").getMap();
        }
        Admin admin = adminService.login(account, MD5Utils.getMD5(password));
        if (admin != null) {
            SessionUtils.setAdmin(request, admin);
            if (re) {
                Cookie cookie = new Cookie("user", account + "," + password);
                cookie.setMaxAge(30 * 24 * 60 * 60);
                cookie.setPath("/");
                SessionUtils.setCookie(response, cookie);
                return MapControl.getInstance().success("登录成功").getMap();
            } else {
                return MapControl.getInstance().success("登陆成功").getMap();
            }

        } else {
            return MapControl.getInstance().error("账号或密码错误").getMap();
        }

    }

}
