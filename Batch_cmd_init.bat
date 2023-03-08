@echo on

::Sets up environmental variables required for Tools
cd C:\Espressif\frameworks\esp-idf-v4.4.4\
call C:\Espressif\idf_cmd_init_test.bat

::Returns to current directory
cd C:\Users\KennardTang\esp\esp-idf\nvs_rw_blob

:check
	set /p filename=Enter name of the input file:
	set /p Input=Enter a Serial Number?{y/n):
	If /I "%Input%"=="y" goto yes 
	If /I "%Input%"=="n" goto no
	goto check


:yes
	set /p serial=Enter Serial Number(Must be 8 Characters):
	If  /I "%serial:~8%" neq "" goto yes
	
	If "%serial:~7%"=="" goto yes
	python "C:\Users\KennardTang\esp\esp-idf\nvs_rw_blob\nvs_partition_gen.py" generate "%filename%".csv 0x3000 --serial "%serial%"
	goto end 
	

:no
	python "C:\Users\KennardTang\esp\esp-idf\nvs_rw_blob\nvs_partition_gen.py" generate "%filename%".csv 0x3000

:end
pause
python C:\Espressif\frameworks\esp-idf-v4.4.4\components\esptool_py\esptool\esptool.py --chip esp32 write_flash @C:\Users\KennardTang\esp\esp-idf\nvs_rw_blob\flash_project_NVS_args
pause
