@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface view for Booking'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_RAP_BOOKING_CH 
as select from zrap_book_ch as Booking

 association to parent zi_rap_travel_ch as _Travel on $projection.TravelUuid = _Travel.TravelUuid 
// The above statement with explicit ON condition will be used to link Parent Entity for Composition

//association [1..1] to ZI_RAP_TRAVEL_CH as _Travel on $projection.TravelUuid = _Travel.TravelUuid
association [1..1] to /DMO/I_Customer as _Customer on $projection.CustomerId = _Customer.CustomerID
association [1..1] to /DMO/I_Carrier as _Carrier on $projection.CarrierId = _Carrier.AirlineID
association [1..1] to /DMO/I_Connection as _Connection on $projection.ConnectionId = _Connection.ConnectionID
association [1..1] to /DMO/I_Flight as _Flight on $projection.CarrierId = _Flight.AirlineID
                                               and $projection.ConnectionId = _Flight.ConnectionID
                                               and $projection.FlightDate = _Flight.FlightDate
association [1..1] to I_Currency as _Currency on $projection.CurrencyCode = _Currency.Currency
{
    key booking_uuid as BookingUuid,
    travel_uuid as TravelUuid,
    booking_id as BookingId,
    booking_date as BookingDate,
    customer_id as CustomerId,
    carrier_id as CarrierId,
    connection_id as ConnectionId,
    flight_date as FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    flight_price as FlightPrice,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.user.localInstanceLastChangedBy: true
    local_last_changed_at as LocalLastChangedAt,
    
    // Exposed Association
    
    _Travel,
    _Customer,
    _Carrier,
    _Connection,
    _Flight
    
}
