from pyspark import SparkConf, SparkContext
import collections

# El siguiente script se va a ejecutar localmente 
conf = SparkConf().setMaster("local").setAppName("Amazon_rating_histogram")
sc=SparkContext(conf=conf) #establecer rdd's

def parseLine(line):
    fields=line.split(',')
    rating=fields[0]
    return(rating)
#Para cargar un data set se escribe la dirección en lugar
# de (---) en  "file:///(---)"

lines = sc.textFile("file:///C:/CursoSpark/test.csv")
ratings=lines.map(parseLine)
result = ratings.countByValue()

sortedResults = collections.OrderedDict(sorted(result.items()))
for key, value in sortedResults.items():
    print("%s %i" % (key, value))