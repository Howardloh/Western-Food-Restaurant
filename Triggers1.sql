CREATE OR REPLACE TRIGGER UniqueCustomerEmail
BEFORE INSERT OR UPDATE ON Customers
FOR EACH ROW
DECLARE
    email_count INTEGER;
BEGIN
    IF :NEW.customerEmail IS NOT NULL THEN
        SELECT COUNT(*) INTO email_count FROM Customers WHERE customerEmail = :NEW.customerEmail AND customerID != :NEW.customerID;
        IF email_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Email address must be unique for each customer.');
        END IF;
    END IF;
END;
/
