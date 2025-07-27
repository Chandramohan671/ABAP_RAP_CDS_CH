@AbapCatalog.sqlViewName: 'ZSQL_ASPECT_DEMO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS with generic aspect'
@Metadata.ignorePropagatedAnnotations: true

@AccessControl.auditing.type: #CUSTOM
@AccessControl.auditing.specification: 'abc'

define view ZI_CDS_ASPECT_DEMO 
with parameters 
                @Environment.systemField: #SYSTEM_DATE // Annotations for System field with default value.
                p_date : abap.dats 
                as select from ZI_TRAVEL_VIEW_CH
{
    key TravelId,
    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    sysClient,
    sysLang,
    sysData,
    agency_id,
    /* Associations */
    _Agency
}
