USE [BookLibrary]
GO
/****** Object:  StoredProcedure [dbo].[AddClientBook2]    Script Date: 5/2/2018 7:40:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[AddClientBook2]
	-- Add the parameters for the stored procedure here
	@clientCode varchar(max),
	@firstName varchar(max),
	@secondName varchar(max),
	@cnp varchar(max),
	@ci_serie varchar(max),
	@ci varchar(max),
	@address varchar(max),
	@city varchar(max),
	@district varchar(max),
	@phone varchar(max),
	@email varchar(max),
	@registrationDateClient varchar(max),
	@cgid varchar(max),
	@active varchar(max),
	@mentionsClient varchar(max),
	@bookCode int,
	@isbn varchar(50),
	@title varchar(200),
	@author varchar(200),
	@volume int,
	@appearanceYear int,
	@appearancePlace varchar(100),
	@mentionsBook varchar(200),
	@registrationDateBook date,
	@pid int,
	@gid int,
	@bcid int,
	@lid int,
	@did int,
	@loanDate varchar(max),
	@dueDate varchar(max),
	@mentionsLoan varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @client int
	execute @client = AddClient @clientCode, @firstName, @secondName, @cnp, @ci_serie, @ci, @address, @city, @district, @phone, @email, @registrationDateClient, @cgid, @active, @mentionsClient
	if (@client <> 1)
	begin
		declare @book int
		execute @book = AddBook @bookCode, @isbn, @title, @author, @volume, @appearanceYear, @appearancePlace, @mentionsBook, @registrationDateBook, @pid, @gid, @bcid, @lid, @did
		if (@book <> 1)
			execute AddLoan @loanDate, @dueDate, @mentionsLoan
	end
	
	
END
