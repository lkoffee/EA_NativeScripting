#Creating keys and accounts (entrerprise and staking adresses)

# mkdir -p ../wallets

# #Create keys
# echo "[Generating Payment keys]"

# cardano-cli address key-gen \
# --verification-key-file ../wallets/enterprise1.vkey \
# --signing-key-file      ../wallets/enterprise1.skey

# echo "[Generating Staking keys]"

# cardano-cli stake-address key-gen \
# --verification-key-file ../wallets/staking1.vkey \
# --signing-key-file      ../wallets/staking1.skey

# #Create addresses
# #Enterprise addr: Payment only
# echo "[Creating addresses]"
# echo ""
# echo "[Creating only Enterprise addr]"

# # Build a Shelley payment address, with [optional] delegation to a stake address.
# cardano-cli address build \
# --payment-verification-key-file ../wallets/enterprise1.vkey \
# --out-file ../wallets/enterp1.addr \
# --testnet-magic 2

# #Create addresses
# #Stake addr     : Payment + Staking
# echo "[Creating Stake addr]"
# cardano-cli address build \
# --payment-verification-key-file ../wallets/enterprise1.vkey \
# --stake-verification-key-file   ../wallets/staking1.vkey    \
# --out-file ../wallets/full1.addr \
# --testnet-magic 2

# Outro par de Endereços:

# echo "[Generating Payment keys 2]"

# cardano-cli address key-gen \
# --verification-key-file ../wallets/enterprise2.vkey \
# --signing-key-file      ../wallets/enterprise2.skey

# echo "[Generating Staking keys 2]"

# cardano-cli stake-address key-gen \
# --verification-key-file ../wallets/staking2.vkey \
# --signing-key-file      ../wallets/staking2.skey

# #Create addresses
# #Enterprise addr: Payment only
# #Stake addr     : Payment + Staking
# echo "[Creating addresses]"
# echo ""
# echo "[Creating only Enterprise addr 2]"

# # Build a Shelley payment address, with [optional] delegation to a stake address.
# cardano-cli address build \
# --payment-verification-key-file ../wallets/enterprise2.vkey \
# --out-file ../wallets/enterp2.addr \
# --testnet-magic 2

# #Stake addr     : Payment + Staking
# echo "[Creating Stake addr]"
# cardano-cli address build \
# --payment-verification-key-file ../wallets/enterprise2.vkey \
# --stake-verification-key-file   ../wallets/staking2.vkey    \
# --out-file ../wallets/full2.addr \
# --testnet-magic 2

cardano-cli query utxo --address $(cat ../wallets/enterp1.addr) --testnet-magic 2

# ./myFirstTest.sh 
#                            TxHash                                 TxIx        Amount
# --------------------------------------------------------------------------------------
# 422118454b98e0f04fec34302f441d55eedfc64f155897dfec89e0d1fed57ea6     0        10000000000 lovelace + TxOutDatumNone
