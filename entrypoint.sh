#!/bin/sh

lsif-go --noContents --stdout | lsif-gomod --stdin --out data.lsif
