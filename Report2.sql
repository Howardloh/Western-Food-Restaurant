DECLARE
    -- Declare variables to store data
    v_ingredient_id Ingredients.ingredientID%TYPE;
    v_ingredient_name Ingredients.ingredientName%TYPE;
    v_quantity_on_hand NUMBER(10);
    v_unit_of_measurement Ingredients.ingredientUnitOfMeasurement%TYPE;
    v_price_per_unit NUMBER(10, 2);
BEGIN
    -- Print header for the report
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Ingredient Inventory Report');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE(
        RPAD('Ingredient ID', 20) || 
        RPAD('Ingredient Name', 20) || 
        RPAD('Quantity On Hand', 20) || 
        RPAD('Unit of Measurement', 25) || 
        'Price Per Unit'
    );
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------------');

    -- Open a cursor to retrieve ingredient data
    FOR ingredient_rec IN (
        SELECT ingredientID, ingredientName, ingredientQuantity, ingredientUnitOfMeasurement, ingredientPrice
        FROM Ingredients
        ORDER BY ingredientQuantity DESC -- Order by quantity in descending order
    ) LOOP
        v_ingredient_id := ingredient_rec.ingredientID;
        v_ingredient_name := ingredient_rec.ingredientName;
        v_quantity_on_hand := ingredient_rec.ingredientQuantity;
        v_unit_of_measurement := ingredient_rec.ingredientUnitOfMeasurement;
        v_price_per_unit := ingredient_rec.ingredientPrice;

        -- Display the ingredient inventory data
        DBMS_OUTPUT.PUT_LINE(
            RPAD(v_ingredient_id, 20) || 
            RPAD(v_ingredient_name, 20) || 
            RPAD(v_quantity_on_hand, 20) || 
            RPAD(v_unit_of_measurement, 25) || 
            v_price_per_unit
        );
    END LOOP;

    -- Print footer for the report
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------------------------------------');
END;
/
