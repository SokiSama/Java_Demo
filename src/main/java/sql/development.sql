CREATE DATABASE `employee_management` CHARACTER SET utf8 COLLATE utf8_general_ci;

USE `employee_management`;

CREATE TABLE `employee` (
                            `employee_id` int(8) COMMENT '员工id',
                            `department_id` int(8) NULL COMMENT '部门id',
                            `position_id` int(8) NULL COMMENT '职位id',
                            `employee_name` varchar(50) NULL COMMENT '员工名称',
                            `cart_id` int NULL COMMENT '身份证号',
                            `sex` varchar(10) NULL COMMENT '性别',
                            `phone` varchar(20) NULL COMMENT '手机号',
                            `email` varchar(30) NULL COMMENT '邮箱',
                            PRIMARY KEY (`employee_id`)
);


CREATE TABLE `department`(
                             `department_id` int(8) PRIMARY KEY,
                             `department_name` varchar(50),
                             `chairman_number` varchar(20)
);


CREATE TABLE `POSITION` (
                            `position_id` int(8) PRIMARY key,
                            `department_id` int(8),
                            `position_name` varchar(20)
);

CREATE TABLE `project` (
                           `project_id` int(8) PRIMARY key,
                           `project_name` VARCHAR(20),
                           `start_time` varchar(20),
                           `end_time` varchar(20)
);


#员工和项目关系表

CREATE TABLE `emp_project_info`(
                                   `emp_project_r_id` int PRIMARY KEY,
                                   `employee_id` int(8),
                                   `project_id` int(8)
);

CREATE TABLE `salary_info` (
                               `bill_id` int(8) PRIMARY key,
                               `employee_id` int(8),
                               `base_pay` int,
                               `insurance_pay` int,
                               `merit_pay` int,
                               `subsidy_pay` int,
                               `overtime_pay` int
);

#添加表之间的约束

ALTER TABLE `salary_info`
    ADD FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);

ALTER TABLE `salary_info`
    ADD FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`);

ALTER TABLE `position`
    ADD FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);


ALTER TABLE `emp_project_info`
    ADD FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
    ADD FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`);

ALTER TABLE `employee`
    ADD FOREIGN KEY (`position_id`) REFERENCES `position` (`position_id`);

#3 创建索引
CREATE INDEX idx_emp_name ON employee(employee_name);

CREATE INDEX idx_dept_name ON department(department_name);

CREATE INDEX idx_project_name ON project(project_name);

ALTER TABLE `position`
    ADD INDEX `idx_position_name`(`position_name`) USING BTREE;

#插入数据
INSERT INTO `department` (`department_id`, `department_name`, `chairman_number`) VALUES (1001, '开发部', '202101');
INSERT INTO `department` (`department_id`, `department_name`, `chairman_number`) VALUES (1002, '设计部', '202102');

INSERT INTO `position` (`position_id`, `department_id`, `position_name`) VALUES (2001, 1001, '技术总监');
INSERT INTO `position` (`position_id`, `department_id`, `position_name`) VALUES (2002, 1002, '设计总监');

INSERT INTO `employee` VALUES (202101, 1001, 2001, '张三', 2204554, '男', '21343545', '23478957@qq.com');
INSERT INTO `employee` VALUES (202102, 1001, 2001, '李四', 2203425, '女', '23475453', '23184672@qq.com');
INSERT INTO `employee` VALUES (202103, 1001, 2001, '王五', 2204545, '男', '32313435', '12323233@qq.com');
INSERT INTO `employee` VALUES (202104, 1002, 2002, '刘六', 2206756, '女', '12313445', '32847239@qq.com');
INSERT INTO `employee` VALUES (202105, 1002, 2002, '赵七', 2204735, '男', '32490294', '31287463@qq.com');

INSERT INTO `project` VALUES (3001, 'xx电子平台', '2021.01', '2021.03');
INSERT INTO `project` VALUES (3002, 'xx电商', '2021.04', '2021.07');

INSERT INTO `emp_project_info` (`emp_project_r_id`, `employee_id`, `project_id`) VALUES (4001, 202101, 3001);
INSERT INTO `emp_project_info` (`emp_project_r_id`, `employee_id`, `project_id`) VALUES (4002, 202102, 3001);
INSERT INTO `emp_project_info` (`emp_project_r_id`, `employee_id`, `project_id`) VALUES (4003, 202103, 3001);
INSERT INTO `emp_project_info` (`emp_project_r_id`, `employee_id`, `project_id`) VALUES (4004, 202104, 3002);
INSERT INTO `emp_project_info` (`emp_project_r_id`, `employee_id`, `project_id`) VALUES (4005, 202105, 3002);

INSERT INTO `salary_info` VALUES (5001, 202101, 8000, 1000, 2000, 4000, 3000);
INSERT INTO `salary_info` VALUES (5002, 202102, 7500, 1000, 2000, 3000, 3000);
INSERT INTO `salary_info` VALUES (5003, 202103, 8000, 1000, 2000, 4000, 3000);
INSERT INTO `salary_info` VALUES (5004, 202104, 7000, 1000, 2000, 2000, 3000);
INSERT INTO `salary_info` VALUES (5005, 202105, 9000, 1000, 2000, 1000, 3000);

#创建视图：
CREATE VIEW s1 AS SELECT AVG(base_pay+insurance_pay+merit_pay+subsidy_pay+overtime_pay) avg_salary FROM salary_info;