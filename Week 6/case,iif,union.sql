/*
    VendorID, InvoiceNumber, Balance, Status
        Balance     Status
        0       ->  Paid
        1-199   ->  Send Reminder
        200-499 ->  ALERT
        >= 500  ->  Cancel Amount
*/

/*
    SELECT  VendorID,
            InvoiceNumber,
            Balance,
            [Status] = 'Paid'
    FROM vwInvoices
    WHERE Balance = 0
UNION
    SELECT  VendorID,
            InvoiceNumber,
            Balance,
            [Status] = 'Send Reminder'
    FROM vwInvoices
    WHERE Balance BETWEEN 1 AND 199
UNION
    SELECT  VendorID,
            InvoiceNumber,
            Balance,
            [Status] = 'ALERT'
    FROM vwInvoices
    WHERE Balance BETWEEN 200 AND 499
UNION
    SELECT  VendorID,
            InvoiceNumber,
            Balance,
            [Status] = 'Cancel Amount'
    FROM vwInvoices
    WHERE Balance >= 500

------------two queries produce equal outputs

SELECT  VendorID,
            InvoiceNumber,
            Balance,
            [Status] =  CASE
                            WHEN Balance = 0    THEN 'Paid'
                            WHEN Balance < 200  THEN 'Send Reminder'
                            WHEN Balance < 500  THEN 'ALERT'
                            ELSE                     'Cancel Account'
                        END
    FROM vwInvoices

*/

/*
    --UNION
        SELECT  VendorID,
                VendorName,
                [Check] = 'YES'
        FROM Vendors
        WHERE VendorName LIKE '%''%'
    UNION
        SELECT  VendorID,
                VendorName,
                [Check] = 'no'
        FROM Vendors
        WHERE VendorName NOT LIKE '%''%'
    --CASE
    SELECT  VendorID,
                VendorName,
                [Check] =   CASE
                                WHEN VendorName LIKE '%''%'     THEN 'YES'
                                ELSE                                 'no'
                            END
    FROM Vendors
    --IIF (ternary if)
    SELECT  VendorID,
                VendorName,
                [Check] = IIF(VendorName LIKE '%''%', 'YES', 'no')
    FROM Vendors
*/

/*    --CASE
    SELECT  VendorID,
            [Address] = CASE
                            WHEN VendorAddress1 IS NOT NULL     THEN VendorAddress1
                            WHEN VendorAddress2 IS NOT NULL     THEN VendorAddress2
                            WHEN VendorPhone    IS NOT NULL     THEN VendorPhone
                            ELSE                                'Error'
                        END
    FROM Vendors
    --IIF
    SELECT  VendorID,
            [Address] = IIF(VendorAddress1 IS NOT NULL, VendorAddress1, 
                            IIF(VendorAddress2 IS NOT NULL, VendorAddress2, 
                                IIF(VendorPhone    IS NOT NULL, VendorPhone, 'Error')))
    FROM Vendors
*/

/*
UPDATE Invoices
SET TermsID = IIF(TermsID = 1, 2, 1)
WHERE InvoiceNumber = '125520-1'

UPDATE Invoices
SET TermsID =   CASE
                    WHEN TermsID = 1 THEN 2
                    ELSE                  1
                END--,
    --InvoiceDate = CASE ... blah blah
WHERE InvoiceNumber = '125520-1'
*/

/*
--Using an IF statement with EXISTS
    IF EXISTS(SELECT NULL FROM Invoices WHERE InvoiceNumber = '125520-1' AND TermsID = 1) BEGIN 
        UPDATE Invoices SET TermsID = 2 WHERE InvoiceNumber = '125520-1'
    END ELSE BEGIN
        UPDATE Invoices SET TermsID = 1 WHERE InvoiceNumber = '125520-1'
    END
*/

/*
GO
    CREATE PROCEDURE spAddGLAccount
        @AccountNo          INT,
        @AccountDescription VARCHAR(50)
    AS BEGIN
        IF EXISTS (SELECT NULL FROM GLAccounts WHERE AccountNo = @AccountNo) BEGIN
            INSERT INTO GLAccounts (AccountNo, AccountDescription) VALUES
                (@AccountNo, @AccountDescription)
        END
    END
GO

EXEC spAddGLAccount 99, 'SAMPLE'
*/
/*

GO
    CREATE PROCEDURE spAddUpdateGLAccount
        @AccountNo          INT,
        @AccountDescription VARCHAR(50)
    AS BEGIN
        IF EXISTS (SELECT NULL FROM GLAccounts WHERE AccountNo = @AccountNo) BEGIN
            INSERT INTO GLAccounts (AccountNo, AccountDescription) VALUES
                (@AccountNo, @AccountDescription)
        END ELSE BEGIN
            UPDATE GLAccounts 
            SET AccountDescription = @AccountDescription 
            WHERE AccountNo = @AccountNo
        END
    END
GO

EXEC spAddUpdateGLAccount 98, 'SAMPLE-1'

SELECT * FROM GLAccounts
*/
/*
GO
    ALTER PROCEDURE spAddUpdateDeleteGLAccount
        @AccountNo          INT,
        @AccountDescription VARCHAR(50),
        @delete             BIT = 0
    AS BEGIN
        IF @delete = 1 BEGIN
            BEGIN TRY
                DELETE FROM GLAccounts WHERE AccountNo = @AccountNo
            END TRY BEGIN CATCH
                PRINT 'CANNOT DELETE PARENT RECORD'
            END CATCH
        END ELSE IF EXISTS (SELECT NULL FROM GLAccounts WHERE AccountNo = @AccountNo) BEGIN
            INSERT INTO GLAccounts (AccountNo, AccountDescription) VALUES
                (@AccountNo, @AccountDescription)
        END ELSE BEGIN
            UPDATE GLAccounts 
            SET AccountDescription = @AccountDescription 
            WHERE AccountNo = @AccountNo
        END
    END
GO
*/
EXEC spAddUpdateDeleteGLAccount 98, 'Hello World', 552

SELECT * FROM GLAccounts