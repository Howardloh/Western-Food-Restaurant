CREATE OR REPLACE VIEW CategoryItemsView AS
SELECT i.itemsID AS "Item ID",
       i.itemName AS "Item Name",
       i.itemPrice AS "Price",
       i.itemAvailability AS "Availability"
FROM Items i
WHERE i.categoryID = (
   SELECT UPPER(TRIM('&v_categoryID')) FROM dual
);

SET VERIFY OFF;
SET SERVEROUTPUT ON;

DECLARE
   v_categoryID Categories.categoryID%TYPE;
BEGIN
   v_categoryID := UPPER(TRIM('&v_categoryID')); -- Prompt for category ID
   
   DBMS_OUTPUT.PUT_LINE('Items in Category ' || v_categoryID || ':');
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Item ID   Item Name                                    Price     Availability');
   DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
   
   FOR item_rec IN (SELECT i.itemsID, i.itemName, i.itemDescription, i.itemPrice, i.itemAvailability
                    FROM Items i
                    WHERE i.categoryID = v_categoryID)
   LOOP
      -- Format and print each item
      DBMS_OUTPUT.PUT_LINE(
         RPAD(item_rec.itemsID, 10) ||
         RPAD(item_rec.itemName, 45) ||
         RPAD(item_rec.itemPrice, 10) ||
         RPAD(item_rec.itemAvailability, 15)
      );
   END LOOP;
      DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------------------');
END;
/
