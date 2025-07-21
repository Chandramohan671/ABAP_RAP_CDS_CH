@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Practice for Currency & Unit Conversion'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_UNIT_CURRENCY_CONV_DEMO as select from zrap_travel_ch as Travel
association [1..1] to zrap_book_ch as _Booking   // Association [1..*] cardinality
on $projection.TravelGuid = _Booking.travel_uuid
//with default filter _Booking.flight_price > 500  // While accessing the association, if no parameter passed, then it will take this default filter condition
{
    key travel_uuid as TravelGuid,
    travel_id as TravelId,
    @Semantics.amount.currencyCode: 'currency_code'  // Currency code reference to Amount Field (Element Annotaions)
    booking_fee as BookingFee, // Amount
    
    @Semantics.amount.currencyCode: 'currency_code' // Currency conversion SQL Function
    currency_conversion( amount => booking_fee, 
    source_currency => Travel.currency_code,   // Source Currency
    target_currency => cast( 'INR' as abap.cuky(5) ), // Casting to Target Currency
    exchange_rate_date => $session.system_date,  // Date for Exchange Rate
    error_handling => 'SET_TO_NULL',  // Error handling
    round => 'X' )  // Round off the result value
    as convertedAmount,
    Travel.currency_code,  // Currency code
    
    _Booking            // Exposed Association
   // _Booking.booking_id  // Ad-hoc Association
   
} where _Booking.currency_code = 'USD'  // To Many Cardinality Association not allowed in where condition
