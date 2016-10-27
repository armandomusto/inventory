﻿DROP FUNCTION IF EXISTS inventory.count_item_in_stock(_item_id integer, _unit_id integer, _store_id integer);

CREATE FUNCTION inventory.count_item_in_stock(_item_id integer, _unit_id integer, _store_id integer)
RETURNS decimal
STABLE
AS
$$
    DECLARE _debit decimal;
    DECLARE _credit decimal;
    DECLARE _balance decimal;
BEGIN

    _debit := inventory.count_purchases($1, $2, $3);
    _credit := inventory.count_sales($1, $2, $3);

    _balance:= _debit - _credit;    
    return _balance;  
END
$$
LANGUAGE plpgsql;


--SELECT * FROM inventory.count_item_in_stock(1, 1, 1);