CREATE OR REPLACE PACKAGE ut_pete_assert AS

    description pete_core.typ_description := 'Pete_assert package tests';

    -- this
    --------------------------------------------------------------------------------  
    PROCEDURE this_succeeds_with_true(d VARCHAR2 := 'this should succeed with true value');

    PROCEDURE this_throws_with_false(d VARCHAR2 := 'this should throw with false value');

    PROCEDURE this_throws_with_null(d VARCHAR2 := 'this should throw with null');

    -- is_null
    -------------------------------------------------------------------------------- 
    PROCEDURE is_null_succeeds_with_null(d VARCHAR2 := 'is_null should succeed with null value');

    PROCEDURE is_null_throws_with_not_null(d VARCHAR2 := 'is_null should throw with not null value');

    -- is_not_null
    -------------------------------------------------------------------------------- 
    PROCEDURE is_nn_throws_with_null(d VARCHAR2 := 'is_not_null should throw with null value');

    PROCEDURE is_nn_succeeds_with_nn(d VARCHAR2 := 'is_not_null should succeed with not null value');

    -- pass
    --------------------------------------------------------------------------------    
    PROCEDURE pass_succeeds(d VARCHAR2 := 'pass should succeed');

    -- fail
    --------------------------------------------------------------------------------    
    PROCEDURE fail_throws(d VARCHAR2 := 'fail should throw');

    -- eq
    --------------------------------------------------------------------------------    
    PROCEDURE eq_number_succeeds(d VARCHAR2 := 'eq should succeed for equal numbers');

    PROCEDURE eq_varchar2_succeeds(d VARCHAR2 := 'eq should succeed for equal strings');

    PROCEDURE eq_date_succeeds(d VARCHAR2 := 'eq should succeed for equal dates');

    PROCEDURE eq_boolean_succeeds(d VARCHAR2 := 'eq should succeed for equal booleans');

    PROCEDURE eq_same_xmltype_succeeds(d VARCHAR2 := 'eq should succeed for two equal xmls with same order of elements');

    PROCEDURE eq_diff_order_xmltype_throws(d VARCHAR2 := 'eq should throw for two equal xmls with different order of elements');

END ut_pete_assert;
/
CREATE OR REPLACE PACKAGE BODY ut_pete_assert AS

    -- this 
    --------------------------------------------------------------------------------  
    PROCEDURE this_succeeds_with_true(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.this(TRUE);
        --assert
    END;

    PROCEDURE this_throws_with_false(d VARCHAR2) IS
        l_thrown BOOLEAN := FALSE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        BEGIN
            pete_assert.this(FALSE);
            l_thrown := FALSE;
        EXCEPTION
            WHEN OTHERS THEN
                l_thrown := TRUE;
        END;
        --assert
        IF NOT l_thrown
        THEN
            raise_application_error(-20000,
                                    'PETE_ASSSERT.THIS(FALSE) should throw.');
        END IF;
    END;

    PROCEDURE this_throws_with_null(d VARCHAR2) IS
        l_thrown BOOLEAN := FALSE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        BEGIN
            pete_assert.this(NULL);
            l_thrown := FALSE;
        EXCEPTION
            WHEN OTHERS THEN
                l_thrown := TRUE;
        END;
        --assert
        IF NOT l_thrown
        THEN
            raise_application_error(-20000,
                                    'PETE_ASSSERT.THIS(NULL) should throw.');
        END IF;
    END;

    --is_null
    --------------------------------------------------------------------------------
    PROCEDURE is_null_succeeds_with_null(d VARCHAR2) IS
        l_number INTEGER := NULL;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.is_null(l_number);
        --assert
    END;

    PROCEDURE is_null_throws_with_not_null(d VARCHAR2) IS
        l_thrown BOOLEAN := FALSE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        BEGIN
            pete_assert.is_null(1);
            l_thrown := FALSE;
        EXCEPTION
            WHEN OTHERS THEN
                l_thrown := TRUE;
        END;
        --assert
        IF NOT l_thrown
        THEN
            raise_application_error(-20000,
                                    'PETE_ASSSERT.IS_NULL(NOT NULL) should throw.');
        END IF;
    END;

    --is_not_null
    --------------------------------------------------------------------------------  
    PROCEDURE is_nn_throws_with_null(d VARCHAR2) IS
        l_number INTEGER := NULL;
        l_thrown BOOLEAN := FALSE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        BEGIN
            pete_assert.is_not_null(l_number);
            l_thrown := FALSE;
        EXCEPTION
            WHEN OTHERS THEN
                l_thrown := TRUE;
        END;
        --assert
        IF NOT l_thrown
        THEN
            raise_application_error(-20000,
                                    'PETE_ASSSERT.IS_NOT_NULL(NULL) should throw.');
        END IF;
    END;

    PROCEDURE is_nn_succeeds_with_nn(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.is_not_null(1);
        --assert
    END;

    -- pass
    --------------------------------------------------------------------------------    
    PROCEDURE pass_succeeds(d VARCHAR2 := 'pass should succeed') IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.pass;
        --assert
    END;

    -- fail
    --------------------------------------------------------------------------------    
    PROCEDURE fail_throws(d VARCHAR2 := 'fail should throw') IS
        l_thrown BOOLEAN := FALSE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        BEGIN
            pete_assert.fail;
            l_thrown := FALSE;
        EXCEPTION
            WHEN OTHERS THEN
                l_thrown := TRUE;
        END;
        --assert
        IF NOT l_thrown
        THEN
            raise_application_error(-20000, 'PETE_ASSSERT.FAIL should throw.');
        END IF;
    END;

    --eq
    --------------------------------------------------------------------------------  
    PROCEDURE eq_number_succeeds(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.eq(1, 1);
        --assert
    END;

    PROCEDURE eq_varchar2_succeeds(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.eq('a', 'a');
        --assert
    END;

    PROCEDURE eq_date_succeeds(d VARCHAR2) IS
        l_d DATE := SYSDATE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.eq(l_d, l_d);
        --assert
    END;

    PROCEDURE eq_boolean_succeeds(d VARCHAR2) IS
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.eq(TRUE, TRUE);
        pete_assert.eq(FALSE, FALSE);
        --assert
    END;

    PROCEDURE eq_same_xmltype_succeeds(d VARCHAR2) IS
        l_xml1 xmltype := xmltype.createxml('<a><b>1</b><c>2</c></a>');
        l_xml2 xmltype := xmltype.createxml('<a><b>1</b><c>2</c></a>');
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        pete_assert.eq(l_xml1, l_xml2);
        --assert
    END;

    PROCEDURE eq_diff_order_xmltype_throws(d VARCHAR2) IS
        l_xml1   xmltype := xmltype.createxml('<a><b>1</b><c>2</c></a>');
        l_xml2   xmltype := xmltype.createxml('<a><c>2</c><b>1</b></a>');
        l_thrown BOOLEAN := FALSE;
    BEGIN
        --log
        pete_logger.log_method_description(d);
        --test
        BEGIN
            pete_assert.eq(l_xml1, l_xml2);
            l_thrown := FALSE;
        EXCEPTION
            WHEN OTHERS THEN
                l_thrown := TRUE;
        END;
        --assert
        IF NOT l_thrown
        THEN
            raise_application_error(-20000, 'PETE_ASSSERT.EQ should throw.');
        END IF;
    END;

END ut_pete_assert;
/
