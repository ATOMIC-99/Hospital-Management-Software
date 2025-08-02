CREATE DATABASE hospital;
USE hospital;

CREATE TABLE pasent_info (
    p_id VARCHAR(20),
    name VARCHAR(20),
    age INT,
    address VARCHAR(30),
    phone BIGINT,
    blode_group CHAR(5),
    desise_name VARCHAR(30),
    desise_id VARCHAR(20),
    room INT,
    bed_no INT,
    PRIMARY KEY (p_id, desise_id)
);

CREATE TABLE pasent_desise (
    p_id VARCHAR(20),
    blode_group CHAR(5),
    desise_name VARCHAR(30),
    desise_id VARCHAR(20),
    room INT,
    bed_no INT,
    madition VARCHAR(20),
    d_id VARCHAR(20),
    n_id VARCHAR(20),
    name VARCHAR(20),
    age INT,
    PRIMARY KEY (desise_name),
    FOREIGN KEY (p_id, desise_id) REFERENCES pasent_info(p_id, desise_id)
);

CREATE TABLE docter_info (
    d_id VARCHAR(20) PRIMARY KEY,
    docter_name VARCHAR(30),
    age INT,
    room INT,
    p_num BIGINT,
    address VARCHAR(50),
    docter_type VARCHAR(30),
    salary INT,
    warking_day VARCHAR(20)
);

CREATE TABLE nurse_info (
    n_id VARCHAR(20) PRIMARY KEY,
    nurse_name VARCHAR(30),
    age INT,
    room INT,
    p_num BIGINT,
    address VARCHAR(50),
    shift_time VARCHAR(20),
    salary INT,
    d_id VARCHAR(20),
    FOREIGN KEY (d_id) REFERENCES docter_info(d_id)
);

CREATE TABLE other_employee (
    e_id VARCHAR(20) PRIMARY KEY,
    emp_name VARCHAR(30),
    age INT,
    department VARCHAR(30),
    role VARCHAR(30),
    salary INT,
    address VARCHAR(50),
    warking_day VARCHAR(20),
    d_id VARCHAR(20),
    FOREIGN KEY (d_id) REFERENCES docter_info(d_id)
);
INSERT INTO pasent_info
( p_id , name , age , address , phone , blode_group , desise_name , desise_id , room , bed_no )VALUES
('PS1001', 'Anil Kumar', 29, 'Bhubaneswar', 9876543210, 'O+', 'Asthma', 'ASTH101', 1, 1),
('PS1002', 'Rekha Sahu', 34, 'Cuttack', 9867894321, 'A+', 'Diabetes', 'DIA102', 1, 2),
('PS1003', 'Manas Raut', 22, 'Puri', 9854310987, 'B-', 'Cold Fever', 'COLD103', 1, 3),
('PS1004', 'Priti Das', 45, 'Jajpur', 9845671230, 'AB+', 'Back Pain', 'BACK104', 2, 1),
('PS1005', 'Suresh Nayak', 50, 'Tangi', 9834567890, 'A-', 'Fracture', 'FRA105', 2, 2);

INSERT INTO pasent_desise
(p_id , blode_group , desise_name , desise_id , room , bed_no , madition , d_id , n_id , name , age) VALUES
('PS1001', 'O+', 'Asthma', 'ASTH101', 1, 1, 'Salbutamol', 'DR101', 'NR201', 'Anil Kumar', 29),
('PS1002', 'A+', 'Diabetes', 'DIA102', 1, 2, 'Metformin', 'DR102', 'NR202', 'Rekha Sahu', 34),
('PS1003', 'B-', 'Cold Fever', 'COLD103', 1, 3, 'Paracetamol', 'DR101', 'NR203', 'Manas Raut', 22),
('PS1004', 'AB+', 'Back Pain', 'BACK104', 2, 1, 'Ibuprofen', 'DR103', 'NR204', 'Priti Das', 45),
('PS1005', 'A-', 'Fracture', 'FRA105', 2, 2, 'Calcium Plus', 'DR104', 'NR202', 'Suresh Nayak', 50);

INSERT INTO docter_info 
( d_id , docter_name , age , room , p_num , address , docter_type , salary , warking_day )VALUES
('DR101', 'Dr. A Mishra', 40, 1, 9100000001, 'Bhubaneswar', 'General Physician', 95000, 'Mon-Fri'),
('DR102', 'Dr. R Sen', 38, 1, 9100000002, 'Cuttack', 'Endocrinologist', 105000, 'Mon-Sat'),
('DR103', 'Dr. M Behera', 46, 2, 9100000003, 'Puri', 'Orthopedic', 120000, 'Tue-Sat'),
('DR104', 'Dr. S Patnaik', 52, 2, 9100000004, 'Tangi', 'Surgeon', 130000, 'Wed-Sun');

INSERT INTO nurse_info 
(n_id , nurse_name , age , room , p_num , address , shift_time , salary , d_id )VALUES
('NR201', 'Nurse P Das', 28, 1, 9200000001, 'Bhubaneswar', 'Day', 40000, 'DR101'),
('NR202', 'Nurse S Naik', 35, 2, 9200000002, 'Cuttack', 'Night', 42000, 'DR102'),
('NR203', 'Nurse A Rani', 30, 1, 9200000003, 'Jajpur', 'Day', 39000, 'DR101'),
('NR204', 'Nurse R Sen', 32, 2, 9200000004, 'Puri', 'Night', 43000, 'DR103');

INSERT INTO other_employee
( e_id , emp_name , age , department , role , salary , address , warking_day , d_id)VALUES
('EMP01', 'Binod Sahu', 36, 'Reception', 'Receptionist', 30000, 'Bhubaneswar', 'Mon-Fri', 'DR101'),
('EMP02', 'Geeta Panda', 41, 'Cleaning', 'Cleaner', 25000, 'Cuttack', 'Mon-Sat', 'DR102'),
('EMP03', 'Ajay Das', 29, 'Tech', 'IT Support', 32000, 'Puri', 'Tue-Sun', 'DR103'),
('EMP04', 'Sneha Rani', 33, 'Billing', 'Accountant', 35000, 'Tangi', 'Wed-Sun', 'DR104');


CREATE TABLE desise (
    desise_id VARCHAR(20) PRIMARY KEY,
    desise_name VARCHAR(50),
    category VARCHAR(30),
    symptoms TEXT,
    is_contagious BOOLEAN
);

CREATE TABLE farmasi (
    f_id VARCHAR(20) PRIMARY KEY,
    f_name VARCHAR(50),
    location VARCHAR(100),
    head_pharmacist VARCHAR(50),
    contact BIGINT
);

CREATE TABLE medition_storage (
    m_id VARCHAR(20) PRIMARY KEY,
    m_name VARCHAR(50),
    quantity INT,
    expiry_date DATE,
    used_for VARCHAR(50),
    f_id VARCHAR(20),
    FOREIGN KEY (f_id) REFERENCES farmasi(f_id)
);

CREATE TABLE blood_storage (
    bag_id VARCHAR(20) PRIMARY KEY,
    blood_group CHAR(5),
    quantity_ml INT,
    donor_name VARCHAR(50),
    collection_date DATE,
    expiry_date DATE,
    used BOOLEAN DEFAULT FALSE,
    f_id VARCHAR(20),
    FOREIGN KEY (f_id) REFERENCES farmasi(f_id)
);

INSERT INTO desise 
(  desise_id , desise_name , category , symptoms , is_contagious)VALUES
('D001', 'Typhoid', 'Infectious', 'High fever, stomach pain, weakness', TRUE),
('D002', 'Diabetes', 'Chronic', 'Increased thirst, weight loss, fatigue', FALSE),
('D003', 'Malaria', 'Parasitic', 'Fever, chills, sweating', TRUE),
('D004', 'Arthritis', 'Autoimmune', 'Joint pain, swelling, stiffness', FALSE),
('D005', 'Tuberculosis', 'Infectious', 'Cough, fever, weight loss', TRUE);

INSERT INTO farmasi 
(f_id , f_name , location , head_pharmacist ,  contact )VALUES
('F001', 'MedHub Central', 'Ground Floor, Block A', 'Rina Patel', 9876543210),
('F002', 'QuickMeds Pharmacy', 'Level 1, East Wing', 'Ajay Mehra', 9876501234),
('F003', 'HealthFirst Store', 'Basement, Building C', 'Sunita Sahu', 9876123456);

INSERT INTO medition_storage 
(m_id , m_name , quantity , expiry_date ,  used_for ,  f_id )VALUES
('M001', 'Paracetamol 500mg', 300, '2026-05-30', 'Fever', 'F001'),
('M002', 'Metformin 850mg', 150, '2025-12-31', 'Diabetes', 'F001'),
('M003', 'Artemisinin', 100, '2026-03-15', 'Malaria', 'F002'),
('M004', 'Ibuprofen 400mg', 200, '2027-01-01', 'Arthritis', 'F003'),
('M005', 'Rifampicin', 120, '2026-10-10', 'Tuberculosis', 'F002');

INSERT INTO blood_storage
(bag_id , blood_group , quantity_ml , donor_name , collection_date , expiry_date , used , f_id )VALUES
('B001', 'A+', 450, 'Ramesh Sahu', '2025-07-10', '2025-10-10', FALSE, 'F001'),
('B002', 'O+', 500, 'Sneha Nayak', '2025-07-01', '2025-09-30', FALSE, 'F002'),
('B003', 'B-', 350, 'Ritika Das', '2025-06-15', '2025-08-15', TRUE, 'F003'),
('B004', 'AB+', 400, 'Ankit Raut', '2025-07-20', '2025-10-20', FALSE, 'F001'),
('B005', 'O-', 300, 'Gopal Behera', '2025-07-12', '2025-09-12', FALSE, 'F003');


SELECT * FROM pasent_info;
SELECT * FROM pasent_desise;
SELECT * FROM docter_info;
SELECT * FROM nurse_info;
SELECT * FROM other_employee;


