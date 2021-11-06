
WITH abc AS (
	SELECT 
		ker.id_user,
		ker.code_payee,
		con.PersonNr,
		ker.active,
		ker.firstname_user,
		ker.lastname_user,
		ker.login_user
	FROM Kernel_View_Admin_User AS ker
	LEFT JOIN _ref_client_contract AS con ON ker.code_payee = con.PersonId
	WHERE culture = 'en-US' AND code_payee IS NOT NULL) -- AND code_payee = '00027026')
SELECT 
	abc.id_user,
	abc.code_payee,
	abc.PersonNr,
	abc.active,
	abc.firstname_user,
	abc.lastname_user,
	abc.login_user,
	org.Company,
	org.EmployeeGroup,
	org.EmployeeSubGroup,
	org.PersonnelArea,
	org.PersonnelSubArea,
	org.JobTitle,
	org.id,
	RANK() OVER (PARTITION BY abc.code_payee ORDER BY org.StartDate DESC, org.id DESC) id_rank,
	org.StartDate,
	org.EndDate
FROM abc
LEFT JOIN _ref_client_org_assignment AS org ON abc.PersonNr = org.PersonNr
ORDER BY abc.id_user




