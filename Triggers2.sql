CREATE OR REPLACE TRIGGER UPDATEPAYMENTAMOUNT
BEFORE INSERT OR UPDATE ON PAYMENTS
FOR EACH ROW
DECLARE
    v_order_total NUMBER(7,2);
BEGIN
    SELECT NVL(SUM(oi.orderPrice * oi.orderQuantity), 0) +
           NVL(SUM(osm.orderPrice * osm.orderQuantity), 0)
    INTO v_order_total
    FROM OrderItems oi
    LEFT JOIN OrderSetMeals osm ON oi.orderID = osm.orderID
    WHERE oi.orderID = :NEW.orderID;

    :NEW.paymentAmount := v_order_total;
END;
/