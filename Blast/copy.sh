#! /bin/bash
for i in $(ls ${indir})
do
	cp $i/*.ffn ./ffn

done
