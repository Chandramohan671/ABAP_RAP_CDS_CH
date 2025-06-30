@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view for Booking'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_RAP_BOOKING_CH as projection on ZI_RAP_BOOKING_CH
{
    key BookingUuid,
    TravelUuid,
    @Search.defaultSearchElement: true
    BookingId,
    BookingDate,
    @Search.defaultSearchElement: true
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    CreatedBy,
    LastChangedBy,
    LocalLastChangedAt,
    
    /* Associations */
    _Carrier,
    _Connection,
    _Customer,
    _Flight,
    _Travel  : redirected to parent ZC_RAP_TRAVEL_CH
}
