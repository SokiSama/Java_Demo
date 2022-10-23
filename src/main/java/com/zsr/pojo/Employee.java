package com.zsr.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

//员工表
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
    private  Integer id;
    private String lastName;
    private String email;
    private Integer gender;
    private Department department;
    private Date date;
}
