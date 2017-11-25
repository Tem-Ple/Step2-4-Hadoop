package com.temple.hellomr;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class WCRunnable {
    public static void main(String[] args) throws IOException, ClassNotFoundException, InterruptedException {
        Runtime run = Runtime.getRuntime();
        Process p = run.exec("/usr/local/hadoop/bin/hdfs dfs -rm -r /out");
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line;
        while((line = br.readLine())!=null ){
            System.out.println(line);
        }
        Configuration conf = new Configuration();
        Job wordCountJob = Job.getInstance(conf);
        wordCountJob.setJarByClass(WCRunnable.class);

        wordCountJob.setMapperClass(WCMapper.class);
        wordCountJob.setReducerClass(WCReducer.class);

        wordCountJob.setMapOutputKeyClass(Text.class);
        wordCountJob.setMapOutputValueClass(LongWritable.class);

        wordCountJob.setOutputKeyClass(Text.class);
        wordCountJob.setOutputValueClass(LongWritable.class);

        FileInputFormat.setInputPaths(wordCountJob, new Path("hdfs://hadoop0:9000/test.txt"));
        FileOutputFormat.setOutputPath(wordCountJob, new Path("hdfs://hadoop0:9000/out"));

        wordCountJob.waitForCompletion(true);
    }
}
