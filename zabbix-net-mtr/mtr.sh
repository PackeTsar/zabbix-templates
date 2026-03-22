#!/bin/bash

IP=$1
mtr  -r -c3 -b -j $IP | jq '
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
