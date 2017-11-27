--Create procedure
DELIMITER //
CREATE PROCEDURE GetAllProducts()
   BEGIN
   SELECT *  FROM products;
   END //
DELIMITER ;

--Declaring variables
DECLARE variable_name datatype(size) DEFAULT default_value;
--eg
DECLARE total_sale INT DEFAULT 0;

--Assigning variables
--eg
DECLARE total_count INT DEFAULT 0;
SET total_count = 10;

--Using session variables
SET @tmp = 1;

--MySQL Stored Procedure Parameters
MODE param_name param_type(param_size)
--eg IN parameter
CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
--eg OUT parameter
CREATE PROCEDURE CountOrderByStatus(IN orderStatus VARCHAR(25), OUT total INT)
--eg INOUT parameter
CREATE PROCEDURE set_counter(INOUT count INT(4), IN inc INT(4))

--Stored procedures that return multiple values
CREATE PROCEDURE get_order_by_cust(IN cust_no INT, OUT shipped INT, OUT canceled INT, OUT resolved INT, OUT disputed INT)

--IF statement
IF expression THEN 
   statements;
END IF;

--IF ELSE statement
IF expression THEN
   statements;
ELSE
   else-statements;
END IF;

--IF ELSEIF ELSE
IF expression THEN
   statements;
ELSEIF elseif-expression THEN
   elseif-statements;
...
ELSE
   else-statements;
END IF;

--eg
IF creditlim > 50000 THEN
 SET p_customerLevel = 'PLATINUM';
ELSEIF (creditlim <= 50000 AND creditlim >= 10000) THEN
 SET p_customerLevel = 'GOLD';
ELSEIF creditlim < 10000 THEN
 SET p_customerLevel = 'SILVER';
END IF;

--CASE statement
CASE  case_expression
   WHEN when_expression_1 THEN commands
   WHEN when_expression_2 THEN commands
   ...
   ELSE commands
END CASE;

--eg
CASE customerCountry
 WHEN  'USA' THEN
    SET p_shiping = '2-day Shipping';
 WHEN 'Canada' THEN
    SET p_shiping = '3-day Shipping';
 ELSE
    SET p_shiping = '5-day Shipping';
END CASE;

CASE  
 WHEN creditlim > 50000 THEN 
    SET p_customerLevel = 'PLATINUM';
 WHEN (creditlim <= 50000 AND creditlim >= 10000) THEN
    SET p_customerLevel = 'GOLD';
 WHEN creditlim < 10000 THEN
    SET p_customerLevel = 'SILVER';
END CASE;

--WHILE loop statement
WHILE expression DO
   statements
END WHILE

--eg
WHILE x  <= 5 DO
 SET  str = CONCAT(str,x,',');
 SET  x = x + 1; 
END WHILE;

--REPEAT loop statement 
REPEAT
 statements;
UNTIL expression
END REPEAT

--eg
REPEAT
 SET  str = CONCAT(str,x,',');
 SET  x = x + 1; 
 UNTIL x  > 5
END REPEAT;

--LOOP Statement 
-- LOOP statement that executes a block of code repeatedly with an additional flexibility of using a loop label
-- LEAVE => The LEAVE statement allows you to exit the loop immediately without waiting for checking the condition like break in c++
-- ITERATE => The ITERATE statement allows you to skip the entire code under it and start a new iteration like continue in c++
--eg
loop_label: LOOP
 
 IF  x > 10 THEN 
 LEAVE  loop_label;
 END  IF;
            
 SET  x = x + 1;
 IF  (x mod 2) THEN
  ITERATE  loop_label;
 ELSE
  SET  str = CONCAT(str,x,',');
 END  IF;
 
END LOOP; 
 
--list procedures
SHOW PROCEDURE status;
SHOW PROCEDURE status where name like('%GetAllProducts%');
SHOW PROCEDURE status where db = 'test';

--show procedure source code
SHOW CREATE PROCEDURE GetAllProducts;

--Drop procedure
DROP PROCEDURE GetAllProducts;

--MySQL cursor
DECLARE cursor_name CURSOR FOR SELECT_statement;
OPEN cursor_name;
FETCH cursor_name INTO variables list;
CLOSE cursor_name;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
--eg
DELIMITER $$
 
CREATE PROCEDURE build_email_list (INOUT email_list varchar(4000))
BEGIN
 
 DECLARE v_finished INTEGER DEFAULT 0;
 DECLARE v_email varchar(100) DEFAULT "";
 
-- declare cursor for employee email
 DEClARE email_cursor CURSOR FOR 
 SELECT email FROM employees;
 
-- declare NOT FOUND handler
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;
 
 OPEN email_cursor;
 
 get_email: LOOP
 
 FETCH email_cursor INTO v_email;
 
 IF v_finished = 1 THEN 
 LEAVE get_email;
 END IF;
 
 -- build email list
 SET email_list = CONCAT(v_email,";",email_list);
 
 END LOOP get_email;
 
 CLOSE email_cursor;
 
END$$
 
DELIMITER ;

--MySQL Error Handling in Stored Procedures
DECLARE action HANDLER FOR condition_value statement;

--action
CONTINUE :  the execution of the enclosing code block ( BEGIN … END ) continues.
EXIT : the execution of the enclosing code block, where the handler is declared, terminates.

--condition_value
NOT FOUND
SQLEXCEPTION
SQLWARNING
SQLSTATE

--eg
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET finished = 1;
DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'SQLException invoked';
DECLARE EXIT HANDLER FOR 1062 SELECT 'MySQL error code 1062 invoked';
DECLARE EXIT HANDLER FOR SQLSTATE '23000' SELECT 'SQLSTATE 23000 invoked';

DECLARE table_not_found CONDITION for 1051;
DECLARE EXIT HANDLER FOR  table_not_found SELECT 'Please create table abc first';
SELECT * FROM abc;

--eg2
DELIMITER $$
 
CREATE PROCEDURE insert_article_tags_3(IN article_id INT, IN tag_id INT)
BEGIN
 
 DECLARE EXIT HANDLER FOR 1062 SELECT 'Duplicate keys error encountered';
 DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'SQLException encountered';
 DECLARE EXIT HANDLER FOR SQLSTATE '23000' SELECT 'SQLSTATE 23000';
 
 -- insert a new record into article_tags
 INSERT INTO article_tags(article_id,tag_id)
 VALUES(article_id,tag_id);
 
 -- return tag count for the article
 SELECT COUNT(*) FROM article_tags;
END

--MySQL Stored Function
CREATE FUNCTION function_name(param1,param2,…) RETURNS datatype(size) [NOT] DETERMINISTIC
BEGIN
 statements
END

--eg
DELIMITER //
CREATE FUNCTION CustomerLevel(p_creditLimit double) RETURNS VARCHAR(10) DETERMINISTIC
BEGIN
    DECLARE lvl varchar(10);
 
    IF p_creditLimit > 50000 THEN
		SET lvl = 'PLATINUM';
    ELSEIF (p_creditLimit <= 50000 AND p_creditLimit >= 10000) THEN
        SET lvl = 'GOLD';
    ELSEIF p_creditLimit < 10000 THEN
        SET lvl = 'SILVER';
    END IF;
 
 RETURN (lvl);
END
DELIMITER ;

--MySQL trigger syntax
CREATE TRIGGER trigger_name trigger_time trigger_event ON table_name
FOR EACH ROW
BEGIN
 ...
END;

--eg
DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW(); 
END$$
DELIMITER ;