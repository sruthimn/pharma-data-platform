{% macro load_silver() %}
    {% for t in ['mes', 'lims', 'historian', 'erp'] %}
        {% do run_query("TRUNCATE TABLE PHARMA.SILVER." ~ t | upper) %}
        {% do run_query(
            "COPY INTO PHARMA.SILVER." ~ t | upper
            ~ " FROM @PHARMA.SILVER.ADLS_SILVER_STAGE/export/" ~ t ~ "/"
            ~ " FILE_FORMAT = (FORMAT_NAME = 'PHARMA.SILVER.PARQUET_FF')"
            ~ " PATTERN = '.*part-.*[.]parquet'"
            ~ " MATCH_BY_COLUMN_NAME = CASE_INSENSITIVE"
            ~ " FORCE = TRUE"
        ) %}
        {% do log("Loaded silver " ~ t, info=True) %}
    {% endfor %}
{% endmacro %}