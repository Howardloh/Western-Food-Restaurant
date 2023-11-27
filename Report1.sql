DECLARE
    -- Declare variables to store data
    v_category_id Categories.categoryID%TYPE;
    v_category_name Categories.categoryName%TYPE;
    v_total_items_sold NUMBER(10);
    v_total_quantity_sold NUMBER(10);
    v_total_revenue NUMBER(10, 2);
BEGIN
    -- Print header for the report
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Item Sales Analysis by Category');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(
        RPAD('Category', 30) || 
        RPAD('Total Items Sold', 20) || 
        RPAD('Total Quantity Sold', 20) || 
        'Total Revenue'
    );
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');

    -- Open a cursor to retrieve data
    FOR category_rec IN (SELECT categoryID, categoryName FROM Categories) LOOP
        v_category_id := category_rec.categoryID;
        v_category_name := category_rec.categoryName;

        -- Calculate total items sold, total quantity sold, and total revenue for the category
        SELECT 
            COUNT(oi.itemsID), 
            SUM(oi.orderQuantity), 
            SUM(oi.orderPrice)
        INTO 
            v_total_items_sold, 
            v_total_quantity_sold, 
            v_total_revenue
        FROM 
            OrderItems oi
        JOIN 
            Items i ON oi.itemsID = i.itemsID
        WHERE 
            i.categoryID = v_category_id;

        -- Display the report data
        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_category_name, 30) || 
            RPAD(v_total_items_sold, 20) || 
            RPAD(v_total_quantity_sold, 20) || 
            v_total_revenue
        );
    END LOOP;

    -- Print footer for the report
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------------');
END;
/