USE [BookLibrary]
GO
/****** Object:  StoredProcedure [dbo].[AddLoan]    Script Date: 5/2/2018 7:41:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[AddLoan]
	-- Add the parameters for the stored procedure here
	@loanDate varchar(max),
	@dueDate varchar(max),
	@mentionsLoan varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    begin tran
		begin try
			if dbo.checkFormatDate(@loanDate) = 0
			begin
				RAISERROR('Loan Date is invalid', 14, 1)				
			end

			if dbo.checkFormatDate(@dueDate) = 0
			begin
				RAISERROR('Due Date is invalid', 14, 1)				
			end

			declare @bid int
			set @bid = (select IDENT_CURRENT('Books'))
			declare @cid int
			set @cid = (select IDENT_CURRENT('Clients'))
			insert into Loans values(@bid, @cid, @loanDate, @dueDate, @mentionsLoan)
			print 'Insert loan complet'
			commit tran
			select 'Transaction committed'
		end try

		begin catch
			rollback tran
			select 'Loan transaction rollbacked'
		end catch
	end