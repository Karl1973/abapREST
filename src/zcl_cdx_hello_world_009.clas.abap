CLASS zcl_cdx_hello_world_009 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cdx_hello_world_009 IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(lt_params) = request->get_form_fields(  ).

    READ TABLE lt_params REFERENCE INTO DATA(lr_params) WITH KEY name = 'command'.
    IF sy-subrc <> 0.
      response->set_status( i_code = 400
                            i_reason = 'Bad request').
      RETURN.
    ENDIF.

    CASE lr_params->value.
      WHEN `eav`.
        response->set_text( |Küss die Hand, schöne Frau - Ihre Augen sind so blau - Tirili, tirilo, tirila| ).
      WHEN `user`.
        response->set_text( |{ sy-uname } - KARLA| ).
      WHEN OTHERS.
        response->set_status( i_code = 400
                              i_reason = 'Bad request').
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
