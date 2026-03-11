# Northwind Sales Analysis – Capstone Project
The Northwind database is a well-known sample relational database that represents a fictional company called Northwind Traders, which imports and exports specialty food products. It was originally developed by Microsoft to help learners understand database concepts, SQL queries, and business data analysis. The database simulates real business operations by storing information about products, customers, employees, suppliers, orders, and shipping companies.

In the Northwind system, each table represents a different part of the business. For example, the Products table stores details about the food items sold by the company, including product name, price, and stock information. The Customers table contains details about the businesses or individuals purchasing products. The Suppliers table records information about companies that supply goods to Northwind Traders. These tables are connected through relationships using primary and foreign keys, which help maintain data consistency and allow efficient data retrieval.

The Orders and Order Details tables record transactions between customers and the company. They show which products were ordered, the quantity purchased, pricing, and delivery information. The Employees table keeps track of staff members responsible for managing orders, while the Shippers table stores details about companies responsible for delivering products.

Overall, the Northwind database provides a practical example of how relational databases work in real business environments. It is widely used for learning SQL, performing data analysis, and practicing database management concepts

## 📌 Project Overview
This project analyzes sales data from the Northwind database to uncover trends,
top-performing products, customers, and regions.

## 🛠 Tools Used
- SQL
- Microsoft Excel
- Power BI

## 📊 Files Included
- Capstone Project.sql – SQL queries used for analysis
- Northwind Dataset.xlsx – Raw dataset
- Sales Analytics Capstone Project.pbix – Power BI dashboard
- Northwind Sales Analysis.pdf – Final report
- Sales Analytics Capstone Project.png - Dashboard

## 📈 Key Insights
- Sales trends by year and region
- Top customers and products
- Revenue contribution analysis

## Steps to Create the Dashboard

1. **Set Up Your Environment**:
   - Choose a data analysis and visualization tool such as **Tableau**, **Power BI**, or **SQL**.
   - Prepare your **development environment** by installing necessary libraries or software.
   - Load the **Orders**, **Customers**, **Orders_Details**, **Employees** and **Product** and other datasets into your environment.

2. **Data Cleaning and Preparation**:
   - Ensure that each dataset is **cleaned** for null values, duplicates, and formatting inconsistencies.
   - **Join** the three tables as needed, such as using `Order ID` to match returns data with orders.
   - Create derived fields like **Total Profit**, **Profit Margin**, and **Sales Contribution**.

3. **KPI Calculation**:
   - Calculate **Total Sales**, **Total Profit**, **Total Quantity**, **Number of Orders**, and **Average orders**.
   - Summarize these metrics in a **KPI table** to be used in the dashboard.

4. **Data Visualization**:
   - Create various **charts and graphs**:
     - **Bar Charts** for top and bottom subcategories.
     - **Line Charts** for visualizing the **Yearly Sales Trend**.
     - **Pie Charts** for **Segment-wise Sales Share**.
     - **Geo Maps** for **Sales by Country**.
   - Use **filtering options** to allow users to filter data by **region, market, and customer segment**.

5. **Return Analysis**:
   - Visualize the number of returns across different **Region** and **product categories**.
   - Provide insights into patterns and potential issues causing returns.

## Conclusion
The analysis of the Northwind dataset shows that sales are mainly driven by a few key products, categories, and customers. Certain regions and employees contribute more to revenue, while shipping and freight data
highlight areas for operational improvement. Overall, the dataset demonstrates how data analysis can support better business decisions in sales, customer retention, and logistics.

## Dashboard
<img width="1119" height="626" alt="Northwind sales Dashboard" src="https://github.com/user-attachments/assets/f629bb20-12c9-40b2-ba5e-6739877ce062" />

