package com.zsr.dao;

import com.zsr.pojo.Department;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

//注册到IOC容器中
@Repository
public class DepartmentDao {

    private static Map<Integer, Department> departments = null;

    static {
        departments = new HashMap<>(); //创建一个部门表
        departments.put(1, new Department(1,"技术部"));
        departments.put(2, new Department(2, "研发部"));
        departments.put(3, new Department(3,"解决方案部"));
    }

    public Collection<Department> getDepartments(){
        return departments.values();
    }

    public Department getDepartmentById(int id){
        return  departments.get(id);
    }

    }

