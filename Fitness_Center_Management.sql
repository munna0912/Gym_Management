-- Create and Use Database
CREATE SCHEMA `Fitness_Center_Management`;
USE `Fitness_Center_Management`;

-- Create table Branch
CREATE TABLE `Branch` (
    `Branch_ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Branch_Name` VARCHAR(45) NOT NULL,
    `Branch_Address` VARCHAR(100) NOT NULL
);

-- Create table Manager
CREATE TABLE `Manager_Info` (
    `ID` INT PRIMARY KEY UNIQUE,
    `Manager_Name` VARCHAR(45) NOT NULL,
    `Contact_No.` BIGINT NOT NULL UNIQUE,
    `Monthly_Salary` INT NOT NULL DEFAULT '60000',
    FOREIGN KEY (`ID`)
        REFERENCES `Branch` (`Branch_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Table Excercise
CREATE TABLE `Excercise` (
    `ID` INT NOT NULL PRIMARY KEY,
    `Excercise_Name` VARCHAR(45),
    `Monthly_Cost` INT NOT NULL
);

-- Create table Trainer
CREATE TABLE Trainer_Info (
    `Trainer_ID` INT AUTO_INCREMENT NOT NULL,
    `Excercise` INT NOT NULL,
    `Trainer_Name` VARCHAR(45) NOT NULL,
    `Branch` INT NOT NULL,
    `Contact_No.` BIGINT NOT NULL UNIQUE,
    `Monthly_Salary` INT NOT NULL DEFAULT '10000',
    PRIMARY KEY (`Trainer_ID` , `Branch` , `Excercise`),
    FOREIGN KEY (`Branch`)
        REFERENCES `Branch` (`Branch_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Excercise`)
        REFERENCES `Excercise` (`ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
);


-- Create Table Package
CREATE TABLE `Package` (
    `Pkg_ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `Pkg_Name` VARCHAR(45) NOT NULL UNIQUE
);

-- Creating a table to represent many to many relationship b/w `Excercise` and `Package`
CREATE TABLE `Pkg_excercise` (
    `Pkg_ID` INT NOT NULL,
    `Excercise_ID` INT NOT NULL,
    PRIMARY KEY (`Pkg_ID` , `Excercise_ID`),
    FOREIGN KEY (`Pkg_ID`)
        REFERENCES `Package` (`Pkg_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Excercise_ID`)
        REFERENCES `Excercise` (`ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Create Table for members
CREATE TABLE `Member_Info` (
    `Member_ID` INT NOT NULL AUTO_INCREMENT,
    `Member_Name` VARCHAR(45) NOT NULL,
    `Contact_Info` BIGINT NOT NULL,
    `Age` INT NOT NULL,
    `Gender` CHAR(5) NOT NULL,
    `Joining_Date` DATE NOT NULL,
    `Branch` INT NOT NULL,
    `Duration_In_Months` INT NOT NULL,
    `Package` INT NOT NULL,
    `add_on1` INT DEFAULT NULL,
    PRIMARY KEY (`Member_ID` , `Branch` , `Package`),
    FOREIGN KEY (`Branch`)
        REFERENCES `Branch` (`Branch_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`add_on1`)
        REFERENCES `Excercise` (`ID`)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Package`)
        REFERENCES `Package` (`Pkg_ID`)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ALTER TABLE Member INFO
ALTER TABLE `member_info`
ADD COLUMN `add_on2` INT DEFAULT NULL;

ALTER TABLE `member_info`
ADD FOREIGN KEY (`add_on2`)
REFERENCES `Excercise`(`ID`)
ON DELETE CASCADE ON UPDATE CASCADE;

-- Add Check condition in Member Table
ALTER TABLE `Member_Info`
ADD CHECK(`Duration_In_Months` = '1' OR `Duration_In_Months` = '3' OR `Duration_In_Months` = '6' OR `Duration_In_Months` = '12'),
ADD CHECK(`Gender`='M' OR `Gender` = 'F' OR `Gender` = 'Other');

-- Insert Values into excercise
INSERT INTO `fitness_center_management`.`excercise` (`ID`, `Excercise_Name`, `Monthly_Cost`) 
VALUES 
('1', 'Gym', '2500'),
('2', 'Yoga', '1800'),
('3', 'Zumba', '1500'),
('4', 'Aerobics', '1600'),
('5', 'Swimming', '1500'),
('6', 'Rock_climbing', '2000');
INSERT INTO `fitness_center_management`.`excercise` (`ID`, `Excercise_Name`, `Monthly_Cost`) 
VALUES ('7', 'Staionary cycling', '1000');
INSERT INTO `fitness_center_management`.`excercise` (`ID`, `Excercise_Name`, `Monthly_Cost`) 
VALUES ('8', 'Bokwa', '1300');
INSERT INTO `fitness_center_management`.`excercise` (`ID`, `Excercise_Name`, `Monthly_Cost`) 
VALUES ('9', 'Jumping Rope', '500');
INSERT INTO `fitness_center_management`.`excercise` (`ID`, `Excercise_Name`, `Monthly_Cost`) 
VALUES ('10', 'Yoga Dance', '1800');

-- Insert values into Branch
INSERT INTO `fitness_center_management`.`branch` (`Branch_Name`, `Branch_Address`) 
VALUES ('Aura', 'Street no. 5, Kalia Colony,Jalandhar, 123456'),
('Aura', 'Street no. 7, Doordarshan Colony, Gujral Nagar, Jalandhar,123456'),
( 'Infinity club', 'Street no. 2,Keshar nagar,Jaipur,302020'),
( 'Volcano', 'Street no. 4,Ashok marg,Jaipur,302020'),
( 'YouFit', 'Street no.6,Ratnada,Jodhpur,342001'),
( 'PowerFit', 'Street no.10,Nawalgarh road,Sikar,332001');

-- Insert values into Manager
INSERT INTO `fitness_center_management`.`manager_info` (`ID`, `Manager_Name`, `Contact_No.`) 
VALUES 
('1', 'Aviraj Singh', '1234567890'),
('3', 'Ravindra Bangarwa', '1112223333');
INSERT INTO `fitness_center_management`.`manager_info` (`ID`, `Manager_Name`, `Contact_No.`, `Monthly_Salary`) 
VALUES 
('2', 'Neha Meena', '9876543210', '55000'),
('4', 'Bharti Arya', '2223334444', '55000'),
('5', 'Tennyson Methew', '3334445555', '50000'),
('6', 'Rashmi Singh', '4445556666', '51000');

-- Insert values into trainer_info
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Nakul Mehta', '1', '1234567890');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('2', 'Nikita Poonia', '1', '2345678901');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('3', 'Amit Thalor', '1', '3456789012', '12500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('4', 'Kiranjeet Kaur', '1', '4567890123');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Kshitiz Yadav', '1', '5678901234');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('6', 'Priyanka Yadav', '1', '6789012345');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('1', 'Ankit Sahu', '1', '7890123456', '11000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Gaurav Priy', '1', '8901234567');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Ishtjot Kaur', '1', '9012345678');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Kirandeep Kaur', '1', '9877777777');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Anjali Gupta', '1', '9888888888');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Aashima Tyagi', '2', '9999999999');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('2', 'Shikha Gautam', '2', '8888888888', '13000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Pratham Sharma', '2', '8989898989');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('4', 'Harman Grewal', '2', '7878787878');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Abhishek Kumar Tyagi', '2', '8787878787');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('6', 'Karan Meena', '2', '6767676767');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('4', 'Sherya', '2', '7676767676');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Mayank Gera', '2', '5656565656');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Mahir Bansal', '2', '6565656565');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Naman Sharma', '2', '4545454545');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('7', 'Jitendra Gujjar', '1', '8290568152', '8000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('9', 'Sharad Intodia', '1', '9460906056', '7500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('8', 'Arvind Sharma', '2', '9461945288');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('10', 'Arjun Dhuria', '1', '8905966056');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('10', 'Jyoti Sharma', '2', '9649433565', '10500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('8', 'Shruti Naik', '1', '9649330628', '9500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Yuvraj ', '3', '1111222333');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Pranshu Gera', '3', '2222333444');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Abureet Kaur', '3', '3333444555');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Kamya', '3', '4444555666');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('2', 'Yashita', '3', '5555666777', '9000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.` ) 
VALUES ('2', 'Satvik Arora', '3', '6666777888');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('2', 'Karan Ahuja', '3', '7777888999');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('3', 'Hitesh Goyal', '3', '8888999000', '11000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Drishti', '3', '9999000111');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('4', 'Smarth Saish', '3', '9000111222', '10500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('4', 'Nishita', '3', '1112222333', '10700');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Aman Yadu', '3', '3334444555');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Rohan Kapoor', '3', '4445555666');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('6', 'Shubham Sharma', '3', '5556666777', '11000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('8', 'Davinder Kaur', '3', '6667777888');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('10', 'Ananya', '3', '7778888999');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Hitesh Goyal', '4', '8889999000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Raywa', '4', '9990000111');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Ipsa Gaur', '4', '1551561571');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('2', 'Nikita Singh', '4', '5815916016', '9500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('2', 'Utkarsh Soni', '4', '1162163164');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Krish Goyal', '4', '1651661671');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('4', 'Vaibhav Nassa', '4', '6816917017');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Dikhsit Jain', '4', '1172173174');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('6', 'Sartaaj Singh', '4', '1751761771', '11000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('8', 'Saiyam Aneja', '4', '7817918018', '11600');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('9', 'Rakshika', '4', '1182183184', '10000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('10', 'Diya', '4', '1851861871', '9500');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Barkat Dhillon', '5', '8818919019');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Yaveen Pahuja', '5', '1192193194');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('2', 'Rudra Agarwal', '5', '2122232425');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('2', 'Gunika Arora', '5', '2627282930', '12000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('3', 'Sachin Hans', '5', '3132333435', '11600');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('4', 'Kapil Dehru', '5', '3637383940', '9900');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('5', 'Kunwar Partap Sidhu', '5', '4142434445', '8800');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('6', 'Kritika Verma', '5', '4647484950', '10000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('7', 'Abhisek', '5', '5152535455', '9000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('8', 'Namisha', '5', '5657585960', '7800');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('9', 'Mohan Prajapati', '5', '6162636465', '9000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('10', 'Priyanka Arora', '5', '6667686970', '8000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('1', 'Garima Gupta', '6', '7172737475', '6000');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('1', 'Rohan Singla', '6', '7677787980');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('2', 'Lavish Jain', '6', '8182838485');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('2', 'Karan Sharam', '6', '8687888990');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Palak Bansal', '6', '9192939495');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('3', 'Rubal Malhi', '6', '9697989910');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('4', 'Vinayak', '6', '1011021031');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Himanshu Gera', '6', '1041051061');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`) 
VALUES ('5', 'Simran Kaur', '6', '1071081091');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('10', 'Sukhchain Singh', '6', '1101111121', '8300');
INSERT INTO `fitness_center_management`.`trainer_info` (`Excercise`, `Trainer_Name`, `Branch`, `Contact_No.`, `Monthly_Salary`) 
VALUES ('3', 'Harpreet', '4', '1131141151', '9200');

-- INSERT VALUES into Package
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Diamond');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Platinum ');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Gold');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Silver');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Deluxe');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Jumbo');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`)
VALUES ('Pico');
INSERT INTO `fitness_center_management`.`package` (`Pkg_Name`) 
VALUES ('Micro');

-- Insert Data in releationship bridge table
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('1', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('1', '6');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('1', '3');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('1', '10');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('1', '8');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('2', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`)
 VALUES ('2', '5');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('2', '6');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('3', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`)
 VALUES ('3', '3');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('3', '2');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('4', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('4', '3');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('5', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('5', '3');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('5', '4');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('5', '5');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '2');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '3');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '4');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '5');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '6');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('7', '8');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('7', '10');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('7', '2');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('8', '9');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('8', '7');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('8', '1');
INSERT INTO `fitness_center_management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('8', '4');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('2', '7');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('3', '7');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('4', '7');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('5', '7');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('5', '8');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '7');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '8');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '9');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('6', '10');
INSERT INTO `fitness_Center_Management`.`pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('7', '7');


-- insert into table Members
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Dohit Deegwal', '1111111111', '19', 'M', '2021-11-27', '1', '3', '4', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aarush Junega', '1111111112', '20', 'M', '2021-11-25', '1', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vaibhav Thathai', '1111111113', '18', 'M', '2021-11-26', '1', '1', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Puneet Thakur', '1111111114', '19', 'M', '2021-09-28', '1', '12', '1', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Lovish Bansal', '1111111115', '21', 'M', '2021-09-09', '2', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Swetha Bansal', '1111111116', '18', 'F', '2021-09-09', '2', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Namamish Awasthi', '1111111117', '19', 'M', '2021-10-11', '2', '6', '5', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Naveen Kumar', '1111111118', '20', 'M', '2021-10-21', '1', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pahuldeep Singh', '1111111119', '18', 'M', '2021-1-23', '1', '1', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pankaj', '1111111120', '19', 'M', '2021-2-24', '1', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Abhijeet', '1111111121', '20', 'M', '2021-3-17', '1', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Amisha', '1111111122', '18', 'F', '2021-4-18', '1', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES (' Aniket Garg', '1111111123', '19', 'M', '2021-5-28', '2', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Gurleen Kaur', '1111111124', '20', 'F', '2021-6-30', '2', '3', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`)
 VALUES ('Garima', '1111111125', '18', 'F', '2021-7-20', '2', '3', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Jai Dhamwani', '1111111126', '18', 'M', '2021-8-31', '2', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Prathamesh Pawar', '1111111127', '19', 'M', '2021-9-14', '2', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kanav Phull', '1111111128', '19', 'M', '2021-10-5', '1', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kartikeya Agarwal', '1111111129', '19', 'M', '2021-11-3', '2', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Lovepreet', '1111111130', '19', 'M', '2021-12-8', '1', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Manan Virmani', '1111111131', '20', 'M', '2021-11-19', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pankhi', '1111111132', '21', 'F', '2020-11-20', '1', '12', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sayam', '1111111133', '21', 'M', '2021-10-11', '2', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sarita', '1111111134', '18', 'F', '2021-9-21', '1', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Suman', '1111111135', '18', 'F', '2021-10-11', '2', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sadan Ali', '1111111136', '19', 'M', '2021-11-8', '1', '6', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Smile Sharma', '1111111137', '18', 'F', '2021-12-12', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Tammana', '1111111138', '18', 'F', '2021-8-2', '1', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Tapan', '1111111139', '20', 'F', '2021-3-3', '1', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Vanshika Bansal', '1111111140', '21', 'F', '2021-5-4', '1', '12', '2', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Yash Gupta', '1111111141', '19', 'M', '2021-8-6', '1', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anannya ', '1111111142', '19', 'F', '2021-12-11', '2', '1', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ranjeet Singh', '1111111143', '19', 'M', '2021-11-21', '2', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nisha Poonia', '1111111144', '18', 'F', '2021-10-22', '2', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nikhil', '1111111145', '17', 'M', '2020-6-29', '2', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Himanshu', '1111111146', '20', 'M', '2021-3-1', '1', '12', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sunita', '1111111147', '30', 'F', '2021-9-6', '1', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Aayush', '1111111148', '16', 'M', '2022-7-19', '1', '6', '2', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sahil Sen', '9999995999', '17', 'M', '2021-06-11', '1', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Saksham Thakur', '9999994999', '18', 'M', '2021-11-11', '3', '3', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sarbjot Bhutta', '9999993999', '20', 'M', '2021-12-03', '5', '6', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rohit Jangid', '9999992999', '22', 'M', '2021-01-02', '6', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aayush', '9999991999', '21', 'M', '2021-03-04', '4', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nikita', '9909999899', '18', 'F', '2021-04-03', '2', '3', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nakul', '9999999799', '19', 'M', '2021-09-07', '1', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Parthamesh', '9999999899', '21', 'M', '2021-08-07', '3', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kshitiz', '9999999799', '22', 'M', '2021-07-08', '5', '12', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pankaj Yadav', '9999999699', '24', 'M', '2021-10-05', '6', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aviraj Singh', '9999999599', '25', 'M', '2021-12-07', '4', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pankhi ', '9999999499', '26', 'F', '2021-12-11', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Gurleen', '9999999399', '17', 'F', '2020-02-10', '2', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Gurleen Singh', '9999999299', '18', 'F', '2020-02-11', '1', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shridev', '9999999199', '20', 'M', '2020-03-09', '1', '3', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rudra Partap', '9999999919', '21', 'M', '2020-04-08', '1', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Gaurav', '9999999929', '19', 'M', '2020-05-10', '4', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vikram', '9999999939', '18', 'M', '2020-05-11', '4', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Rudra Rathore', '9999999949', '18', 'M', '2020-04-11', '3', '12', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Pankaj Verma', '9999999959', '19', 'M', '2020-03-12', '5', '3', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Roshni', '9999999969', '20', 'F', '2020-02-01', '3', '1', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rakesh Mothsara', '9999999979', '20', 'M', '2020-04-11', '6', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Monika Sangwan', '9999999989', '21', 'F', '2021-03-11', '3', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anjali', '9999999991', '21', 'F', '2021-05-01', '6', '3', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mahima', '9999999992', '22', 'F', '2020-05-01', '4', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sumit', '9999999993', '22', 'M', '2020-05-05', '4', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sushil', '9999999994', '22', 'M', '2020-08-04', '5', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Diksha', '9999999995', '23', 'F', '2020-10-08', '5', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Garima', '9999999996', '23', 'F', '2020-10-11', '6', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rashmi', '9999999997', '24', 'F', '2020-11-16', '6', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shaily', '9999999998', '25', 'F', '2020-11-15', '2', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Naisargee', '9999999999', '24', 'F', '2020-11-10', '2', '6', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Randhir', '9999399999', '21', 'M', '2020-11-15', '1', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Deepshika', '9999299999', '20', 'F', '2020-02-15', '5', '12', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Chanchal', '9999199999', '19', 'F', '2020-01-02', '5', '12', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Lakshit', '9999499999', '20', 'M', '2020-01-01', '5', '12', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vikrant', '9999599999', '21', 'M', '2021-03-04', '5', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Tarak', '9999699999', '21', 'M', '2021-05-06', '6', '1', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Arun Goud', '1551561579', '20', 'M', '2022-07-19', '6', '1', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Raval Dharmik', '1551561578', '20', 'M', '2020-02-10', '6', '1', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Darshan Suthar', '1551561577', '20', 'M', '2021-12-12', '6', '1', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Srinu', '1551561576', '19', 'F', '2021-03-11', '6', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Akhil', '1551561575', '19', 'M', '2021-09-14', '6', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vijetha', '1551561574', '19', 'F', '2021-12-11', '6', '3', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pubg Teams', '1551561573', '18', 'M', '2022-07-19', '6', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Esha', '1551561572', '19', 'F', '2020-02-10', '6', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mehboob Shaik', '1551561571', '21', 'M', '2021-09-14', '6', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Meet Modi', '1551561579', '22', 'M', '2021-11-03', '6', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nikhil ', '1551561578', '23', 'M', '2020-02-10', '6', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Sriraam', '1551561577', '23', 'M', '2021-01-23', '6', '12', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Deepak', '1551561576', '25', 'M', '2020-05-11', '6', '12', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Bahaav', '1551561575', '22', 'M', '2021-03-11', '6', '12', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Navya', '1551561574', '22', 'F', '2020-06-29', '6', '1', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sharwan', '1551561573', '21', 'M', '2021-12-11', '6', '1', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ritika Saini', '1551561572', '22', 'F', '2021-09-14', '6', '1', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Maya', '1551561571', '22', 'F', '2021-12-12', '6', '1', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Justin', '1521531549', '23', 'M', '2020-02-10', '6', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sanju', '1521531548', '24', 'F', '2021-12-11', '6', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Kodari Bhavada', '1521531547', '25', 'M', '2021-03-11', '6', '1', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Grado', '1521531546', '18', 'M', '2021-12-12', '5', '6', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ram', '1521531545', '19', 'M', '2020-02-10', '5', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rutvik', '1521531544', '19', 'M', '2021-12-11', '5', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Livin Shinami', '1521531543', '18', 'F', '2022-07-19', '5', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Karthik', '1521531543', '18', 'M', '2021-09-14', '5', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Srujana', '1521531542', '18', 'F', '2021-11-03', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Amrish', '1521531541', '18', 'M', '2021-08-06', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Jahnvi', '1491501519', '19', 'F', '2020-05-11', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rohan', '1491501518', '20', 'M', '2021-12-12', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shalini', '1491501517', '21', 'F', '2021-09-14', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Samkhya', '1491501516', '21', 'F', '2020-02-10', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ankshitha', '1491501515', '21', 'F', '2020-02-10', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rohith', '1491501514', '22', 'M', '2021-12-11', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Balajii', '1491501513', '22', 'M', '2020-02-10', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shravani', '1491501512', '22', 'F', '2021-09-14', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aditi ', '1491501511', '23', 'F', '2021-03-11', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Krushi', '1461471489', '24', 'F', '2021-12-12', '5', '3', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Bhavishya', '1461471488', '24', 'F', '2021-12-11', '5', '3', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Sajita ', '1461471487', '25', 'F', '2021-08-06', '5', '1', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Vishnu Vardhan', '1461471486', '25', 'M', '2022-07-19', '5', '1', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sriya', '1461471485', '23', 'F', '2020-02-10', '5', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Narayan', '1461471484', '23', 'M', '2020-02-10', '4', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ditya', '1461471483', '22', 'M', '2021-09-14', '4', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sairam', '1461471482', '21', 'F', '2021-12-12', '4', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Jagan', '1461471481', '21', 'M', '2021-08-06', '4', '1', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Teju', '1431441459', '18', 'M', '2021-11-03', '4', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Shrey', '1431441458', '18', 'F', '2021-03-11', '4', '1', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Aditya', '1431441457', '18', 'M', '2021-12-11', '4', '1', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mohit', '1431441456', '18', 'M', '2020-02-10', '4', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Purvitha', '1431441455', '18', 'F', '2021-12-12', '4', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rahul', '1431441454', '19', 'M', '2021-09-14', '4', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Surya', '1431441453', '19', 'M', '2020-02-10', '4', '1', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shriti', '1431441452', '19', 'F', '2021-08-06', '4', '1', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Abhinav', '1431441451', '19', 'M', '2020-05-11', '4', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Sanjana', '1401411429', '20', 'F', '2022-07-19', '4', '12', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Gopi', '1401411428', '20', 'F', '2021-11-03', '4', '12', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Yash ', '1401411427', '20', 'M', '2020-02-10', '4', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aranav', '1401411426', '20', 'M', '2021-12-11', '4', '12', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anshika', '1401411425', '20', 'F', '2021-09-14', '4', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Adithya', '1401411424', '20', 'M', '2021-12-12', '4', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nischit', '1401411423', '21', 'M', '2020-06-29', '4', '12', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Missa Shiva', '1401411422', '21', 'F', '2021-03-11', '4', '12', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shiva', '1401411421', '21', 'M', '2021-08-06', '4', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Deevakshi', '1371381399', '21', 'F', '2020-02-10', '4', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Uday ', '1371381398', '22', 'M', '2021-12-11', '4', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Bhavik', '1371381397', '18', 'M', '2021-01-23', '4', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Raj', '1371381396', '22', 'M', '2022-07-19', '4', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('SathviMalikarjun', '1371381395', '22', 'M', '2020-05-11', '4', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sai Chain', '1371381394', '22', 'F', '2021-09-14', '4', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sunny Rohit', '1371381393', '22', 'F', '2021-11-03', '3', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Lahari', '1611621631', '23', 'F', '2020-02-10', '3', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sravan', '1371381391', '23', 'M', '2021-09-14', '3', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Dheeraj', '1341351369', '23', 'M', '2021-12-12', '3', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Raja Saini', '1341351368', '23', 'M', '2020-06-29', '3', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Hemant Moond', '1341351367', '24', 'M', '2021-12-11', '3', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Payal Ranwa', '1341351366', '19', 'F', '2021-08-06', '3', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nikita Pareek', '1341351365', '19', 'F', '2022-07-19', '3', '1', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vikram Singh', '1341351364', '20', 'M', '2021-09-14', '3', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Gaurav Saini', '1341351363', '20', 'M', '2020-02-10', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES (' Mahima', '1341351362', '20', 'F', '2021-11-03', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Tara', '1341351361', '20', 'F', '2021-03-11', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rohith', '1311321339', '20', 'M', '2021-12-11', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pakhi', '1311321338', '20', 'F', '2020-05-11', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Laxmi ', '1311321337', '20', 'F', '2020-06-29', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Dheeraj', '1311321336', '20', 'M', '2020-02-10', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Akshay Pawar', '1311321335', '20', 'M', '2021-01-23', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shruti Reddy', '1311321334', '20', 'F', '2021-09-14', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shreya Reddy', '1311321333', '20', 'F', '2021-12-11', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Praneeth', '1311321332', '20', 'M', '2021-12-12', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Abhinav Anil', '1311321331', '20', 'M', '2021-08-06', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Bhanu Shahni', '1281291309', '21', 'M', '2022-07-19', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sunil', '1281291308', '21', 'M', '2021-11-03', '3', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Lakshit', '1281291307', '21', 'M', '2021-09-14', '2', '6', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kanchan', '1281291306', '21', 'F', '2020-06-29', '2', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Tipsy', '1281291305', '21', 'F', '2020-02-10', '2', '6', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Dolsi', '1281291304', '19', 'F', '2021-03-11', '2', '6', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Renu', '1281291303', '19', 'F', '2021-12-11', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Suman', '1281291302', '18', 'F', '2020-05-11', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rasmitha', '1281291301', '19', 'F', '2021-12-12', '2', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mnohar', '1251261279', '18', 'M', '2021-09-14', '2', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vepoor', '1251261278', '19', 'F', '2021-11-03', '2', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kunal', '1251261277', '18', 'M', '2020-02-10', '1', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Satya Surya', '1251261276', '19', 'M', '2021-08-06', '1', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vishnu Teja', '1251261275', '18', 'M', '2021-09-14', '1', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ritika Rathore', '1251261274', '19', 'F', '2020-02-10', '1', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Devndra Rathore', '1251261274', '18', 'M', '2021-12-11', '1', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pankaj Naik', '1251261273', '18', 'M', '2022-07-19', '1', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rahul Naik', '1251261272', '19', 'M', '2021-03-11', '1', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mahesh Singhla', '1251261271', '18', 'M', '2021-12-12', '3', '6', '5');
UPDATE `fitness_center_management`.`member_info` 
SET `add_on1` = '5' 
WHERE (`Member_ID` = '52') AND (`Branch` = '1') AND (`Package` = '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Snehal Singh', '2012022031', '25', 'M', '2021-10-10', '5', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sesidhar', '2012022032', '25', 'M', '2021-08-12', '4', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sohan', '2012022033', '25', 'M', '2020-09-10', '3', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Inara', '2012022034', '25', 'F', '2020-06-11', '2', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anushka', '2012022035', '24', 'F', '2021-10-10', '1', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Harshita', '2012022036', '24', 'F', '2019-10-10', '2', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Arpita', '2012022037', '24', 'F', '2019-08-08', '3', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sachin Shenoy', '2012022038', '24', 'M', '2020-05-12', '4', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Arunav', '2012022039', '23', 'M', '2019-08-08', '5', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Amisha Raghav', '2042052061', '23', 'F', '2021-10-10', '6', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anisha', '2042052062', '23', 'F', '2021-08-12', '5', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vaibhav Jamadagi', '2042052063', '23', 'M', '2021-04-10', '4', '3', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Ashwin', '2042052064', '23', 'M', '2020-09-10', '3', '3', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Dakshata', '2042052065', '22', 'F', '2019-07-07', '2', '3', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Aakriti', '2042052066', '22', 'F', '2021-10-10', '1', '3', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Srilalitha', '2042052067', '22', 'F', '2019-06-06', '2', '3', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Varuni Kalkumari', '2042052068', '18', 'F', '2019-05-05', '3', '3', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Anamika', '2042052069', '18', 'F', '2021-10-10', '4', '3', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Niramal', '2042052071', '18', 'M', '2020-05-12', '5', '3', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Lucky Poonia', '2042052072', '19', 'M', '2019-08-08', '6', '3', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pramath Bhat', '2042052073', '19', 'M', '2021-07-11', '5', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Gaurav Bijjanda', '2042052075', '19', 'M', '2021-08-12', '4', '6', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shantanu', '2042052076', '19', 'M', '2021-10-10', '3', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Varun Malani', '2042052077', '19', 'M', '2020-05-12', '2', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Suraj', '2042052078', '19', 'F', '2019-10-10', '1', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sneha', '2042052079', '18', 'F', '2019-07-07', '2', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pradyuman', '2042052081', '18', 'M', '2021-10-10', '3', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ashrit', '2042052082', '18', 'M', '2021-07-11', '4', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shruti', '2042052083', '18', 'F', '2019-06-06', '5', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Adit Nair', '2042052084', '18', 'M', '2021-04-10', '6', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Prakhar Goel', '2042052085', '20', 'M', '2021-10-10', '5', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mayank Virmani', '2042052086', '20', 'M', '2020-06-11', '4', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Dunkan', '2042052087', '20', 'M', '2020-09-10', '3', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Dimple', '2042052089', '20', 'F', '2021-07-11', '2', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aroma Agarwal', '2042052091', '20', 'M', '2021-08-12', '1', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Samudra', '2042052092', '20', 'M', '2020-05-12', '2', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Piyush Brora', '2042052093', '20', 'M', '2019-08-08', '3', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anisha Anilkumar', '2042052094', '20', 'F', '2019-10-10', '4', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ashwin', '2042052095', '20', 'M', '2020-09-10', '5', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Paul John', '2042052096', '20', 'M', '2021-04-10', '6', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Namitha', '2042052097', '20', 'F', '2021-10-10', '5', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rishab Kasyap', '2042052098', '19', 'M', '2019-08-08', '4', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ameya', '2042052099', '19', 'M', '2019-07-07', '3', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vishal Poonia', '2112122131', '25', 'M', '2019-06-06', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Suhas Bhat', '2112122132', '25', 'M', '2019-08-08', '1', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sheetal Sriram', '2112122133', '25', 'M', '2020-09-10', '2', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Tina Agarwal', '2112122134', '24', 'F', '2019-07-07', '3', '12', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anirudh Mahal', '2112122135', '24', 'M', '2021-10-10', '4', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pranav ', '2112122136', '23', 'M', '2021-07-11', '5', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kulachi', '2112122137', '23', 'F', '2021-08-12', '6', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sachin Mathew', '2112122138', '24', 'M', '2021-04-10', '5', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shreya Bhat', '2112122139', '25', 'F', '2021-10-10', '4', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Lakshya', '2112122141', '22', 'F', '2020-09-10', '3', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Jyotsana ', '2112122142', '23', 'F', '2019-10-10', '2', '12', '2', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Paritosh Sujit', '2112122143', '23', 'M', '2021-08-12', '1', '12', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Hemanth', '2112122144', '23', 'M', '2021-10-10', '2', '12', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sudhir', '2112122145', '23', 'M', '2020-06-11', '3', '12', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Kunal Mujoo', '2112122146', '23', 'M', '2021-07-11', '4', '12', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Eashan Goel', '2112122147', '22', 'M', '2021-04-10', '5', '1', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Namu', '2112122148', '22', 'F', '2020-09-10', '6', '12', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Prakirth', '2112122149', '21', 'M', '2020-05-12', '5', '3', '4', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Aaditya Vanikar', '2152162111', '21', 'M', '2019-08-08', '4', '3', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aaditya Nair', '2152162112', '19', 'M', '2021-10-10', '3', '3', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Eshaan Kale', '2152162113', '19', 'M', '2019-10-10', '2', '3', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Ishitha', '2152162114', '19', 'F', '2021-10-10', '1', '3', '4', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Shrek', '2152162115', '19', 'M', '2021-04-10', '2', '3', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Tanish', '2152162116', '19', 'M', '2021-07-11', '3', '3', '4');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nidhi', '2152162117', '19', 'F', '2021-10-10', '4', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Parth Khambe', '2152162118', '18', 'M', '2020-06-11', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Preeti Gupta', '2152162119', '18', 'F', '2021-08-12', '6', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Chirag patil ', '2152162121', '18', 'M', '2021-04-10', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Harshini Raman', '2152162122', '18', 'F', '2019-08-08', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Inayah', '2152162123', '18', 'M', '2020-09-10', '4', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Samyama', '2152162124', '18', 'F', '2019-07-07', '3', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pranav', '2152162125', '18', 'M', '2019-06-06', '2', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sahil Loo', '2152162126', '22', 'M', '2020-05-12', '1', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Priyanshu Gaurav', '2152162127', '21', 'M', '2019-06-06', '2', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Mananjot', '2152162128', '21', 'F', '2019-05-05', '3', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pranav Kashyup', '2152162129', '21', 'M', '2019-08-08', '4', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Arjun Anand', '2152162131', '21', 'M', '2021-10-10', '5', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Stuti', '2152162132', '21', 'F', '2019-06-06', '6', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Akarsh', '2152162133', '22', 'M', '2021-04-10', '5', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shria', '2152162134', '22', 'F', '2021-07-11', '4', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Poorani', '2152162135', '22', 'F', '2020-09-10', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pranav', '2152162136', '22', 'M', '2021-10-10', '2', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nithin', '2152162137', '22', 'M', '2019-06-06', '2', '12', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Anushka Goud', '2152162138', '22', 'F', '2019-08-08', '1', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nikita Ijari', '2152162139', '23', 'F', '2019-07-07', '1', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Pooja Shankar', '2152162141', '23', 'F', '2020-06-11', '2', '12', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sana Fathima', '2152162142', '23', 'F', '2019-10-10', '3', '12', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Sriram Bala', '2152162143', '25', 'M', '2021-08-12', '4', '12', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Amandeep', '2152162144', '25', 'M', '2019-08-08', '4', '12', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Manshi', '2152162145', '25', 'F', '2021-07-11', '5', '12', '8', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Rishab', '2152162146', '25', 'M', '2021-10-10', '6', '12', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Thilak Shriyan', '2152162147', '24', 'M', '2019-06-06', '6', '12', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Shruti Menon', '2152162148', '23', 'F', '2021-10-10', '6', '12', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Sanjana Prasad', '2152162149', '23', 'F', '2019-08-08', '3', '12', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nehal Salecha', '2152162151', '22', 'F', '2020-05-12', '3', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Raina Shahani', '2152162152', '22', 'F', '2021-10-10', '3', '1', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sarfraz', '2152162153', '22', 'M', '2019-10-10', '3', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Riya Joseph', '2152162154', '21', 'F', '2020-06-11', '3', '1', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Elisha Lobo', '2152162155', '21', 'F', '2021-04-10', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ravi Kumar', '2152162156', '20', 'M', '2021-07-11', '3', '1', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Kartik Vaya', '2152162157', '19', 'M', '2020-09-10', '3', '1', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Navya', '2152162158', '19', 'F', '2021-10-10', '3', '3', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Saahil ', '2152162159', '25', 'M', '2019-10-10', '3', '3', '7');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nishant Mathu', '2152162161', '24', 'M', '2019-07-07', '3', '3', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Varun', '2152162162', '23', 'M', '2019-08-08', '4', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Suraj', '2152162163', '21', 'F', '2021-10-10', '4', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Deepti', '2152162164', '22', 'F', '2020-05-12', '4', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aaditya', '2152162165', '23', 'M', '2019-06-06', '4', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pranav Kale', '2152162166', '22', 'M', '2020-09-10', '4', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aaditya Nair', '2152162167', '21', 'M', '2021-07-11', '4', '3', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sahil Pathak', '2152162168', '20', 'M', '2021-10-10', '4', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Vishawjeet', '2152162169', '19', 'M', '2021-10-10', '4', '6', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Raahul Dutt', '2152162171', '19', 'M', '2021-10-10', '4', '12', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Chinmya', '2152162172', '18', 'M', '2021-04-10', '5', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Niharika', '2152162173', '17', 'F', '2019-10-10', '5', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Aryan', '2152162174', '18', 'M', '2020-09-10', '5', '12', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Devansh', '2152162175', '19', 'M', '2021-10-10', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sashank Pandey', '2152162176', '18', 'M', '2020-05-12', '5', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Tejaswi', '2152162177', '18', 'M', '2021-07-11', '6', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Valllabh', '2152162178', '19', 'M', '2021-04-10', '6', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Uttara', '2152162179', '19', 'M', '2020-09-10', '6', '6', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Raunaq', '2152162181', '19', 'F', '2019-08-08', '6', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ashwin R', '2152162182', '24', 'M', '2019-10-10', '5', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Denver Pereina', '2152162183', '24', 'M', '2019-07-07', '4', '3', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Rishab Jain', '2152162184', '23', 'M', '2021-10-10', '3', '3', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Urbane', '2152162185', '23', 'M', '2020-09-10', '2', '3', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rahul Radhakrishana', '2152162186', '23', 'M', '2020-05-12', '1', '3', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Ayushman', '2152162187', '22', 'M', '2021-07-11', '1', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Teja Kalpur', '2152162188', '22', 'M', '2019-10-10', '2', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sucheta Kalpur', '2152162189', '21', 'F', '2020-05-12', '3', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Sucheta Vikram', '2152162191', '21', 'F', '2019-06-06', '4', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Priyansh Jain', '2152162192', '21', 'M', '2021-04-10', '5', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Rahul Nair', '2152162193', '21', 'M', '2021-07-11', '6', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Parth Lakhani', '2152162194', '21', 'M', '2020-09-10', '5', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Pradyuman', '2152162195', '21', 'M', '2020-06-11', '4', '6', '1');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Kaushik', '2152162196', '26', 'M', '2019-07-07', '3', '6', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Rohit Kanchi', '2152162197', '25', 'M', '2019-10-10', '2', '6', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nirmail Gk', '2152162198', '24', 'M', '2020-09-10', '1', '1', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Guru', '2152162199', '24', 'M', '2021-08-12', '2', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Nithin', '3613623611', '23', 'M', '2021-07-11', '3', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Shaurya', '3613623612', '23', 'F', '2019-08-08', '4', '1', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Gautam', '3613623613', '23', 'M', '2020-06-11', '5', '1', '8', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nupur Mahale', '3613623614', '22', 'F', '2019-10-10', '6', '1', '7', '3');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Avival', '3613623615', '21', 'M', '2021-04-10', '5', '1', '6');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Viggy', '3613623616', '22', 'F', '2021-10-10', '4', '1', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Vans', '3613623617', '22', 'M', '2021-08-12', '2', '1', '4', '8');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`, `add_on1`) 
VALUES ('Nidhi ', '3613623619', '20', 'F', '2020-09-10', '2', '1', '3', '5');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Neeraj', '3613623621', '20', 'M', '2021-10-10', '1', '1', '2');
INSERT INTO `fitness_center_management`.`member_info` (`Member_Name`, `Contact_Info`, `Age`, `Gender`, `Joining_Date`, `Branch`, `Duration_In_Months`, `Package`) 
VALUES ('Youandme', '3613623622', '18', 'F', '2020-05-12', '6', '12', '1');


-- USE Of UPDATE and DELETE
UPDATE `member_info` SET `add_on1` = '2' WHERE (`Member_ID` = '152')  ;
UPDATE `package` SET `Pkg_Name` = 'Super_Jumbo' WHERE (`Pkg_ID` = '6');
UPDATE `pkg_excercise` SET `Excercise_ID` = '1' WHERE (`Pkg_ID` = '7') AND (`Excercise_ID` = '7');
UPDATE `pkg_excercise` SET `Pkg_ID` = '8', `Excercise_ID` = '2' WHERE (`Pkg_ID` = '7') AND (`Excercise_ID` = '8');
DELETE FROM `pkg_excercise` WHERE (`Pkg_ID` = '7') AND (`Excercise_ID` = '10');
INSERT INTO `pkg_excercise` (`Pkg_ID`, `Excercise_ID`) 
VALUES ('4', '10');
UPDATE `member_info` SET `add_on1` = '2', `add_on2` = '8' WHERE (`Member_ID` = '26') ;
UPDATE `member_info` SET `add_on2` = '9' WHERE (`Member_ID` = '30') ;
UPDATE `member_info` SET `add_on1` = '5' WHERE (`Member_ID` = '48') ;
UPDATE `member_info` SET `add_on2` = '6' WHERE (`Member_ID` = '57');
UPDATE `member_info` SET `add_on1` = '5' WHERE (`Member_ID` = '58');
UPDATE `member_info` SET `add_on1` = '3' WHERE (`Member_ID` = '44');
UPDATE `member_info` SET `add_on1` = '10' WHERE (`Member_ID` = '74');
UPDATE `member_info` SET `add_on1` = '10', `add_on2` = '5' WHERE (`Member_ID` = '76');
UPDATE `member_info` SET `add_on1` = '2' WHERE (`Member_ID` = '108') ;
UPDATE `member_info` SET `add_on1` = '6' WHERE (`Member_ID` = '152') ;
UPDATE `member_info` SET `add_on1` = '2' WHERE (`Member_ID` = '154') ;
UPDATE `member_info` SET `add_on1` = '5', `add_on2` = '2' WHERE (`Member_ID` = '159') ;
UPDATE `member_info` SET `add_on1` = '9', `add_on2` = '10' WHERE (`Member_ID` = '213') ;
UPDATE `member_info` SET `add_on1` = '2' WHERE (`Member_ID` = '224') ;
UPDATE `member_info` SET `add_on1` = '2', `add_on2` = '8' WHERE (`Member_ID` = '239') ;
UPDATE `member_info` SET `add_on2` = '2' WHERE (`Member_ID` = '252') ;
UPDATE `member_info` SET `add_on1` = '9' WHERE (`Member_ID` = '262') ;
UPDATE `member_info` SET `add_on1` = '10' WHERE (`Member_ID` = '309') ;
UPDATE `member_info` SET `add_on1` = NULL WHERE `Package` = '8' AND `add_on1` ='2' ;
-- select and order by ASC
SELECT * FROM 
`member_info`
ORDER BY `Branch` ASC;
 
 -- order by desc
 SELECT * FROM `manager_info`
 ORDER BY `Monthly_Salary` DESC;
 
-- USE of Where Clause 
SELECT `Member_ID`,`Member_Name`,`Branch`,`Age`
FROM `member_info`
WHERE `Age` <'18';

-- use of and, or, not
SELECT * FROM `trainer_info`
WHERE (`Branch`='1' OR `Branch`='2')
AND `Excercise`='1'
AND NOT `Monthly_Salary`>'10000';

-- use of 'IS NULL' and 'IS NOT NULL'
SELECT * FROM `member_info`
WHERE `add_on1` IS NULL;

SELECT * FROM `member_info`
WHERE `add_on2` IS NOT NULL;

-- View, inner join, order by 
CREATE VIEW `Package Details` AS 
SELECT `package`.`Pkg_ID`,`package`.`Pkg_Name`,`excercise`.`Excercise_Name`,`excercise`.`Monthly_Cost`
FROM ((`pkg_excercise` `pe`
INNER JOIN `Package` ON `Package`.`Pkg_ID`=`pe`.`Pkg_ID`)
INNER JOIN `Excercise` ON `Excercise`.`ID`=`pe`.`Excercise_ID`)
ORDER BY `Package`.`Pkg_ID`;
SELECT * FROM `Package Details`;

--  GROUP BY , SUM
CREATE VIEW `Package Monthly Cost` AS
SELECT `package`.`Pkg_ID` AS `Pkg_ID`,`Package`.`Pkg_Name`, SUM(`Excercise`.`Monthly_Cost`) AS `Pkg Monthly Cost`
FROM ((`pkg_excercise` `pe`
INNER JOIN `Package` ON `Package`.`Pkg_ID`=`pe`.`Pkg_ID`)
INNER JOIN `Excercise` ON `Excercise`.`ID`=`pe`.`Excercise_ID`)
GROUP BY  `package`.`Pkg_ID`
ORDER BY `Package`.`Pkg_ID`;
SELECT * FROM `Package Monthly Cost`;

-- COUNT AND Having
SELECT `Branch`.`Branch_ID`,`Manager_Info`.`Manager_Name`, COUNT(DISTINCT `member_info`.`member_ID`) AS `Total Members`, COUNT(DISTINCT `Trainer_Info`.`Trainer_ID`) AS `Total Trainers`
FROM `Manager_Info`,`Branch`,`Member_Info`,`Trainer_Info`
WHERE `Manager_Info`.`ID`=`Branch`.`Branch_ID`
AND `Member_Info`.`Branch`=`Branch`.`Branch_ID`
AND `Trainer_Info`.`Branch`=`Branch`.`Branch_ID`
GROUP BY  `Branch`.`Branch_ID`
HAVING (`Total members`>'50')
ORDER BY `Branch`.`Branch_ID`;

-- UNION
CREATE VIEW `Cost Cal2` AS
SELECT `Member_Info`.`Member_ID`,(`Package Monthly Cost`.`Pkg Monthly Cost`+ `e1`.`Monthly_Cost` + `e2`.`Monthly_cost`)  AS `Payable Amount`
FROM (((`Member_Info`
INNER JOIN `package monthly cost` ON `Member_Info`.`Package`=`Package Monthly Cost`.`Pkg_ID`)
INNER JOIN `Excercise` `e1` ON `Member_Info`.`add_on1`=`e1`.`ID`)
INNER JOIN `Excercise` `e2` ON `Member_Info`.`add_on2`=`e2`.`ID`)
ORDER BY `Member_Info`.`Member_ID`;

CREATE VIEW `Cost Cal0` AS
SELECT `m1`.`Member_ID`,(`Package Monthly Cost`.`Pkg Monthly Cost`)  AS `Payable Amount`
FROM (`Member_Info` `m1`
INNER JOIN `package monthly cost` ON `m1`.`Package`=`Package Monthly Cost`.`Pkg_ID`)
WHERE `m1`.`add_on1` IS NULL 
AND `m1`.`add_on2` IS NULL
ORDER BY `m1`.`Member_ID`;
SELECT * FROM `cost cal0`
ORDER BY `Member_ID`;

CREATE VIEW `Cost Cal1` AS
SELECT `m2`.`Member_ID`,(`Package Monthly Cost`.`Pkg Monthly Cost`+ `e1`.`Monthly_Cost`)  AS `Payable Amount`
FROM ((`Member_Info` `m2`
INNER JOIN `package monthly cost` ON `m2`.`Package`=`Package Monthly Cost`.`Pkg_ID`)
INNER JOIN `Excercise` `e1` ON `m2`.`add_on1`=`e1`.`ID`)
WHERE `m2`.`add_on2` IS NULL
ORDER BY `m2`.`Member_ID`;

CREATE VIEW `Cost Cal` AS 
SELECT `Cost Cal0`.`Member_ID`,`Cost Cal0`.`Payable Amount`
FROM `Cost Cal0`
UNION
SELECT `Cost Cal1`.`Member_ID`,`Cost Cal1`.`Payable Amount`
FROM `Cost Cal1`
UNION
SELECT `Cost Cal2`.`Member_ID`,`Cost Cal2`.`Payable Amount`
FROM `Cost Cal2`;

SELECT * FROM `Cost Cal`
ORDER BY `Member_ID`;


-- DATE_ADD , Mathematical Operators
CREATE VIEW `Member Details` AS
SELECT `Member_Info`.`Member_ID`, `Member_Info`.`Member_Name`,`Member_Info`.`Joining_Date`, DATE_ADD(`Member_Info`.`Joining_Date`, INTERVAL (`Member_Info`.`Duration_In_Months`) MONTH) AS `Valid Upto`, ((`Cost Cal`.`Payable Amount`)-(((`Cost Cal`.`Payable Amount`)/50) * (`Member_Info`.`Duration_In_Months`-1))) AS `Amount to be paid`
FROM `Member_Info`,`Cost Cal`
WHERE `Member_Info`.`Member_ID`=`Cost Cal`.`Member_ID`;
SELECT * FROM `Member Details`
ORDER BY `Member_ID`;

-- Monthly Expenditure and Income of Branch
CREATE VIEW `Branch wise Trainer Salary` AS
SELECT `Branch`.`Branch_ID`, SUM(`Trainer_info`.`Monthly_Salary`) AS `BMS`
FROM `Branch`, `Trainer_Info`
WHERE `Branch`.`Branch_ID`=`Trainer_info`.`branch`
GROUP BY `Branch`.`Branch_ID`
ORDER BY `Branch`.`Branch_ID`;

CREATE VIEW `Branch wise Member fee` AS
SELECT `Branch`.`Branch_ID`, SUM((`Member Details`.`Amount to be paid`)/(`Member_info`.`Duration_In_Months`)) AS `BME`
FROM `Branch`, `member_Info`,`member Details`
WHERE `Branch`.`Branch_ID`=`member_info`.`branch`
AND `member_info`.`member_ID`=`member details`.`member_ID`
GROUP BY `Branch`.`Branch_ID`
ORDER BY `Branch`.`Branch_ID`;

CREATE VIEW `Branch Details` AS
SELECT `Branch`.`Branch_ID`,`Branch`.`Branch_Name`, `Branch wise trainer salary`.`BMS`+`Manager_Info`.`Monthly_Salary` AS `Expenditure`, `Branch wise member fee`.`BME` AS `Income`
FROM `Branch`,`Manager_Info`,`Branch wise trainer salary`,`branch wise member fee`
WHERE `Branch wise trainer salary`.`Branch_ID`=`Branch`.`Branch_ID`
AND `Branch wise member fee`.`Branch_ID`=`Branch`.`Branch_ID`
AND `Manager_info`.`ID`=`Branch`.`Branch_ID`
GROUP BY `Branch`.`Branch_ID`
ORDER BY `Branch`.`Branch_ID`;
SELECT * FROM `Branch Details`;

-- MIN, MAX and AVG
SELECT  MAX(`Branch Details`.`Income`-`Branch Details`.`Expenditure`) AS `Maximum Profit From Any Branch`
FROM `Branch Details`;

SELECT  MIN(`Branch Details`.`Income`-`Branch Details`.`Expenditure`) AS `Minimum Profit From any Branch`
FROM `Branch Details`;

SELECT AVG(`Branch Details`.`Income`-`Branch Details`.`Expenditure`) AS `Average Profit of all branches`
FROM `Branch Details`;

-- IN and NOT IN AND Between
SELECT * FROM `Member_info`
WHERE `Branch` IN('1', '2','3');

SELECT * FROM `Member_info`
WHERE `Branch` NOT IN('4', '6');

SELECT * FROM `Trainer_Info`
WHERE `Monthly_Salary` BETWEEN '8000' AND '11000'
ORDER BY `Trainer_Name`;



-- EXISTS
SELECT `Branch`.`Branch_ID`,`Branch`.`Branch_Name`
FROM `Branch`
WHERE EXISTS(SELECT * FROM `Trainer_Info` WHERE `Trainer_Info`.`Branch`=`Branch`.`Branch_ID` AND `Trainer_Info`.`Monthly_Salary`>'8000');

-- ANY
SELECT `Branch`.`Branch_ID`,`Branch`.`Branch_Name`
FROM `Branch`
WHERE `Branch`.`Branch_ID`=ANY(SELECT `Branch` FROM `Trainer_Info` WHERE `Trainer_Info`.`Monthly_Salary`<='8000');

