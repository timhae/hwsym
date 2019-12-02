LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

PACKAGE functions IS

    FUNCTION log2(i : NATURAL) RETURN INTEGER;

END;

PACKAGE BODY functions IS
    FUNCTION log2(i  : NATURAL) RETURN INTEGER IS
        VARIABLE temp    : INTEGER := i;
        VARIABLE ret_val : INTEGER := 0;
    BEGIN
        WHILE temp > 1 LOOP
            ret_val := ret_val + 1;
            temp    := temp / 2;
        END LOOP;
        RETURN ret_val;
    END FUNCTION;
END PACKAGE BODY;