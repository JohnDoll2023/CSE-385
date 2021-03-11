--------------------------------------------------------------------Transactions, try and catch revisited
/*
BEGIN TRAN
    UPDATE InvoiceLineItems SET InvoiceLineItemAmount = InvoiceLineItemAmount * .15

    SELECT * FROM InvoiceLineItems

    IF (@@TRANCOUNT > 0) ROLLBACK TRAN
    IF (@@TRANCOUNT > 0) COMMIT TRAN

SELECT * FROM InvoiceLineItems
*/

------------------------------------------------------------FULL EXAMPLE OF TRY CATCH, TRANSACTION, ERROR LOG

/*
DECLARE @n1 INT = 10, @n2 INT = 0


BEGIN TRAN
    BEGIN TRY
        DELETE FROM Errors
        SELECT [answer] = @n1 / @n2
    END TRY BEGIN CATCH
        IF(@@TRANCOUNT > 0) ROLLBACK TRAN

        DECLARE @params XML = ( SELECT [n1] = @n1, [n2] = @n2 FOR XML PATH('params') )

        EXEC spRecordError @params

    END CATCH
IF(@@TRANCOUNT > 0) COMMIT TRAN

SELECT * FROM Errors
*/

----------------------------------------------------------------------------------Hashbytes / Compression (exam)
/*
DECLARE @pw NVARCHAR(30) = 'p@S$W0Rd';

SELECT  [HASHBYTES(SHA2_512)-V]     =   HASHBYTES('SHA2_512','p@S$W0Rd'),
        [HASHBYTES(SHA2_512)-N]     =   HASHBYTES('SHA2_512',CAST('p@S$W0Rd' AS NVARCHAR)),
        [COMPRESS]                  =   COMPRESS('p@S$W0Rd'),
        [DECOMPRESS]                =   DECOMPRESS(COMPRESS('p@S$W0Rd')),
        [DECOMPRESS(WITH CAST)]     =   CAST(DECOMPRESS(COMPRESS('p@S$W0Rd')) AS VARCHAR),
        [MD2]                       =   HASHBYTES('MD2',@pw),
        [MD4]                       =   HASHBYTES('MD4',@pw),
        [MD5]                       =   HASHBYTES('MD5',@pw),
        [SHA]                       =   HASHBYTES('SHA',@pw),
        [SHA1]                      =   HASHBYTES('SHA1',@pw),
        [SHA2_256]                  =   HASHBYTES('SHA2_256',@pw),
        [SHA2_512]                  =   HASHBYTES('SHA2_512',@pw)
FOR JSON PATH
*/

---------------------------------------------------------------------Querying XML datatype
DROP TABLE IF EXISTS xmlTEST
GO


CREATE TABLE xmlTEST (
    studentId       INT     PRIMARY KEY     IDENTITY,
    testdata        XML
)
GO

INSERT INTO xmlTEST (testData) VALUES 
    (( SELECT [t1] = 55, [t2] = 87 FOR XML PATH('exams')  )),
    (( SELECT [t1] = 55, [t2] = 87, [t3] = 100 FOR XML PATH('exams')  )),
    (( SELECT [t1] = 55, [t2] = 87, [t3] = 98 FOR XML PATH('exams')  )),
    (( SELECT [t1] = 55, [t2] = 87, [t3] = 40, [t4] = 98 FOR XML PATH('exams')  )),
    (( SELECT [t1] = 55, [t2] = 87, [t3] = 98, [t4] = 98 FOR XML PATH('exams')  ))
GO

SELECT * FROM xmlTEST 
GO

WITH tbl AS (
    SELECT  e.studentId,
            child.value('t1[1]','INT') AS t1,
            child.value('t2[1]','INT') AS t2,
            child.value('t3[1]','INT') AS t3,
            child.value('t4[1]','INT') AS t4
    FROM xmlTEST e
    CROSS APPLY e.testdata.nodes('exams') parent(child)
) SELECT (
    SELECT 
        [Test1] = ( SELECT AVG(t1) AS avg, SUM(t1) AS sum, COUNT (t1) AS cnt FOR JSON PATH),
        [Test2] = ( SELECT AVG(t2) AS avg, SUM(t2) AS sum, COUNT (t2) AS cnt FOR JSON PATH),
        [Test3] = ( SELECT AVG(t3) AS avg, SUM(t3) AS sum, COUNT (t3) AS cnt FOR JSON PATH),
        [Test4] = ( SELECT AVG(t4) AS avg, SUM(t4) AS sum, COUNT (t4) AS cnt FOR JSON PATH)
    FROM tbl FOR JSON PATH
) FOR XML PATH('')

    SELECT * FROM VENDORS FOR JSON PATH -- doesnt allow you to click