SELECT
	_M1.id AS _MARKET_ID,
	_TBL_ARG._PRODUCT_ID AS _PRODUCT_ID,
	_TBL_ARG._CONTRACT_NO AS _CONTRACT_NO,
	_TBL_ARG._CREATE_DATE AS _CREATE_DATE,
	_TBL_ARG._DELIVERY_DATE AS _DELIVERY_DATE,
	_TBL_ARG._PRODUCT_CODE AS _PRODUCT_CODE,
	_TBL_ARG._VOLUMN AS _VOLUMN,
	_TBL_ARG._AMOUNT AS _AMOUNT,
	(_TBL_ARG._VOLUMN * 1000) * _TBL_ARG._AMOUNT AS _SUM_AMOUNT,
	_TBL_ARG._SELLER_ID AS _SELLER_ID,
	_TBL_ARG._SELLER_NAME AS _SELLER_NAME,
	_TBL_ARG._BUYER_ID AS _BUYER_ID,
	_TBL_ARG._BUYER_NAME AS _BUYER_NAME,
	_TBL_ARG._BUYER_SIGNATURE AS _BUYER_SIGNATURE,
	_TBL_ARG._SELLER_SIGNATURE AS _SELLER_SIGNATURE,
	_TBL_ARG._PROVINCE_ID,
	_TBL_ARG._PROVINCE_NAME
FROM
	market AS _M1
INNER JOIN address AS _ADD1 ON _ADD1.id = _M1.Place_id
INNER JOIN (
	SELECT
		_ARG1.ContractNo AS _CONTRACT_NO,
		DATE_FORMAT(
			_ARG1.ModifiedTime,
			"%Y-%m-%d"
		) AS _CREATE_DATE,
		DATE_FORMAT(
			_ARG1.DeliveryDate,
			"%Y-%m-%d"
		) AS _DELIVERY_DATE,
		_CAT2.id AS _PRODUCT_ID,
		_CAT2. CODE AS _PRODUCT_CODE,
             _ADD2.id AS _ADD2_ID,
		_ADD2.Province_id AS _PROVINCE_ID,
		_CAT1.NameTH AS _PROVINCE_NAME,
		_ARG1.Volumn AS _VOLUMN,
		_ARG1.Amount AS _AMOUNT,
		_ARG1.Seller_id AS _SELLER_ID,
		_P_SELLER.FirmFullName AS _SELLER_NAME,
		_ARG1.Buyer_id AS _BUYER_ID,
		_P_BUYER.FirmFullName AS _BUYER_NAME,
		_ARG1.Product_id AS _P_ID,
		_ARG1.BuyerSignature AS _BUYER_SIGNATURE,
		_ARG1.SellerSignature AS _SELLER_SIGNATURE
	FROM
		agreementsuccess AS _ARG1
	INNER JOIN person AS _P1 ON _P1.id = _ARG1.Manager_id
	INNER JOIN address AS _ADD2 ON _ADD2.id = _P1.Place_id
	INNER JOIN category AS _CAT1 ON _CAT1.id = _ADD2.Province_id
	INNER JOIN category AS _CAT2 ON _CAT2.id = _ARG1.Product_id
	INNER JOIN person AS _P_SELLER ON _P_SELLER.id = _ARG1.Seller_id
	INNER JOIN person AS _P_BUYER ON _P_BUYER.id = _ARG1.Buyer_id
)  AS _TBL_ARG ON _TBL_ARG._ADD2_ID = _ADD1.id OR _TBL_ARG._PROVINCE_ID = _ADD1.Province_id
WHERE LENGTH(_BUYER_SIGNATURE) > 0
 AND LENGTH(_SELLER_SIGNATURE) > 0
 AND _TBL_ARG._CREATE_DATE BETWEEN "2015-01-21" AND "2015-01-21 23:59:59"
 AND _M1.id=23
 AND _M1.RecordStatus = "A"
 ORDER BY _TBL_ARG._CREATE_DATE ASC