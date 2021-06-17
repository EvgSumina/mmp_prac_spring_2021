SOURCE_BASE_PATH="/Sumina_Eugenia_hw_4"

TMP_FOLDER_TASK1="/Sumina_Eugenia_hw_4/task1"
TMP_FOLDER_TASK2="/Sumina_Eugenia_hw_4/task2"
TMP_FOLDER_TASK3="/Sumina_Eugenia_hw_4/task3"
TMP_FOLDER_TASK4="/Sumina_Eugenia_hw_4/task4"
TMP_FOLDER_TASK5="/Sumina_Eugenia_hw_4/task5"
TMP_FOLDER_TASK6="/Sumina_Eugenia_hw_4/task6"
INPUT_HADOOP_DIR="/Sumina_Eugenia_hw_4/input"
OUTPUT_HADOOP_DIR="/Sumina_Eugenia_hw_4/output"

HADOOP_STREAMING_PATH="${HADOOP_HOME}/share/hadoop/tools/lib/hadoop-streaming-3.2.1.jar"

hdfs dfs -test -d ${INPUT_HADOOP_DIR}
if [ $? -eq 0 ];
  then
    echo "Remove ${INPUT_HADOOP_DIR}"
    hdfs dfs -rm -r ${INPUT_HADOOP_DIR}
fi

hdfs dfs -test -d ${OUTPUT_HADOOP_DIR}
if [ $? -eq 0 ];
  then
    echo "Remove ${OUTPUT_HADOOP_DIR}"
    hdfs dfs -rm -r ${OUTPUT_HADOOP_DIR}
fi

test -d ${SOURCE_BASE_PATH}/data/output
if [ $? -eq 0 ];
  then
    echo "Remove ${SOURCE_BASE_PATH}/data/output"
    rm -rf ${SOURCE_BASE_PATH}/data/output
fi

test -d ${TMP_FOLDER_TASK1}
if [ $? -eq 0 ];
  then
    echo "Remove ${TMP_FOLDER_TASK1}"
    hdfs dfs -rm -r ${TMP_FOLDER_TASK1}
fi

test -d ${TMP_FOLDER_TASK2}
if [ $? -eq 0 ];
  then
    echo "Remove ${TMP_FOLDER_TASK2}"
    hdfs dfs -rm -r ${TMP_FOLDER_TASK2}
fi

test -d ${TMP_FOLDER_TASK3}
if [ $? -eq 0 ];
  then
    echo "Remove ${TMP_FOLDER_TASK3}"
    hdfs dfs -rm -r ${TMP_FOLDER_TASK3}
fi

test -d ${TMP_FOLDER_TASK4}
if [ $? -eq 0 ];
  then
    echo "Remove ${TMP_FOLDER_TASK4}"
    hdfs dfs -rm -r ${TMP_FOLDER_TASK4}
fi

test -d ${TMP_FOLDER_TASK5}
if [ $? -eq 0 ];
  then
    echo "Remove ${TMP_FOLDER_TASK5}"
    hdfs dfs -rm -r ${TMP_FOLDER_TASK5}
fi

test -d ${TMP_FOLDER_TASK6}
if [ $? -eq 0 ];
  then
    echo "Remove ${TMP_FOLDER_TASK6}"
    hdfs dfs -rm -r ${TMP_FOLDER_TASK6}
fi

hdfs dfs -mkdir -p ${INPUT_HADOOP_DIR}
hdfs dfs -copyFromLocal ${SOURCE_BASE_PATH}/data/input/ratings.csv ${INPUT_HADOOP_DIR}/ratings
hdfs dfs -copyFromLocal ${SOURCE_BASE_PATH}/data/input/movies.csv ${INPUT_HADOOP_DIR}/movies

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_1.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_1.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D mapred.text.key.comparator.options=k1,1 \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_1.py -reducer src/reducer_1.py \
  -input ${INPUT_HADOOP_DIR}/* -output ${TMP_FOLDER_TASK1} \
"
hadoop jar ${HADOOP_STREAMING_PATH} ${hadoop_streaming_arguments}

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_2.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_2.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D mapred.text.key.comparator.options=k1,1 \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_2.py -reducer src/reducer_2.py \
  -input ${TMP_FOLDER_TASK1}/* -output ${TMP_FOLDER_TASK2} \
"
hadoop jar ${HADOOP_STREAMING_PATH} ${hadoop_streaming_arguments}

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_3.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_3.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D mapred.text.key.comparator.options=k1,1 \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_3.py -reducer src/reducer_3.py \
  -input ${INPUT_HADOOP_DIR}/ratings/* ${TMP_FOLDER_TASK2}/* -output ${TMP_FOLDER_TASK3} \
"
hadoop jar ${HADOOP_STREAMING_PATH} ${hadoop_streaming_arguments}

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_4.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_4.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D mapred.text.key.comparator.options=k1,1 \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_4.py -reducer src/reducer_4.py \
  -input ${TMP_FOLDER_TASK3}/* -output ${TMP_FOLDER_TASK4} \
"
hdfs dfs -copyToLocal ${OUTPUT_HADOOP_DIR} ${SOURCE_BASE_PATH}/data

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_5.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_5.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D mapred.text.key.comparator.options=k1,1 \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_5.py -reducer src/reducer_5.py \
  -input ${INPUT_HADOOP_DIR}/ratings/* ${TMP_FOLDER_TASK4}/* -output ${TMP_FOLDER_TASK5} \
"
hdfs dfs -copyToLocal ${OUTPUT_HADOOP_DIR} ${SOURCE_BASE_PATH}/data

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_6.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_6.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D mapred.text.key.comparator.options=k1,1 \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_6.py -reducer src/reducer_6.py \
  -input ${INPUT_HADOOP_DIR}/movies/* ${TMP_FOLDER_TASK5}/* -output ${TMP_FOLDER_TASK6} \
"
hdfs dfs -copyToLocal ${OUTPUT_HADOOP_DIR} ${SOURCE_BASE_PATH}/data

chmod 0777 ${SOURCE_BASE_PATH}/src/mapper_7.py
chmod 0777 ${SOURCE_BASE_PATH}/src/reducer_7.py
hadoop_streaming_arguments="\
  -D mapred.reduce.tasks=8 \
  -D mapreduce.map.java.opts=-Xmx4g \
  -D mapreduce.reduce.java.opts=-Xmx4g \
  -D stream.num.map.output.key.fields=3 \
  -D mapreduce.partition.keycomparator.options='-k1,1-k3,3nr-k2,2' \
  -files ${SOURCE_BASE_PATH}/src \
  -mapper src/mapper_7.py -reducer src/reducer_7.py \
  -input ${TMP_FOLDER_TASK6}/* -output ${OUTPUT_HADOOP_DIR} \
"
hdfs dfs -copyToLocal ${OUTPUT_HADOOP_DIR} ${SOURCE_BASE_PATH}/data

hdfs dfs -rm -r ${INPUT_HADOOP_DIR}
hdfs dfs -rm -r ${OUTPUT_HADOOP_DIR}
hdfs dfs -rm -r ${TMP_FOLDER_TASK1}
hdfs dfs -rm -r ${TMP_FOLDER_TASK2}
hdfs dfs -rm -r ${TMP_FOLDER_TASK3}
hdfs dfs -rm -r ${TMP_FOLDER_TASK4}
hdfs dfs -rm -r ${TMP_FOLDER_TASK5}
hdfs dfs -rm -r ${TMP_FOLDER_TASK6}
