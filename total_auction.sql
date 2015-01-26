SELECT
	agreementsuccess.ContractNo,
	agreementsuccess.Product_id,
	agreementsuccess.Volumn,
	agreementsuccess.Amount,
	(
		agreementsuccess.Volumn * 1000
	) * agreementsuccess.Amount AS Total,
	agreementsuccess.Seller_id,
	agreementsuccess.Buyer_id,
	person_seller_id.FirmFullName AS FirmFullName_Seller,
	person_buyer_id.FirmFullName AS FirmFullName_Buyer,
	agreementsuccess.Manager_id,
	person_manager_id.FirmFullName AS FirmFullName_Manager,
	address_person_manager_id.Province_id,
	category_address_person_manager_id.NameTH AS Province_Name
FROM
	agreementsuccess
INNER JOIN person AS person_seller_id ON person_seller_id.id = agreementsuccess.Seller_id
INNER JOIN person AS person_buyer_id ON person_buyer_id.id = agreementsuccess.Buyer_id
INNER JOIN person AS person_manager_id ON person_manager_id.id = agreementsuccess.Manager_id
INNER JOIN address AS address_person_manager_id ON address_person_manager_id.id = person_manager_id.Place_id
INNER JOIN category AS category_address_person_manager_id ON category_address_person_manager_id.id = address_person_manager_id.Province_id
WHERE
	DATE_FORMAT(
		agreementsuccess.CreatedTime,
		"%Y-%m-%d"
	) BETWEEN "2015-01-21" AND "2015-01-21"
AND agreementsuccess.Manager_id = 285
UNION
	SELECT
		auctionsuccess.LotSequence_id,
		auctionsuccess.Product_id,
		auctionsuccess.Volumn,
		auctionsuccess.Amount,
		(auctionsuccess.Volumn * 1000) * auctionsuccess.Amount AS Total,
		auctionsuccess.Seller_id,
		auctionsuccess.Buyer_id,
		person_seller_id.FirmFullName AS FirmFullName_Seller,
		person_buyer_id.FirmFullName AS FirmFullName_Buyer,
		auctionsuccess.Manager_id,
		person_manager_id.FirmFullName AS FirmFullName_Manager,
		address_person_manager_id.Province_id,
		category_address_person_manager_id.NameTH AS Province_Name
	FROM
		auctionsuccess
	INNER JOIN person AS person_seller_id ON person_seller_id.id = auctionsuccess.Seller_id
	INNER JOIN person AS person_buyer_id ON person_buyer_id.id = auctionsuccess.Buyer_id
	INNER JOIN person AS person_manager_id ON person_manager_id.id = auctionsuccess.Manager_id
	INNER JOIN address AS address_person_manager_id ON address_person_manager_id.id = person_manager_id.Place_id
	INNER JOIN category AS category_address_person_manager_id ON category_address_person_manager_id.id = address_person_manager_id.Province_id
	WHERE
	DATE_FORMAT(
		auctionsuccess.CreatedTime,
		"%Y-%m-%d"
	) BETWEEN "2015-01-21" AND "2015-01-21"
	AND auctionsuccess.Manager_id = 285
