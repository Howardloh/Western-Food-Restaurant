-- Create a procedure to delete an item by its ID
CREATE OR REPLACE PROCEDURE DeleteItem(
    p_itemID IN VARCHAR2
)
IS
    v_itemCount NUMBER;
BEGIN
    -- Check if the item with the given ID exists
    SELECT COUNT(*) INTO v_itemCount
    FROM Items
    WHERE itemsID = p_itemID;
    
    -- If item does not exist, raise an error and exit
    IF v_itemCount = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Item with ID ' || p_itemID || ' not found.');
    END IF;

    -- Delete the item from the Items table
    DELETE FROM Items
    WHERE itemsID = p_itemID;
    
    -- Commit the transaction
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Item with ID ' || p_itemID || ' deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions here if needed
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END DeleteItem;
/