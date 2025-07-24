# ✈️ Airline Reservation System – SQL Project

![Status](https://img.shields.io/badge/status-Completed-success)
![SQL](https://img.shields.io/badge/Language-SQL-blue)
![MySQL](https://img.shields.io/badge/Database-MySQL-orange)
![Author](https://img.shields.io/badge/Author-Dimple%20Mundhra-purple)


## 📌 Project Overview

The **Airline Reservation System** is a relational database project built using **MySQL Workbench**. It models core airline operations such as flights, customers, seat bookings, pricing, and scheduling. The system provides a range of queries, views, triggers, and reporting features to manage bookings, display availability, and calculate revenues efficiently.


## 🛠️ Tech Stack

| Tool          | Purpose                          |
|---------------|----------------------------------|
| MySQL Workbench | Database design & management   |
| SQL           | Queries, views, triggers, joins  |
| Git           | Version control                  |
| GitHub        | Code hosting and collaboration   |


## 🧱 Database Schema

### 🗂️ Tables

- `Flights` – Flight details and schedule  
- `Customers` – Customer personal data  
- `Seats` – Seat allocation and availability  
- `Bookings` – Flight reservations by customers  
- `Prices` – Class-based flight pricing  


## ✅ Features

- 🔄 **Normalized schema** (up to 3NF)  
- 📥 **Sample data** inserted for all tables  
- 🔍 Flight search and seat availability queries  
- 💺 Customer-wise booking summaries  
- 💰 Price and revenue calculation with joins  
- 📊 Views for available flights and booking summary  
- ⚙️ Trigger: auto-update seat availability post-booking  
- 🧠 Function: calculate flight duration in minutes  
- 🔐 Role-based access simulation with GRANT  


## 📈 Views & Reports

available_flights_view – Flights with available seats

booking_summary_view – Bookings with customer & flight details

booking_with_price – Extended view with seat fare

Revenue Report – Total bookings & earnings per flight

Top 3 Routes – Most frequently booked routes

## 🚀 How to Run

Open MySQL Workbench

Run airline_reservation_system.sql script to create schema, tables, triggers, views

Execute queries to test booking system

Customize as per your needs (e.g., more flights, fare logic)

## 📂 Project Structure

📁 airline_reservation_system/
├── airline_reservation_system.sql
├── README.md
├── ER_Diagram.png

## 👩‍💻 Author
Dimple Mundhra
📍 Kolkata, India
📧 dimplemundhra24@gmail.com


## 📄 License
This Project is for my own educational learning purpose




