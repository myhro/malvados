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

-- name: search
SELECT
    id,
    ts_headline(
      'portuguese',
      text,
      to_tsquery('portuguese', unaccent($1)),
      'HighlightAll = true'
    ) AS text,
    url
  FROM comic
  WHERE trigrams @@ to_tsquery('portuguese', unaccent($1))
  ORDER BY id DESC
;
