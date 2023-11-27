-- Create a sequence to generate item IDs starting with I054
CREATE SEQUENCE itemincrease
  START WITH 54  -- Updated to start with I054
  INCREMENT BY 1;

-- Create a procedure to add a new item with an auto-incremented item ID
CREATE OR REPLACE PROCEDURE AddNewItem(
    p_itemName IN VARCHAR2,
    p_itemDescription IN VARCHAR2,
    p_itemPrice IN VARCHAR2, -- Changed the parameter type to VARCHAR2
    p_itemAvailability IN VARCHAR2,
    p_categoryID IN VARCHAR2
)
IS
    v_itemID VARCHAR2(10);
    v_numeric_price NUMBER; -- Variable to store the numeric price
BEGIN
    -- Check if p_itemPrice is a valid number
    BEGIN
        v_numeric_price := TO_NUMBER(p_itemPrice); -- Try to convert to a number
    EXCEPTION
        WHEN OTHERS THEN
            -- If TO_NUMBER fails, it's not a valid number
            DBMS_OUTPUT.PUT_LINE('Error: Invalid price. Please enter a valid numeric price.');
            RETURN; -- Exit the procedure
    END;

    -- Generate the new item ID using the sequence
    SELECT 'I' || TO_CHAR(itemincrease.NEXTVAL, 'FM000') INTO v_itemID FROM DUAL;

    -- Insert the new item into the Items table
    INSERT INTO Items (itemsID, itemName, itemDescription, itemPrice, itemAvailability, categoryID)
    VALUES (v_itemID, p_itemName, p_itemDescription, v_numeric_price, p_itemAvailability, p_categoryID);

    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Item added successfully with ID: ' || v_itemID);
EXCEPTION
    WHEN OTHERS THEN
        -- Handle other exceptions here if needed
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END AddNewItem;
/
