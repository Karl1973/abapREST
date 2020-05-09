@EndUserText.label: 'Protection View 09'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity ZCDX_C_ORDERS_U_09
  as projection on ZCDX_I_ORDERS_U_09
{

      @Search.defaultSearchElement: true
  key order_nr,

      @Search.defaultSearchElement: true
      order_date,

      @Search.defaultSearchElement: true
      customer,

      @Consumption.valueHelpDefinition: [ { entity: { name:    'I_Currency',
                                                      element: 'Currency' } } ]
      currency_code,

      _Currency

}
