USE AMS
GO

SELECT 
	atf.siAccountFeesID, 
	af.vcAccountFeesName,
	at.vcaccounttypedescription
FROM tbAccountTypeFees atf
	INNER JOIN stbAccountFees af
			ON atf.siAccountFeesID = af.siAccountFeesID 
	INNER JOIN tbaccounttype at 
			ON atf.tiAccountTypeID = at.tiAccountTypeID
WHERE atf.vcFeesvalue = 70.00
 --and atf.tiAccountTypeID = (SELECT at.tiAccountTypeID FROM tbaccounttype at WHERE at.tiAccountTypeID = 2)