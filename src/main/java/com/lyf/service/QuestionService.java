package com.lyf.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInterceptor;
import com.google.common.base.Splitter;
import com.google.common.collect.Maps;
import com.lyf.entity.Question;
import com.lyf.entity.QuestionOpt;
import com.lyf.mapper.QuestionDao;
import com.lyf.mapper.QuestionOptDao;
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
public class QuestionService {
    @Autowired
    private QuestionDao questionDao;

    @Autowired
    private QuestionOptDao questionOptDao;

    public int create(Question pi){
        int flag = 0;
        if(pi.getId() != null){
            flag = this.update(pi);
            questionOptDao.delete(MapParameter.getInstance().add("questionId",pi.getId()).getMap());
        }else{
            flag = questionDao.create(pi);
        }
        if(flag>0){
            List<QuestionOpt> options = pi.getOptions();
            int i = 0;
            for (QuestionOpt option : options) {
                option.setSurveyId(pi.getSurveyId());
                option.setQuestionId(pi.getId());
                option.setOrderby(++i);
                questionOptDao.create(option);
            }
        }
        return pi.getId();
    }

    public int delete(Integer id) {
        return questionDao.delete(MapParameter.getInstance().addId(id).getMap());
    }

    /**
     * 批量删除
     * @param ids
     * @return
     */
    public int deleteBatch(String ids) {
        List<String> list = Splitter.on(",").splitToList(ids);
        int flag = 0;
        for (String s : list) {
            questionDao.delete(MapParameter.getInstance().addId(Integer.parseInt(s)).getMap());
            questionOptDao.delete(MapParameter.getInstance().add("questionId", Integer.parseInt(s)).getMap());
            flag ++;
        }
        return flag;
    }

    public int update(Question question) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMapForUpdate(question)).addId(question.getId()).getMap();
        return questionDao.update(paramMap);
    }

    public List<Question> query(Question question){
        //仅仅查询的问题
        Map<String, Object> map = MapParameter.getInstance().put(BeanMapUtils.beanToMap(question)).getMap();
        List<Question> questionList = questionDao.query(map);
        List<QuestionOpt> optList = questionOptDao.query(MapParameter.getInstance().add("surveyId", question.getSurveyId()).getMap());
        for (Question question1 : questionList) {
            List<QuestionOpt> options = new ArrayList<>();
            for (QuestionOpt questionOpt : optList) {
                if(question1.getId().intValue() == questionOpt.getQuestionId().intValue()){
                    options.add(questionOpt);
                }
            }
            question1.setOptions(options);
        }
        return questionList;
    }

    public Question detail(Integer id) {
        Map<String, Object> paramMap = MapParameter.getInstance().addId(id).getMap();
        return questionDao.detail(paramMap);
    }

    public int count(Question question) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMap(question)).getMap();
        return questionDao.count(paramMap);
    }

    public Question login(String account, String password) {
        Map<String, Object> paramMap = MapParameter.getInstance().add("account", account).add("password", password).getMap();
        return questionDao.detail(paramMap);
    }
}

