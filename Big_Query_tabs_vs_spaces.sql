WITH lines_of_code AS (
SELECT
   SPLIT(content, '\n') AS line, # rompemos lineas individuales-> concierte un loque de código masivo en una matriz más pequeña
   sample_path,
   sample_repo_name
FROM  `bigquery-public-data.github_repos.sample_contents`
)
 #cada línea de código ahora es parte de una matriz
 #SELECT * FROM lines_of_code LIMIT 100;

# aplanamos la matriz para que podamos analizarla más fácilmente
, flattened_line_of_code AS (
SELECT
   flattened_line,
   sample_path,
   sample_repo_name
FROM lines_of_code , UNNEST(line) AS flattened_line #Desempauqtemos la matriz antes creada usando UNNEST()
)

# matriz aplanada (tenga en cuenta que cada ruta y repo_name se repite ahora)

# analizar el primer carácter de cada línea de código

, parse_first_character AS (
SELECT
    SUBSTR(flattened_line,1,1) AS first_character, # Para la linea aplanada vemos la primera posición y el primer carácter, para cada línea del código
    flattened_line,
    sample_path,
    sample_repo_name
FROM flattened_line_of_code
)

# filtrar las líneas de código que comienzan con tabulación o espacio solamente
# REGEXP_CONTAINS Descripción. Devuelve VERDADERO si el valor es una coincidencia parcial de la expresión regular, regex.
#Si el argumento regex no es válido, la función devuelve un error.

,tabs_or_spaces AS(
SELECT
    first_character,
    IF(REGEXP_CONTAINS(first_character, r'[\t]'),1,0) AS tab_count,
    IF(REGEXP_CONTAINS(first_character, r'[ ]'),1,0) AS space_count,
    flattened_line,
    sample_path,
    sample_repo_name
FROM parse_first_character
WHERE REGEXP_CONTAINS(first_character, r'[ \t]') # solo mira las pestañas o los espacios
)


# agregar y filtrar por archivo de código completo
,tabs_or_spaces_count AS (
SELECT
  COUNT(flattened_line) AS lines, # número total de líneas
  SUM(tab_count) AS tabs_count, # sumar el número total de tab
  SUM(space_count) AS spaces_count, # total de espacios
  IF(SUM(tab_count) > SUM(space_count),1,0) AS tab_winner,
  IF(SUM(tab_count) < SUM(space_count),1,0) AS space_winner,
  REGEXP_EXTRACT(sample_path, r'\.([^\.]*)$') AS extension, # ruta del archivo
  sample_path,
  sample_repo_name
FROM tabs_or_spaces
GROUP BY sample_path, sample_repo_name
HAVING tabs_count > 10 OR spaces_count> 10 #solo incluye archivos con más de 10 instancias
)

# agregue todos los archivos por extensión de código (.java, etc.)
,tabs_or_spaces_by_extension AS (
SELECT
    extension,
    COUNT(lines) AS files,
    SUM(lines) AS lines,
    SUM(tab_winner) AS tabs,
    SUM(space_winner) AS spaces,
    LOG((SUM(space_winner)+1)/(SUM(tab_winner)+1)) lratio
  FROM tabs_or_spaces_count
  GROUP BY extension
  ORDER BY files DESC
  LIMIT 100 #solo incluye los 100 principales por volumen de extensión
)

SELECT
  extension,
  FORMAT("%'d", files) AS   files,
  FORMAT("%'d", lines) AS   lines,
  FORMAT("%'d", tabs) AS   tabs,
  FORMAT("%'d", spaces) AS spaces,
  ROUND(lratio,5) AS lratio
  FROM  tabs_or_spaces_by_extension
