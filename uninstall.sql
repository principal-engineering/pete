prompt init sqlsn
@sqlsnrc

--we need sqlsn run module to traverse directory tree during uninstall
prompt require sqlsn-run module
@&&sqlsn_require sqlsn-run

prompt define action and script
define g_run_action = uninstall
define g_run_script = uninstall

prompt uninstall module
@&&run_dir module

purge recyclebin;

show errors

exit
