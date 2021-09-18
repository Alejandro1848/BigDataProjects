# BigDataProjects


## Amazon_analysis.py 
### Requisitos:
Descargar el data set de https://www.kaggle.com/kritanjalijain/amazon-reviews. Los archivos train.csv y test.csv contienen todas las muestras de entrenamiento como valores separados por comas.

### OutPut:

Si dentro del script de carga el data_set test.csv el out put será:

"1" 200000

"2" 200000

Si dentro del script de carga el data_set train.csv el out put será:

"1" 1800000

"2" 1800000

Ambos resultados muestran el conteo de un subconjunto de calificaciones de 34,686,770 reseñas de Amazon de 6,643,669 usuarios sobre 2,441,053 productos.Significando las calificaciones 1 para calificaciones negativas y 2 para calificaciones positivas. Para mayores detalles sobre el data set consúltese : https://www.kaggle.com/kritanjalijain/amazon-reviews.

## Big_Query_tabs_vs_spaces.sql 
### Requisitos:

Cuenta en Google Cloud Platform (GCP). Big Query. Git-Hub Public Data Set.

Con esta consulta de SQL se puede averiguar si es más popular el uyso de espacios o tabulaciones entre diferentes programadores de diferentes lenguajes usando un data set públco de Git-Hub.

## san_francisco_bikeshare_trips.sql
### Requisitos:
Cuenta en Google Cloud Platform (GCP). Big Query. 

Ejemplo de consulta estática.

## dynamicSQL_san_francisco_bikeshare_trips.sql
### Requisitos:
Cuenta en Google Cloud Platform (GCP). Big Query.

¿Qué pasa si las fuentes de datos públicos de Big Query se actualizan? Podemos realizar una consulta "dinámica" con la sentencia VIEW, de mandera tal que el preview del data set creado no aparecerá hasta que compilesmos la consulta SQL.
