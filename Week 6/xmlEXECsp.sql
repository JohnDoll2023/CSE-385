DROP TABLE IF EXISTS Errors
GO

CREATE TABLE Errors (
    ERROR_ID            INT             PRIMARY KEY     IDENTITY,
    ERROR_LINE          INT,
    ERROR_MESSAGE       NVARCHAR(1000),
    ERROR_NUMBER        INT,
    ERROR_PROCEDURE     NVARCHAR(1000),
    ERROR_SEVERITY      INT,
    ERROR_STATE         INT,
    PARAMS              XML,
    SYSUSER             VARCHAR(200)    DEFAULT(SYSTEM_USER),
    ERROR_DATE_TIME     DATETIME        DEFAULT(GETDATE()),
    RESOLVED_DATETIME   DATETIME        DEFAULT(NULL)   NULL,
    RESOLVED_BY         VARCHAR(200)    DEFAULT(NULL)   NULL
)
GO

/*
<users>
    <user>
        <firstName>Tom</firstName>
        <lastName>Ryan</lastName>
        <age>22</age>
        <pets>
            <pet>
                <name>Buffy</name>
                <age>10</age>
        </pets>
    </user>
    <user>
        <firstName>Sally</firstName>
        <lastName>Right</lastName>
        <age>21</age>
        <pets></pets>
    </user>
</users>
*/

DROP PROCEDURE IF EXISTS spRecordError
GO

CREATE PROCEDURE spRecordError
    @params XML
AS BEGIN
    INSERT INTO Errors (
        ERROR_LINE,
        ERROR_MESSAGE,
        ERROR_NUMBER,     
        ERROR_PROCEDURE,
        ERROR_SEVERITY,
        ERROR_STATE,
        PARAMS
    ) VALUES (
        ERROR_LINE(),
        ERROR_MESSAGE(),
        ERROR_NUMBER(),
        ERROR_PROCEDURE(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        @params
    )
END
GO


DROP PROCEDURE IF EXISTS spDivide
GO

CREATE PROCEDURE spDivide
    @nom    FLOAT,
    @den    FLOAT
AS BEGIN

    DECLARE @result FLOAT

    BEGIN TRY
        SET @result = @nom / @den
    END TRY BEGIN CATCH
        DECLARE @params XML = (
                                SELECT  [nom] = CAST(@nom AS DECIMAL(19, 2)), --ADDING AT SIGN WILL CHANGE DATA TYPE TO ATTRIBUTE
                                        [den] = CAST(@den AS DECIMAL(19, 2))
                                FOR XML PATH('parametesrs')
                              )
        EXEC spRecordError @params
        --RETURN --------gets rid of nulls
    END CATCH

    SELECT [result] = @result

END
GO

/* EXAM QUESTION
SELECT CAST(4554345.2345325234 AS DECIMAL(9, 2)) --MUST HAVE 2 DECIMALS, THIS NUMBER HAS 7 NUMBERS TO THE LEFT OF THE DECIMAL SO MUST LEAVE 2 DECIMAL NUMBERS AT LEAST
*/

/*
SELECT  [name] = 'Sally Right',
        [age] = 21
FOR XML PATH('friend')
*/

EXEC spDivide 44, 5

SELECT * FROM Errors

SELECT * FROM master.sys.messages
WHERE LANGUAGE_ID = 1033

/*
SELECT(
SELECT *
FROM Vendors
WHERE VendorID IN (SELECT DISTINCT VendorID FROM Invoices)
FOR JSON PATH 
) FOR XML PATH('')
*/

--XML PATH('Vendor'), ROOT('Vendors')


SELECT  *,
        [Invoices] = (
                SELECT * 
                FROM Invoices 
                WHERE VendorID = v.VendorID
                FOR XML PATH('Invoice'), TYPE
        )
FROM Vendors v
WHERE VendorID IN (SELECT DISTINCT VendorID FROM Invoices)
FOR XML PATH('Vendor'), ROOT('Vendors')