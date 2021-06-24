package com.lyf.service;

import com.github.pagehelper.PageHelper;
import com.google.common.base.Splitter;
import com.lyf.entity.AnswerOpt;
import com.lyf.entity.AnswerTxt;
import com.lyf.entity.Survey;
import com.lyf.mapper.AnswerOptDao;
import com.lyf.mapper.AnswerTxtDao;
import com.lyf.mapper.SurveyDao;
import com.lyf.utils.BeanMapUtils;
import com.lyf.utils.MapParameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * @program: survey
 * @description:
 * @author: Leng
 **/
@Service
@Transactional(rollbackFor = Exception.class)
public class SurveyService {
    @Autowired
    private SurveyDao surveyDao;

    @Autowired
    private AnswerOptDao answerOptDao;

    @Autowired
    private AnswerTxtDao answerTxtDao;

    public int create(Survey survey) {
        return surveyDao.create(survey);
    }

    public int delete(Integer id) {
        return surveyDao.delete(MapParameter.getInstance().addId(id).getMap());
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
            surveyDao.delete(MapParameter.getInstance().addId(Integer.parseInt(s)).getMap());
            flag ++;
        }
        return flag;
    }

    public int update(Survey survey) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMapForUpdate(survey)).addId(survey.getId()).getMap();
        return surveyDao.update(paramMap);
    }

    public List<Survey> query(Survey survey) {
        PageHelper.startPage(survey.getPage(), survey.getLimit());
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMap(survey)).getMap();
        return surveyDao.query(paramMap);
    }

    public List<Survey> queryAll(Survey survey) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMap(survey)).getMap();
        return surveyDao.query(paramMap);
    }

    public Survey detail(Integer id) {
        Map<String, Object> paramMap = MapParameter.getInstance().addId(id).getMap();
        return surveyDao.detail(paramMap);
    }

    public int count(Survey survey) {
        Map<String, Object> paramMap = MapParameter.getInstance().put(BeanMapUtils.beanToMap(survey)).getMap();
        return surveyDao.count(paramMap);
    }

    public void updateState() {
        List<Integer> list = surveyDao.queryByState(Survey.state_create);
        for (Integer id : list) {
            surveyDao.update(MapParameter.getInstance().add("updateState", Survey.state_exec).addId(id).getMap());
        }
        List<Integer> list1 = surveyDao.queryByStateForExec(Survey.state_exec);
        for (Integer id : list1) {
            surveyDao.update(MapParameter.getInstance().add("updateState", Survey.state_over).add("id", id).getMap());
        }
    }

    public Integer submit(List<AnswerOpt> opts, List<AnswerTxt> txts){
        int flag = 0;
        for (AnswerOpt opt : opts) {
            flag = answerOptDao.create(opt);
        }
        for (AnswerTxt txt : txts) {
            flag = answerTxtDao.create(txt);
        }
        return flag;
    }

    public List<AnswerOpt> queryAnswerOpt(AnswerOpt answerOpt){
        Map<String, Object> map = MapParameter.getInstance().put(BeanMapUtils.beanToMap(answerOpt)).getMap();
        return answerOptDao.query(map);
    }
}
