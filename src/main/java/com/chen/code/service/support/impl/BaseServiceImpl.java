package com.chen.code.service.support.impl;

import com.chen.code.dao.support.IBaseDao;
import com.chen.code.service.support.IBaseService;
import com.google.common.base.CharMatcher;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Transactional
public abstract class BaseServiceImpl<T , ID extends Serializable> implements IBaseService<T, ID> {

    public abstract IBaseDao<T, ID> getBaseDao();


    @PersistenceContext
    private EntityManager entityManager;

    private  String pkName;

    private  Class entityClass;

    public BaseServiceImpl() {

        Type type = this.getClass().getGenericSuperclass();//Type直接实现子类 :Class类 getGenericSuperclass当前对象的直接超类的 Type
        if (type instanceof ParameterizedType) {
            entityClass = (Class<T>) ((ParameterizedType) type).getActualTypeArguments()[0];
        } else {
            entityClass = (Class<T>) ((ParameterizedType) getClass().getSuperclass().getGenericSuperclass()).getActualTypeArguments()[0];
        }
    }
    /**
     * 获取分页请求
     * @return
     */
    protected PageRequest getPageRequest(com.chen.code.common.Query query){
        if(StringUtils.isBlank(pkName)){
            EntityManagerFactory entityManagerFactory = entityManager.getEntityManagerFactory();
            pkName = entityManagerFactory.unwrap(SessionFactory.class).getClassMetadata(entityClass).getIdentifierPropertyName();
        }
        String sortName = query.getString("sortName");
        if(StringUtils.isBlank(sortName)){
            sortName = pkName;
        }
        Sort sort = null;
        String sortOrder = query.getString("sortOrder");
        if("asc".equalsIgnoreCase(sortOrder)){
            sort = new Sort(Sort.Direction.ASC, sortName);
        }else{
            sort = new Sort(Sort.Direction.DESC, sortName);
        }
        int page = 0;
        String pageNumberStr = query.getString("pageNumber");
        if(pageNumberStr !=null && CharMatcher.digit().matchesAllOf(pageNumberStr)){
            page = Integer.parseInt(pageNumberStr) - 1;
        }
        int size = 10;
        String pageSizeStr = query.getString("pageSize");
        if(pageSizeStr != null && CharMatcher.digit().matchesAllOf(pageSizeStr)){
            size = Integer.parseInt(pageSizeStr);
        }
        PageRequest pageRequest = new PageRequest(page, size, sort);
        return pageRequest;
    }


    private Session getSession() {
        Session session = entityManager.unwrap(Session.class);
        return session;
    }


    @Override
    public List excuteHql(String hql, Object... values) {
        Session session = getSession();
        Query query = session.createQuery(hql);
        if(values!=null&&values.length>0){
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i,values[i]);
            }
        }
        return query.list();
    }

    @Override
    public List excuteSql(String sql, Object... values) {
        return excuteSql(sql,false,values);
    }

    @Override
    public List<Map> getMapBySql(String sql, Object... values) {
        return excuteSql(sql,true,values);
    }

    private List  excuteSql(final String sql,final boolean isMap, final Object... values) {
        Session session = getSession();

        Query query = session.createSQLQuery(sql);
        if(values !=null && values.length > 0){
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        if (isMap) {
            query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        }
        return query.list();
    }

    @Override
    public int updateBySql(String sql, Object... values) {
        Session session = getSession();
        Query query = session.createSQLQuery(sql);
        if(values !=null && values.length > 0){
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        return query.executeUpdate();
    }



    @Override
    public T find(ID id) {
        return getBaseDao().findOne(id);
    }

    @Override	
    public List<T> findAll() {
        return getBaseDao().findAll();
    }

    @Override
    public List<T> findList(ID[] ids) {
        List<ID> idList = Arrays.asList(ids);
        return getBaseDao().findAll(idList);
    }

    @Override
    public List<T> findList(Specification<T> spec, Sort sort) {
        return getBaseDao().findAll(spec, sort);
    }

    @Override
    public Page<T> findAll(Pageable pageable) {
        return getBaseDao().findAll(pageable);
    }

    @Override
    public long count() {
        return getBaseDao().count();
    }

    @Override
    public long count(Specification<T> spec) {
        return getBaseDao().count(spec);
    }

    @Override
    public boolean exists(ID id) {
        return getBaseDao().exists(id);
    }

    @Override
    public void save(T entity) {
        getBaseDao().save(entity);
    }

    public void save(Iterable<T> entitys) {
        getBaseDao().save(entitys);
    }

    @Override
    public T update(T entity) {
        return getBaseDao().saveAndFlush(entity);
    }

    @Override
    public void delete(ID id) {
        getBaseDao().delete(id);
    }

    @Override
    public void deleteByIds(ID... ids) {
        if (ids != null) {
            for (int i = 0; i < ids.length; i++) {
                ID id = ids[i];
                this.delete(id);
            }
        }
    }

    @Override
    public void delete(T[] entitys) {
        List<T> tList = Arrays.asList(entitys);
        getBaseDao().delete(tList);
    }

    @Override
    public void delete(Iterable<T> entitys) {
        getBaseDao().delete(entitys);
    }

    @Override
    public void delete(T entity) {
        getBaseDao().delete(entity);
    }

    @Override
    public List<T> findList(Iterable<ID> ids) {
        return getBaseDao().findAll(ids);
    }

    @Override
    public Page<T> findAll(Specification<T> spec, Pageable pageable) {
        return getBaseDao().findAll(spec, pageable);
    }


}
