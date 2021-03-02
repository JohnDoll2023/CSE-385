/*
    Date: 3/2/2021
    Class: CSE 385 A
    Author: John Doll
*/


CREATE PROCEDURE addUpdateDeleteTerms
    @TermsID            INT,
    @TermsDescription   VARCHAR(50),
    @TermsDueDays       SMALLINT,
    @delete             BIT = 0
AS BEGIN
    IF @delete = 1 BEGIN
        BEGIN TRY
            DELETE FROM Terms WHERE TermsID = @TermsID
        END TRY BEGIN CATCH
            PRINT 'CANNOT DELETE PARENT RECORD'
        END CATCH
    END ELSE IF NOT EXISTS(SELECT NULL FROM Terms WHERE TermsID = @TermsID) BEGIN
        INSERT INTO Terms (TermsDescription, TermsDueDays) VALUES
            (@TermsDescription, @TermsDueDays)
    END ELSE BEGIN 
        UPDATE Terms
        SET TermsDescription = @TermsDescription,
            TermsDueDays = @TermsDueDays
        WHERE TermsID = @TermsID
    END
END