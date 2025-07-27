@AbapCatalog.sqlViewName: 'Z_TRAVEL_VIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
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
define view ZI_TRAVEL_VIEW_CH
as select from /dmo/travel as Travel
association to /dmo/agency as _Agency on $projection.AgencyId = _Agency.agency_id
{
   // * " Select * (All) supported in CDS View only & obsolete from View Entity
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
    
    $session.client as sysClient, // Session Variables
    $session.system_language as sysLang,
    $session.system_date as sysData,
    
    _Agency, // Exposed Association
    _Agency.agency_id //Adhoc Association
}


/* 

Name List Example Implementation

//define view Zi_Travel_View_Sample_01  ( TravelId, AgencyId, CustomerId )
//as select from /dmo/travel Travel_01
//{
//    key travel_id as Travel_Id,
//    agency_id as Agency_Id,
//    customer_id as Customer_Id
//}

*/


