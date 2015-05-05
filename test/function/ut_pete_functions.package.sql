CREATE OR REPLACE PACKAGE ut_pete_functions AS

    description VARCHAR2(255) := 'Sum interval SQL function';

    PROCEDURE sum_interval(d IN VARCHAR2 := 'should work as expected');

END;
/
CREATE OR REPLACE PACKAGE BODY ut_pete_functions AS

    PROCEDURE sum_interval(d IN VARCHAR2) IS
        a INTERVAL DAY TO SECOND := numtodsinterval(1, 'hour');
        b INTERVAL DAY TO SECOND := numtodsinterval(1, 'hour');
        c INTERVAL DAY TO SECOND;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        SELECT petef_sum_interval(x)
          INTO c
          FROM (SELECT a AS x FROM dual UNION ALL SELECT b AS x FROM dual);
        --assert
        pete_assert.this(a + b = c);
    END;

END;
/
