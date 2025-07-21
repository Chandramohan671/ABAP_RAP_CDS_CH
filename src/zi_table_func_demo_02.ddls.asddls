@EndUserText.label: 'Table Func - Join two table with on different data types'
define table function ZI_TABLE_FUNC_DEMO_02
with parameters 
@Environment.systemField: #CLIENT
client : abap.clnt
returns {
  client : abap.clnt;
  id : char10;
  name : char30;
  salary : abap.curr(10,2);
  cuky : abap.cuky;
  
}
implemented by method ZCL_TABLE_FUNC_DEMO_02=>GET_EMP_SAL;