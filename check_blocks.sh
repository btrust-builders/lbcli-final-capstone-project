#!/bin/bash
export PATH="/usr/local/bin:$PATH"

bcli() {
  /usr/local/bin/bitcoin-cli -signet -rpcwallet=sadeeqrabiu "$@"
}

check_tx() {
    txid=$1
    bh_file=$2
    cb_file=$3
    echo "Checking $txid..."
    while true; do
        bh=$(bcli gettransaction $txid | jq -r '.blockhash')
        if [ "$bh" != "null" ] && [ -n "$bh" ]; then
            echo "$bh" > submission/$bh_file
            cb=$(bcli getblock $bh 1 | jq -r '.tx[0]')
            echo "$cb" > submission/$cb_file
            echo "Mined $txid in block $bh!"
            break
        fi
        sleep 10
    done
}

echo "Waiting for blocks to mine..."
check_tx $(cat submission/transaction-2.txt) block-2.txt coinbase-2.txt
check_tx $(cat submission/multisig-transaction.txt) multisig-block.txt multisig-coinbase.txt
echo "All done!"
