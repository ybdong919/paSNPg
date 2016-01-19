#!/bin/bash

echo "Start to remove SNP sites with missing."
perl ./Scripts/missing_level.pl
echo -e "Running is over.\nResults are outputted into the folder Outout_results."
 