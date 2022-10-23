package com.zsr.dao;


import com.zsr.pojo.Department;
import com.zsr.pojo.Employee;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@Repository
public class EmployeeDao {

    static  private Map<Integer, Employee> employees;

    @Autowired
    private  DepartmentDao departmentDao;

    static {
        employees = new HashMap<>(); //创建一个员工表
        employees.put(1,new Employee(1, "kmr", "kmr@fans.com", 1, new Department(1,"技术部"),new Date()));
    }

    private  static  Integer initialID = 5;

    //增加一个员工
    public void addEmployee(Employee employee) {
    if (employee.getId() == null) {
        employee.setId(initialID);
    }
        employee.setDepartment(departmentDao.getDepartmentById(employee.getDepartment().getId()));
        employees.put(employee.getId(),employee);
    }

    public Collection<Employee> getAllEmployees(String lastName){
        Collection<Employee> values = employees.values();
        //如果上传了lastName，对结果进行筛选
        if(!StringUtils.isEmpty(lastName)){
            values = values.stream().filter( v -> v.getLastName().contains(lastName)).collect(Collectors.toList());
        }
        return values;
    }


    public Employee getEmployeeByID(Integer id){
        return  employees.get(id);
    }

    public void deleteEmployeeByID(int id) { employees.remove(id);
    }
}

