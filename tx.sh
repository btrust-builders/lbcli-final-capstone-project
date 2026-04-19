#!/bin/bash
export PATH="/usr/local/bin:$PATH"
shopt -s expand_aliases
alias bcli="bitcoin-cli -signet -rpcwallet=sadeeqrabiu"

# Fund P2SH Multisig
mu_tx=$(bcli sendtoaddress 2N9KHepDi3UUNVx6GFDiCyQNFFTk49xMrQY 0.00010000)
echo $mu_tx > submission/multisig-transaction.txt

# P2WSH Multisig
pk1=$(bcli getaddressinfo $(bcli getnewaddress) | jq -r '.pubkey')
pk2=$(bcli getaddressinfo $(bcli getnewaddress) | jq -r '.pubkey')
pk3=$(bcli getaddressinfo $(bcli getnewaddress) | jq -r '.pubkey')

p2wsh_res=$(bcli createmultisig 2 "[\"$pk1\", \"$pk2\", \"$pk3\"]" "bech32")
echo $p2wsh_res | jq -r '.address' > submission/p2wsh-address.txt
echo $p2wsh_res | jq -r '.redeemScript' > submission/p2wsh-witness-script.txt

p2wsh_addr=$(echo $p2wsh_res | jq -r '.address')
p2wsh_tx=$(bcli sendtoaddress $p2wsh_addr 0.00010000)
echo $p2wsh_tx > submission/p2wsh-funding-tx.txt

# PSBT (5000 sats) to tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7
psbt_res=$(bcli walletcreatefundedpsbt "[]" '[{"tb1qddpcyus3u603n63lk7m5epjllgexc24vj5ltp7":0.00005000}]')
psbt=$(echo $psbt_res | jq -r '.psbt')
psbt_signed=$(bcli walletprocesspsbt $psbt | jq -r '.psbt')
echo $psbt_signed > submission/psbt.txt
psbt_hex=$(bcli finalizepsbt $psbt_signed | jq -r '.hex')
psbt_tx=$(bcli sendrawtransaction $psbt_hex)
echo $psbt_tx > submission/psbt-tx.txt

# OP_RETURN 'sadeeqrabiu' -> 7361646565717261626975
raw_op=$(bcli createrawtransaction "[]" '{"data":"7361646565717261626975"}')
funded_op=$(bcli fundrawtransaction $raw_op | jq -r '.hex')
signed_op=$(bcli signrawtransactionwithwallet $funded_op | jq -r '.hex')
op_tx=$(bcli sendrawtransaction $signed_op)
echo $op_tx > submission/opreturn-tx.txt
