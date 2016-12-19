#!/usr/bin/env python3

import sys
import json
from pprint import pprint

property_map = sys.argv[1].strip('[]').split('][')
data = {}

if len(sys.argv) == 2:
  json_data = json.load(sys.stdin)
elif len(sys.argv) == 3:
  json_data = json.loads(sys.argv[2])

if len(property_map) > 0:
  for property_item in property_map:
    property_item = property_item.strip('\'"')
    if property_item.isdigit():
      property_item = int(property_item)
    if property_item != '':
      json_data = json_data[property_item]

pprint(json_data)
