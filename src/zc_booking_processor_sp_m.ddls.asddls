@EndUserText.label: 'Booking projection view'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI: {
  headerInfo: { typeName: 'Booking', 
                typeNamePlural: 'Bookings', 
                title: { type: #STANDARD, value: 'BookingID' } } }

@Search.searchable: true 

define view entity ZC_BOOKING_PROCESSOR_SP_M as projection on ZI_Booking_SP_M
{
   @UI.facet: [ { id:            'Booking',
                  purpose:       #STANDARD,
                  type:          #IDENTIFICATION_REFERENCE,
                  label:         'Booking',
                  position:      10 },
                { id:            'BookingSupplement',
                  purpose:       #STANDARD,
                  type:          #LINEITEM_REFERENCE,
                  label:         'Booking Supplement',
                  position:      20
                  //targetElement: '_BookSupplement'
                  } ]
    
      @Search.defaultSearchElement: true 
      key travel_id                 as TravelID,
      
      @UI: { lineItem:       [ { position: 20, importance: #HIGH } ],   
             identification: [ { position: 20 } ]}
      @Search.defaultSearchElement: true
      key booking_id                as BookingID,
  
      @UI: { lineItem:       [ { position: 30, importance: #HIGH } ], 
             identification: [ { position: 30 } ] }  
      booking_date                  as BookingDate,
      
      @UI: { lineItem:       [ { position: 40, importance: #HIGH } ],
             identification: [ { position: 40 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Customer', element: 'CustomerID' }}]
      @Search.defaultSearchElement: true
      customer_id                   as CustomerID,
      
      @UI: { lineItem:       [ { position: 50, importance: #HIGH } ],
             identification: [ { position: 50 } ] }
      @Consumption.valueHelpDefinition: [{entity: {name: '/DMO/I_Carrier', element: 'AirlineID' }}]
      @ObjectModel.text.element: ['CarrierName']
      carrier_id                    as CarrierID,
      _Carrier.Name                 as CarrierName,
      
      @UI: { lineItem:       [ { position: 60, importance: #HIGH } ],
             identification: [ { position: 60 } ] }
      @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
                                           additionalBinding: [ { localElement: 'FlightDate',   element: 'FlightDate'},
                                                                { localElement: 'CarrierID',    element: 'AirlineID'},
                                                                { localElement: 'FlightPrice',  element: 'Price'},
                                                                { localElement: 'CurrencyCode', element: 'CurrencyCode' } ] } ]
      connection_id                 as ConnectionID,
            
      @UI: { lineItem:       [ { position: 70, importance: #HIGH } ],
             identification: [ { position: 70 } ] }
      @Consumption.valueHelpDefinition: [ {entity: {name: '/DMO/I_Flight', element: 'FlightDate' },                   
                                           additionalBinding: [ { localElement: 'ConnectionID', element: 'ConnectionID'},
                                                                { localElement: 'CarrierID',    element: 'AirlineID'},
                                                                { localElement: 'FlightPrice',  element: 'Price' },
                                                                { localElement: 'CurrencyCode', element: 'CurrencyCode' }]}]
      flight_date                   as FlightDate,
      
      @UI: { lineItem:       [ { position: 80, importance: #HIGH } ], 
             identification: [ { position: 80 } ] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price                  as FlightPrice,
     
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      currency_code                 as CurrencyCode,
      
      @UI: { lineItem:       [ { position: 90, importance: #HIGH, label: 'Status' } ],
             identification: [ { position: 90, label: 'Status [N(New)| X(Canceled)| B(Booked)]' } ] }      
      booking_status                as BookingStatus,

      @UI.hidden: true
      last_changed_at    as LastChangedAt,
      
      /* Associations */ 
      _Travel: redirected to parent ZC_TRAVEL_PROCESSOR_SP_M,
     // _BookSupplement: redirected to composition child ZC_BookSuppl_Processor_SP_M,
      _Customer,   
      _Carrier
    
}
