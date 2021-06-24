package com.lyf.utils;

import com.lyf.entity.Survey;
import com.lyf.mapper.SurveyDao;
import com.lyf.service.SurveyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import java.util.List;

@EnableScheduling
public class ScheduleTask {

    @Autowired
    private SurveyService surveyService;
    /**
     * 调查问卷状态的任务
     */
    @Scheduled(fixedRate=500000000)
//    @Scheduled(cron = "* * */1 * * ?")
    public void state(){
        //System.out.println("轮询一次");
        surveyService.updateState();
    }

}
