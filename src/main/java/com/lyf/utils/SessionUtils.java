package com.lyf.utils;

import com.lyf.entity.Admin;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessionUtils {

    private static final String key = "admin";

    public static void setAdmin(HttpServletRequest request, Admin admin){
        request.getSession().setAttribute(key,admin);
    }

    public static Admin getAdmin(HttpServletRequest request){
        if(request.getSession().getAttribute(key) != null){
            return (Admin) request.getSession().getAttribute(key);
        }else{
            return null;
        }
    }

    public static void setCookie(HttpServletResponse response, Cookie cookie) {
        response.addCookie(cookie);
    }
}
