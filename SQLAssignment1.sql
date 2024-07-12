create database Salesdb;
drop database Salesdb;
use Salesdb;
create table productlines (
     productLine VARCHAR(50) PRIMARY KEY,
     textDescription VARCHAR(4000),
     htmlDescription MEDIUMTEXT,
     image MEDIUMBLOB
);
create table products (
     productCode VARCHAR(15) PRIMARY KEY,
     productName VARCHAR(70) NOT NULL,
     productLine VARCHAR(50),
     CONSTRAINT Product_Detail FOREIGN KEY (productLine) REFERENCES productlines(productLine),
     productScale VARCHAR(10) NOT NULL,
     productVendor VARCHAR(50) NOT NULL,
     productDescription TEXT NOT NULL,
     quantityInStock SMALLINT NOT NULL,
     buyPrice DECIMAL(10, 2) NOT NULL,
     MSRP DECIMAL(10, 2) NOT NULL
);
create table employees (
     employeeNumber INT PRIMARY KEY Unique ,
     lastName VARCHAR(50) NOT NULL,
     firstName VARCHAR(50) NOT NULL,
     extension VARCHAR(10) NOT NULL,
     email VARCHAR(100) NOT NULL,
     officeCode VARCHAR(10),
     CONSTRAINT Office_Detail FOREIGN KEY (officeCode) REFERENCES offices(officeCode),
     reportsTo INT,
     CONSTRAINT Report_Detail FOREIGN KEY (reportsTo) REFERENCES employees(employeeNumber),
     jobTitle VARCHAR(50) NOT NULL
);
create table offices (
     officeCode VARCHAR(10) PRIMARY KEY,
	 city VARCHAR(50) NOT NULL,
     phone VARCHAR(50) NOT NULL,
     addressLine1 VARCHAR(50) NOT NULL,
     addressLine2 VARCHAR(50),
	 state VARCHAR(50),
     country VARCHAR(50) NOT NULL,
	 postalCode VARCHAR(15) NOT NULL,
     territory VARCHAR(10) NOT NULL
);
create table customers (
     customerNumber INT PRIMARY KEY,
     customerName VARCHAR(50) NOT NULL,
     contactLastName VARCHAR(50) NOT NULL,
     contactFirstName VARCHAR(50) NOT NULL,
     phone VARCHAR(50) NOT NULL,
	 addressLine1 VARCHAR(50) NOT NULL,
     addressLine2 VARCHAR(50),
     city VARCHAR(50) NOT NULL,
     state VARCHAR(50),
	 postalCode VARCHAR(15),
	 country VARCHAR(50) NOT NULL,
     salesRepEmployeeNumber INT,
     CONSTRAINT Sales_Detail FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees(employeeNumber),
     creditLimit DECIMAL(10, 2)
);


create table orders (
	 orderNumber INT PRIMARY KEY,
	 orderDate DATE NOT NULL,
     requiredDate DATE NOT NULL,
     shippedDate DATE,
     status VARCHAR(15) NOT NULL,
     comments TEXT,
     customerNumber INT,
     constraint Number_Datils FOREIGN KEY (customerNumber) references customers(customerNumber)
);
CREATE TABLE orderdetails (
    orderNumber INT,
    productCode VARCHAR(15),
    quantityOrdered INT NOT NULL,
    priceEach DECIMAL(10, 2) NOT NULL,
    orderLineNumber SMALLINT NOT NULL,
    PRIMARY KEY (orderNumber, productCode),
    FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber),
    FOREIGN KEY (productCode) REFERENCES products(productCode)
);
CREATE TABLE payments (
    customerNumber INT,
    checkNumber VARCHAR(50) PRIMARY KEY,
    paymentDate DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customerNumber) REFERENCES customers(customerNumber)
);
INSERT INTO productlines (productLine, textDescription)
VALUES
  ('Classic Cars', 'Cars from the 1950s and 1960s'),
  ('Motorcycles', 'A range of motorcycles');
  
INSERT INTO products (productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)
VALUES
  ('S10_1678', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever.', 7933, 48.81, 95.70);
INSERT INTO offices (officeCode, city, phone, addressLine1, addressLine2, state, country, postalCode, territory)
VALUES
  ('1', 'San Francisco', '+1 650 219 4782', '100 Market Street', 'Suite 300', 'CA', 'USA', '94080', 'NA');
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES
  (1002, 'Murphy', 'Diane', 'x5800', 'dmurphy@classicmodelcars.com', '1', NULL, 'President');
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city, country, salesRepEmployeeNumber, creditLimit)
VALUES
  (103, 'Atelier graphique', 'Schmitt', 'Carine', '40.32.2555', '54, rue Royale', 'Nantes', 'France', NULL, 21000.00);
INSERT INTO orders (orderNumber, orderDate, requiredDate, shippedDate, status, customerNumber)
VALUES
  (10100, '2003-01-06', '2003-01-13', '2003-01-10', 'Shipped', 103);
INSERT INTO orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
VALUES
  (10100, 'S10_1678', 30, 95.70, 1);
INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES
  (103, 'HQ336336', '2004-10-19', 6066.78);

