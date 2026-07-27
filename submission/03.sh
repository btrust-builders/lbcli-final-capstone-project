#!/usr/bin/env bash
# Which tx in block 216,351 spends the coinbase output of block 216,128?

coinbase_txid=$(
  bitcoin-cli -signet getblock \
    "$(bitcoin-cli -signet getblockhash 216128)" |
    jq -r '.tx[0]'
)

bitcoin-cli -signet getblock \
  "$(bitcoin-cli -signet getblockhash 216351)" 2 |
  jq -r --arg txid "$coinbase_txid" \
    '.tx[] | select(any(.vin[]; .txid == $txid)) | .txid'
