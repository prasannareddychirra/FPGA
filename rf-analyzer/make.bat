
REM set /p vivado_ver= Which Version of Vivado do you plan to use? (201X.X):
set vivado_ver=2019.1
set proj_name=krm-4zurf-rf-analyzer

C:\Xilinx\Vivado\%vivado_ver%\bin\vivado.bat -mode batch -source scripts\vivado_make_project.tcl -tclargs %proj_name% & pause
