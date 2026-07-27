#!/usr/bin/env bash
# How many new outputs were created by block 243,825?

block_hash=$(bitcoin-cli -signet getblockhash 243825)
bitcoin-cli -signet getblock "$block_hash" 2 |
  jq '[.tx[].vout[]] | length'
