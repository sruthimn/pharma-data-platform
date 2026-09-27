{% macro load_cdc_demo() %}

    {% set sql %}
        COPY INTO PHARMA.SILVER.CDC_DEMO_RAW
        FROM (
            SELECT
                $1:movement_id::INT
                ,$1:material_id::VARCHAR
                ,$1:site::VARCHAR
                ,$1:quantity::NUMBER(10,2)
                ,$1:movement_type::VARCHAR
                ,$1:last_modified::TIMESTAMP_NTZ
                ,$1:silver_loaded_at::TIMESTAMP_NTZ
                ,METADATA$FILENAME
                ,,SYSDATE()
            FROM @PHARMA.SILVER.ADLS_SILVER_STAGE/export/cdc_demo/
        )
        FILE_FORMAT = (TYPE = PARQUET)
        PATTERN = '.*[.]parquet'
    {% endset %}

    {% do run_query(sql) %}
    {{ log("CDC demo: COPY INTO finished", info=True) }}

{% endmacro %}