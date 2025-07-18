@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Association to Inner Join CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ASSOCIATION_INNERJOIN__DEMO as select from 
ZI_CDS_ASSOCIATION_DEMO._Booking as Booking  // This will create Inner Join
association[1..1] to /DMO/I_Customer as _Customer
on Booking.customer_id = _Customer.CustomerID
{
    booking_id as BookingId,    // Able to access Booking (Target) fields only from the association, as path expression derefering to Target Entity in View Definition  
    booking_date as BookingDate,
    _Customer[inner].CustomerID as CustomerId,  // This will also create join (Path Expression)
    
    _Customer[CountryCode = 'DE' ].CountryCode // Additional Filter Parameter for On Condition
    
} where customer_id = '000594'
