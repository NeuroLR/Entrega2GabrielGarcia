CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_tarjeta`(dni varchar(20), es_cliente boolean) RETURNS int
    DETERMINISTIC
BEGIN

	DECLARE card_id int;
    DECLARE user_id int;
    
    IF es_cliente THEN
		SET user_id = (SELECT client_id FROM clients WHERE DOCUMENT_NUMBER = dni);
		SET card_id = (SELECT client_card_information.CARD_ID
        FROM client_card_information
        INNER JOIN clients ON client_card_information.CLIENT_ID = user_id);
	ELSE
		SET user_id = (SELECT seller_id FROM seller WHERE DOCUMENT_NUMBER = dni);
		SET card_id = (SELECT seller_card_information.CARD_ID
        FROM seller_card_information
        INNER JOIN seller ON seller_card_information.SELLER_ID = user_id);
	END IF;
    
RETURN card_id;
END