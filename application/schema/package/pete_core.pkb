CREATE OR REPLACE PACKAGE BODY pete_core AS

    g_last_run_log_id pete_run_log.id%TYPE;

    --------------------------------------------------------------------------------
    FUNCTION begin_test
    (
        a_object_name_in       IN typ_object_name,
        a_object_type_in       IN typ_object_type,
        a_parent_run_log_id_in IN pete_run_log.parent_id%TYPE DEFAULT NULL,
        a_description_in       IN typ_description DEFAULT NULL
    ) RETURN pete_run_log.id%TYPE IS
    
    BEGIN
        --
        g_last_run_log_id := petes_run_log.nextval;
        --
        pete_logger.log_start(a_run_log_id_in        => g_last_run_log_id,
                              a_parent_run_log_id_in => a_parent_run_log_id_in,
                              a_description_in       => a_description_in,
                              a_object_type_in       => a_object_type_in,
                              a_object_name_in       => a_object_name_in);
        --
        RETURN g_last_run_log_id;
        --
    END;

    --------------------------------------------------------------------------------
    FUNCTION get_last_run_log_id RETURN pete_run_log.id%TYPE IS
    BEGIN
        RETURN g_last_run_log_id;
    END;

    --------------------------------------------------------------------------------
    PROCEDURE end_test
    (
        a_run_log_id_in       IN pete_run_log.id%TYPE,
        a_execution_result_in IN typ_execution_result DEFAULT g_SUCCESS,
        a_xml_in_in           IN pete_run_log.xml_in%TYPE DEFAULT NULL,
        a_xml_out_in          IN pete_run_log.xml_out%TYPE DEFAULT NULL,
        a_error_code_in       IN pete_run_log.error_code%TYPE DEFAULT NULL
    ) IS
    BEGIN
        --
        pete_logger.log_end(a_run_log_id_in      => a_run_log_id_in,
                            a_result_in          => a_execution_result_in,
                            a_xml_in_in          => a_xml_in_in,
                            a_xml_out_in         => a_xml_out_in,
                            a_error_code_in      => a_error_code_in,
                            a_error_stack_in     => CASE
                                                        WHEN NOT a_execution_result_in =
                                                              g_SUCCESS THEN
                                                         dbms_utility.format_error_stack
                                                        ELSE
                                                         NULL
                                                    END,
                            a_error_backtrace_in => CASE
                                                        WHEN NOT a_execution_result_in =
                                                              g_SUCCESS THEN
                                                         dbms_utility.format_error_backtrace
                                                        ELSE
                                                         NULL
                                                    END);
        g_last_run_log_id := NULL;
    END;

END;
/