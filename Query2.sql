SET VERIFY OFF;
SET SERVEROUTPUT ON;

-- Declare bind variables
DEFINE month_in = NUMBER
DEFINE year_in = NUMBER

-- Prompt the user for input
ACCEPT month_in NUMBER PROMPT 'Enter Month (e.g., 1 for January): '
ACCEPT year_in NUMBER PROMPT 'Enter Year (e.g., 2023): '

-- Set column formatting
COLUMN "Item Name" FORMAT A40
COLUMN "Total Quantity" FORMAT 9999

CREATE OR REPLACE VIEW TopItemsByMonthYearView AS
SELECT
    i.itemName AS "Item Name",
    SUM(oi.orderQuantity) AS "Total Quantity"
FROM
    Orders o
JOIN
    OrderItems oi ON o.orderID = oi.orderID
JOIN
    Items i ON oi.itemsID = i.itemsID
GROUP BY
    i.itemName
ORDER BY
    SUM(oi.orderQuantity) DESC;

CREATE OR REPLACE VIEW Top10ItemsByMonthYearView AS
SELECT
    "Item Name",
    "Total Quantity"
FROM (
    SELECT
        i.itemName AS "Item Name",
        SUM(oi.orderQuantity) AS "Total Quantity",
        RANK() OVER (ORDER BY SUM(oi.orderQuantity) DESC) AS ranking
    FROM
        Orders o
    JOIN
        OrderItems oi ON o.orderID = oi.orderID
    JOIN
        Items i ON oi.itemsID = i.itemsID
    GROUP BY
        i.itemName
)
WHERE ranking <= 10;

-- Replace :month_in and :year_in with the substitution variables
SELECT * FROM (
    SELECT
        Items.itemName AS "Item Name",
        SUM(OrderItems.orderQuantity) AS "Total Quantity"
    FROM
        Orders
    JOIN
        OrderItems ON Orders.orderID = OrderItems.orderID
    JOIN
        Items ON OrderItems.itemsID = Items.itemsID
    WHERE
        EXTRACT(MONTH FROM Orders.orderDate) = &month_in
        AND EXTRACT(YEAR FROM Orders.orderDate) = &year_in
    GROUP BY
        Items.itemName
    ORDER BY
        SUM(OrderItems.orderQuantity) DESC
) WHERE ROWNUM <= 10;