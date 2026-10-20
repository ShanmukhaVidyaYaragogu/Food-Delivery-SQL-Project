-- PostgreSQL. Run in a dedicated practice database.
-- WARNING: Drops project tables if they already exist.
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(80),
    signup_date DATE NOT NULL
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(120) NOT NULL,
    cuisine VARCHAR(60),
    city VARCHAR(80)
);

CREATE TABLE menu_items (
    item_id INT PRIMARY KEY,
    restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id),
    item_name VARCHAR(120) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    UNIQUE (restaurant_id, item_name)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers(customer_id),
    restaurant_id INT NOT NULL REFERENCES restaurants(restaurant_id),
    order_date TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('Delivered', 'Cancelled', 'Preparing', 'On the way')),
    delivery_fee NUMERIC(10,2) NOT NULL DEFAULT 0
        CHECK (delivery_fee >= 0)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL REFERENCES orders(order_id),
    item_id INT NOT NULL REFERENCES menu_items(item_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);
