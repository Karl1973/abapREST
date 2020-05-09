@AbapCatalog.sqlViewName: 'ZCDXIORDERSU09'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Order 09'
define root view ZCDX_I_ORDERS_U_09 as select from zcdx_order_00 
association [0..1] to I_Currency       as _Currency  
                     on $projection.currency_code    = _Currency.Currency
                     {
    
   key order_nr, 
    order_date,
    customer,
    @Semantics.currencyCode: true
    currency_code,
    
    _Currency    
}
