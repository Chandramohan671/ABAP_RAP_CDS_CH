@AbapCatalog.sqlViewName: 'Z_TRAVEL_VIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for Travel'
@Metadata.ignorePropagatedAnnotations: true


@ClientHandling:{
type: #INHERITED,
algorithm: #AUTOMATED
}

@ObjectModel: {
    usageType: {
        serviceQuality: #A,
        sizeCategory: #M,
        dataClass: #MIXED
}
}
define view ZI_TRAVEL_VIEW_CH as select from /dmo/travel as Travel
association to /dmo/agency as _Agency on $projection.AgencyId = _Agency.agency_id
{
    key travel_id as TravelId,
    agency_id as AgencyId,
    customer_id as CustomerId,
    begin_date as BeginDate,
    end_date as EndDate,
    booking_fee as BookingFee,
    total_price as TotalPrice,
    currency_code as CurrencyCode,
    description as Description,
    status as Status,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    lastchangedat as Lastchangedat,
    
    $session.client as sysClient,
    $session.system_language as sysLang,
    $session.system_date as sysData,
    
    _Agency // Exposed Association
    //_Agency.agency_id
}
