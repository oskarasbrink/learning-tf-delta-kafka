object Main extends App {
  import org.apache.spark.sql.SparkSession
  import io.delta.tables.DeltaTable
  val spark = SparkSession
      .builder()
      .appName("Utilities")
      .master("local[*]")
      .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
      .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
      .config("spark.hadoop.fs.s3a.access.key","asd123")
      .config("spark.hadoop.fs.s3a.secret.key","asd123")

      .getOrCreate()

//  val data = spark.range(0, 5)
//  data.write.format("delta").mode("overwrite").save("/tmp/delta-table")
//  val df = spark.read.format("delta").load("/tmp/delta-table")
//  df.show()
//  val data2 = spark.range(5, 10)
//  data2.write.format("delta").mode("overwrite").save("/tmp/delta-table")
//  df.show()
  spark.range(6).write.mode("overwrite").format("delta").save("s3a://mybucketfordeltaprototyping/delta-table")
  println("Hello, World!")
}

// --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"
// --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension"