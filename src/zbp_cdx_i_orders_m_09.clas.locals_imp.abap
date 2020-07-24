CLASS lhc_order DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS validateCustomer FOR VALIDATION order~validateCustomer
      IMPORTING keys FOR order.

    METHODS validateDates FOR VALIDATION order~validateDates
      IMPORTING keys FOR order.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Order RESULT result.

ENDCLASS.

CLASS lhc_order IMPLEMENTATION.

  METHOD validateCustomer.

* read entities
    READ ENTITY zcdx_i_orders_m_09\\Order FIELDS ( Customer ) WITH
       VALUE #( FOR <root_key> IN keys (  %key = <root_key> ) )
       RESULT DATA(lt_orders).

    LOOP AT lt_orders ASSIGNING FIELD-SYMBOL(<order>).
      IF <order>-customer > 99.
        APPEND VALUE #( order_nr = <order>-order_nr ) TO failed.
        APPEND VALUE #( order_nr = <order>-order_nr
                        %msg = new_message(  id = 'ZCDX_MESSAGES'
                                             number = '001'
                                             severity = if_abap_behv_message=>severity-error )
                        %element-order_nr = if_abap_behv=>mk-on ) TO reported.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateDates.

    READ ENTITY zcdx_i_orders_m_09\\Order FIELDS ( order_date ) WITH
     VALUE #( FOR <root_key> IN keys (  %key = <root_key> ) )
     RESULT DATA(lt_orders).

    LOOP AT lt_orders ASSIGNING FIELD-SYMBOL(<order>).
      IF <order>-order_date > cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %key = <order>-%key
                        order_nr = <order>-order_nr ) TO failed.
        APPEND VALUE #( %key = <order>-%key
                        %msg = new_message(  id = 'ZCDX_MESSAGES'
                                             number = '002'
                                             severity = if_abap_behv_message=>severity-error )
                        %element-order_date = if_abap_behv=>mk-on ) TO reported.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_features.

    DATA l_result LIKE LINE OF result.

    READ ENTITY zcdx_i_orders_m_09 FIELDS ( customer currency_code )
       WITH VALUE #( FOR keyval IN keys ( %key = keyval-%key ) )
       RESULT DATA(lt_orders).

    LOOP AT lt_orders ASSIGNING FIELD-SYMBOL(<order>).
      IF <order>-customer IS NOT INITIAL.
        l_result-order_nr = <order>-order_nr.
        l_result-%key = <order>-%key.
        l_result-%field-currency_code = if_abap_behv=>fc-f-mandatory.
        APPEND l_result TO result.
      ELSE.
        l_result-order_nr = <order>-order_nr.
        l_result-%key = <order>-%key.
        l_result-%field-currency_code = if_abap_behv=>fc-f-read_only.
        APPEND l_result TO result.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
