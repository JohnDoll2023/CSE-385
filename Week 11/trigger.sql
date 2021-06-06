/*
	TRIGGERS
	Mini stored procedures that execute automatically
	INSERT
	UPDATE
	DELETE
	TRIGGERS can be written BEFORE OR AFTER the db is altered

	when using triggers, we have 2 temp tables
		inserted (updated when updating)
		deleted (original when updating)

	command		inserted				deleted

	insert		rows to be inserted		**empty
	update		new rows				original rows
	delete		**empty					rows to be deleted

*/

DELETE InvoiceLineItems WHERE InvoiceID = 1 AND InvoiceSequence > 1

DROP TABLE IF EXISTS InvoiceLineItemAudit
GO

CREATE TABLE [dbo].[InvoiceLineItemAudit] (
	[InvoiceLineItemAudit]			INT					PRIMARY KEY		IDENTITY,
	[AuditID]						UNIQUEIDENTIFIER	NOT NULL,
    [InvoiceID]						INT					NOT NULL,
    [InvoiceSequence]				SMALLINT			NOT NULL,
    [AccountNo]						INT					NOT NULL,
    [InvoiceLineItemAmount]			MONEY				NOT NULL,
    [InvoiceLineItemDescription]	VARCHAR (100)		NOT NULL,
	[AuditDateTime]					DATETIME			NOT NULL		DEFAULT(GETDATE()),
	[Command]						CHAR(3)				CHECK(Command IN ('INS', 'DEL', 'BEF', 'AFT'))
	);
GO

DROP TRIGGER IF EXISTS InvoiceLineItemAudit_TRIGGER;
GO

CREATE TRIGGER InvoiceLineItemAudit_TRIGGER ON InvoiceLineItems
	AFTER INSERT, UPDATE, DELETE
AS BEGIN
	DECLARE @AuditID UNIQUEIDENTIFIER = NEWID()
	DECLARE @ins CHAR(3) = 'INS', @del CHAR(3) = 'DEL'
	IF EXISTS (SELECT NULL FROM inserted) AND EXISTS (SELECT NULL FROM deleted) BEGIN
		SET @ins = 'AFT'
		SET @del = 'BEF'
	END
	INSERT INTO InvoiceLineItemAudit (AuditID, InvoiceID, InvoiceSequence, AccountNo, InvoiceLineItemAmount, InvoiceLineItemDescription, Command)
		SELECT	@AuditID, InvoiceID, InvoiceSequence, AccountNo, InvoiceLineItemAmount, InvoiceLineItemDescription, @del FROM deleted
	UNION ALL
		SELECT	@AuditID, InvoiceID, InvoiceSequence, AccountNo, InvoiceLineItemAmount, InvoiceLineItemDescription, @ins FROM inserted

END
GO

--SELECT * FROM InvoiceLineItems WHERE InvoiceID = 1

INSERT INTO InvoiceLineItems
	SELECT 1, 2, 553, 500, 'testrow'

SELECT * FROM InvoiceLineItemAudit

UPDATE InvoiceLineItems
	SET InvoiceLineItemAmount = 600
	WHERE (InvoiceID = 1) AND (InvoiceSequence = 2)

DELETE InvoiceLineItems WHERE (InvoiceID = 1) AND (InvoiceSequence = 2)
SELECT * FROM InvoiceLineItemAudit

BEGIN TRAN

	DELETE FROM InvoiceLineItems
	SELECT * FROM InvoiceLineItemAudit

ROLLBACK TRAN
