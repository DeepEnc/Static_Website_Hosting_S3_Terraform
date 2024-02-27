#!/bin/sh

aws s3 cp index.html s3://terraform-state-file-sunil-testing-12345
aws s3 cp style.css s3://terraform-state-file-sunil-testing-12345
aws s3 cp script.js s3://terraform-state-file-sunil-testing-12345
aws s3 cp 404.html s3://terraform-state-file-sunil-testing-12345
aws s3 cp images s3://terraform-state-file-sunil-testing-12345/images --recursive
