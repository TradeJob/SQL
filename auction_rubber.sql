SELECT
	D.*, category.NameTH AS PROVINCE
FROM
	category
INNER JOIN (
	SELECT
		auctionbid.id AS auctionBID,
		auctionbid.LotSequenceId AS auctionLOT,
		auctionbid.ModifiedTime AS auctionTIME,
		auctionbid.Buyer_id AS auctionBUYER,
		auctionbid.Volumn AS auctionVOL,
		person.FirmFullName AS BUYERNAME,
		auctionsuccess.Product_id AS PRODUCTID,
		auctionsuccess.Seller_id AS SELLER,
		MAX(Bid) AS MAXBID,
		category.id AS CATEID,
		category.`Code` AS CATECODE,
		category.NameTH AS CATENAME,
		auctionqueue.MinPrice AS MINPRICE,
		auctionqueue.MarketPlace_id AS MARKPLACE,
		market.NameTH AS MARKNAME,
		market.Place_id AS MARKPLACEID,
		address.Province_id AS PROVINCEID
	FROM
		auctionbid
	INNER JOIN auctionsuccess ON auctionbid.id = auctionsuccess.Bidder_id
	INNER JOIN category ON auctionsuccess.Product_id = category.id
	INNER JOIN auctionqueue ON auctionsuccess.LotSequence_id = auctionqueue.id
	INNER JOIN market ON auctionqueue.MarketPlace_id = market.id
	INNER JOIN address ON market.Place_id = address.id
	INNER JOIN person ON auctionbid.Buyer_id = person.id
	WHERE
		auctionbid.ModifiedTime BETWEEN "2015-01-21"
	AND "2015-01-21 23:59:59"
	AND market.id = 23
	GROUP BY
		auctionbid.LotSequenceId
) D ON D.PROVINCEID = category.id
