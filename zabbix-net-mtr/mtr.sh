#!/bin/bash

IP=$1
FIRST_TTL=$2
mtr  -r -c3 -b -j -f $FIRST_TTL $IP | jq '
.report.hubs |= map(
  if (.host | test("\\(")) then
    . + {
      name: (.host | capture("^(?<h>.+) \\((?<ip>.+)\\)$").h),
      ip: (.host | capture("^(?<h>.+) \\((?<ip>.+)\\)$").ip)
    }
  else
    . + {
      name: "?",
      ip: .host
    }
  end
)
'
