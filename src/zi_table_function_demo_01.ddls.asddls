@EndUserText.label: 'CDS Table function Practice 01'
@ClientHandling.type: #CLIENT_INDEPENDENT
define table function ZI_TABLE_FUNCTION_DEMO_01
  with parameters
    //" Table function with Parameters

    //@Environment.systemField: #CLIENT    // If not input is passed, it will take system value as default client
    client1 : abap.clnt       //  It will be used in where in SQL Script for Implementation

returns
{
  client         : abap.clnt; // It will be used for implicit cleint handling and it will not be in output list
  travel_id      : /dmo/travel_id;
  @Semantics.amount.currencyCode: 'currency_code' // Currency code reference to Amount Field (Element Annotaions)
  booking_fee    : /dmo/booking_fee;
  currency_code  : /dmo/currency_code;
  overall_status : /dmo/overall_status;

}
implemented by method
  zcl_table_function_ch_01=>get_fight_travel; // AMDP Function