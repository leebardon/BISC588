#!/bin/bash

BASE='/project/thrash_425/lbardon/final_project'

cd $BASE/data/tara_data

for url in `cat $BASE/scripts/ftp_raw_links.txt`
do
    wget $url
done