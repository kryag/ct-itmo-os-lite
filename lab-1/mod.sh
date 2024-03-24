#!/bin/bash

awk -v args="$*" '
    BEGIN {
        split(args, universities)
        for (i in universities) {
            u = universities[i]
            count[u] = 0
            sum[u] = 0
        }
    }
    $2 in count {
        count[$2]++
        sum[$2] += $3
    }
    END {
        for (i in universities) {
            u = universities[i]
            if (count[u] > 0) {
                avg = sum[u] / count[u]
                printf "%s %.2f\n", u, avg
            } else {
                print u, "No data"
            }
        }
    }
' students.csv
