#!/usr/bin/env bash
export jar="/Users/jtr4v/IdeaProjects/PBGA/pbga-cli/target/pbga-cli-0.0.1-SNAPSHOT.jar"
export yaml="/Users/jtr4v/IdeaProjects/PBGA/pbga-cli/src/main/resources/application.justin.yml"
export java_cmd="java -jar $jar --config $yaml annotate-sv "
for file in `ls -1 data/*vcf.gz`
# for file in `ls data/cloudSV.PBOnly.HG00512.012317.ILL.genotyped.vcf.gz data/cloudSV.PBOnly.HG00513.012317.ILL.genotyped.vcf.gz`
do
    echo ===
    echo analyzing $file
    output_file=annotated/`basename $file`
    export cmd="$java_cmd $file $output_file"
    echo $cmd
    $cmd    
    echo ~~~
done
