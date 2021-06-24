package com.lyf.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.security.auth.login.CredentialNotFoundException;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner;

@Controller
public class IndexController {

    /**
     * Spring提供了一个org.springframework.core.io.Resource（注意不是javax.annotation.Resource），
     * 它可以像String、int一样使用@Value注入：
     */
    @Value("classpath:init.json")
    private Resource resource;

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping("/menu")
    @ResponseBody
    public void menu(HttpServletResponse response) {
        try {
            File file = resource.getFile();
            FileReader fileReader = new FileReader(file);
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            String string;
            StringBuffer stringBuffer = new StringBuffer();
            while ((string = bufferedReader.readLine()) != null) {
                stringBuffer.append(string);
            }
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(stringBuffer.toString());
            bufferedReader.close();
            fileReader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
