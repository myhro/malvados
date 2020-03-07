-- name: import-json
WITH
  raw_input(body) AS (
    VALUES($1::json)
  ),
  expand_list AS (
    SELECT json_array_elements(body) AS elem
      FROM raw_input
  ),
  list AS (
    SELECT
        CAST(elem->>'id' AS INTEGER) AS id,
        elem->>'text' AS text,
        elem->>'url' AS url
      FROM expand_list
  )

INSERT INTO comic (text, url, trigrams)
  SELECT
      REPLACE(text, E'\n', ' '),
      url,
      to_tsvector('portuguese', unaccent(text))
    FROM list
    ORDER BY id
;
