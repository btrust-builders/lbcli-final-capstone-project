# Btrust Builders: LBCLI Final Capstone Exercise

## Instructions

Exercise should be done using the [Signet](https://mempool.space/signet) test network.

A remote Signet node has been created for this exercise, all you have to do is to send bitcoin-cli commands to it.

You need to add these lines to your `bitcoin.conf` file to connect to it:

```
signet=1
[signet]
rpcuser=btrustbuildersrpc
rpcpassword=btrustbuilderspass
rpcconnect=165.22.121.70
```

...and then execute `bitcoin-cli -signet getblockchaininfo`.

Using the command above with return an object containing various state info regarding the blockchain on Signet which you can confirm on `https://mempool.space/signet`.

*HINT*: Use `bitcoin-cli help` and `bitcoin-cli help <command name>` to learn what commands are available and what they do.
You can also check out [Bitcoin Core RPC API Reference docs](https://developer.bitcoin.org/reference/rpc/index.html)

*NOTE*: You don't need to start a local bitcoin daemon, just use the `bitcoin-cli` command to execute RPC commands to the remote Signet node.


## Expected submissions

1. Fork this repository.
2. Go to the `Actions` tab and enable github workflow for your repository by clicking `I understand my ...`

<img src="https://github.com/btrust-builders/lbcli-final-capstone-project/blob/main/enable-github-actions.png" width="500" />

3. Clone your fork to your local computer.
4. Add your bitcoin cli commands to the script files: `01.sh to 09.sh` in the `submission` folder. Example:
   ```sh
   $ bitcoin-cli -signet getblockcount
   ```
5. Commit and push your changes to the `main` branch of your remote fork.

6. Confirm your forked repository has a green check mark.

<img src="https://github.com/btrust-builders/lbcli-final-capstone-project/blob/main/success.png" width="1000" />

7. For the final exercise, follow instructions in `FINAL-TASK.TXT` file and update all other `xxx.txt` files.

8. Submit your solution to this form: [Google form](https://forms.gle/eDRGAJXpLqRxEExR6).

PS: You can commit and push as often as you like and GitHub Actions will re-evaluate your code every time.
You will need to look through the auto-grader logs (in the "Actions" tab) to see what exactly you got right or wrong.
