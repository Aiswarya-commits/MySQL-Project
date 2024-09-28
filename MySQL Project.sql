create database library;
use library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
desc Branch;
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
desc Employee;
CREATE TABLE Books (
    ISBN VARCHAR(13) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),  
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
desc Books;
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
desc Customer;
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(13),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
desc IssueStatus;
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(13),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
desc ReturnStatus;

#  1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

# 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

# 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT Books.Book_title, Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

# 4. Display the total count of books in each category. 
SELECT Category, COUNT(*) AS total_books
FROM Books
GROUP BY Category;

# 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

# 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer.Customer_name
FROM Customer
LEFT JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE Reg_date < '2022-01-01' AND IssueStatus.Issue_Id IS NULL;

#  7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS total_employees
FROM Employee
GROUP BY Branch_no;

# 8. Display the names of customers who have issued books in the month of June 2023.
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

# 9. Retrieve book_title from book table containing history.
SELECT Book_title
FROM Books
WHERE Book_title LIKE '%history%';

# 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS total_employees
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

# 11. Retrieve the names of employees who manage branches and their respective branch addresses. 
SELECT Employee.Emp_name, Branch.Branch_address
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

#  12. Display the names of customers who have issued books with a rental price higher than Rs
SELECT Customer.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id
WHERE Books.Rental_Price > 100;


