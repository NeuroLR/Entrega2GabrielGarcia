CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_nombre_completo`(dni varchar(20), es_cliente boolean) RETURNS varchar(255) CHARSET utf8mb3
    DETERMINISTIC
BEGIN
	DECLARE resultado varchar(255);
    IF es_cliente THEN
		SET resultado = (SELECT FULLNAME FROM CLIENTS 
			WHERE DOCUMENT_NUMBER = dni);
	ELSE 
		SET resultado = (SELECT FULLNAME FROM SELLER 
        WHERE DOCUMENT_NUMBER = dni);
	END IF;
RETURN resultado;
END