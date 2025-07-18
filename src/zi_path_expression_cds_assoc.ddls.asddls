@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Path Expression in CDS Association'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_PATH_EXPRESSION_CDS_ASSOC as select from ZI_CDS_ASSOCIATION_DEMO
{
    key TravelGuid,
    TravelId,
    Status,
    @Semantics.amount.currencyCode: 'currency_code'
    BookingFee,
    currency_code,
    /* Associations */
    _Booking[ carrier_id = 'UA'  
              and flight_date = '20250315'].connection_id as ConnectionId, //Path Expression with Parameters
              
   // _Booking[ 1:carrier_id = 'UA' ].booking_id as BookingId,  // Path Expression with cardinality & Parameters (Left Outer To One Join)
   
    _Booking[ left outer where carrier_id = 'UA' 
              and flight_date = '20250315' ].flight_date // Path Expression with Outer Join & Parameters (Left Outer Join)
    
} where TravelId = '00000001'
    or  TravelId = '00000002'


