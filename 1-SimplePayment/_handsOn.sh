## HandsOn

### Assuming you got 2 addresses, AddressA, and AddressB
### And that Roberto's address is
### addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt

export RobADDR=addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt

#EADR1's UTXO 1:
export UTXO1=8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0#1

export EADR1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
export EADR2=addr_test1vrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94gsr7qk0

#Full/Base addresess:
export BADR1=addr_test1qzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30q2qctfvr5298c0hnedumpv4n4yaqrawmq4q5sa0558a2r7snx8aq2
export BADR2=addr_test1qrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94d3djssjl78ezxgvpx69ct6tng8evye0a9xmp4l3dctplps06xa3f

export PREVIEW="testnet-magic 2"
export _1100_=1100000000

### 1- Define a single transaction that send 1100 tADA to Roberto's address 
: '
cardano-cli transaction build \
    --babbage-era     \
    --$PREVIEW        \
    --tx-in  $UTXO1   \
    --tx-out $RobADDR+$_1100_ \
    --change-address $EADR1   \
    --protocol-params-file protocol.params \
    --out-file handsOnTX.unsignedc
'

# cardano-cli transaction txid --tx-file ./handsOnTX.unsigned 
# f698177b120365e9f906974a4f1ade4bc2698f27c88f7df731608aa2a4ef896b

# cardano-cli query utxo --address $RobADDR --$PREVIEW

: '
 cardano-cli transaction sign \
    --$PREVIEW        \
    --signing-key-file  ../wallets/enterprise1.skey \
    --tx-body-file      handsOnTX.unsigned          \
    --out-file          handsOnTX.signed 
'
: '
cardano-cli transaction submit \
    --$PREVIEW \
    --tx-file  handsOnTX.signed 
'
# FEITO:
# https://preview.cexplorer.io/tx/f698177b120365e9f906974a4f1ade4bc2698f27c88f7df731608aa2a4ef896b

# o que saiu para carteira do Roberto:
# cardano-cli query utxo --tx-in f698177b120365e9f906974a4f1ade4bc2698f27c88f7df731608aa2a4ef896b#0 --$PREVIEW
# o que voltou para minha carteira como troco:
# cardano-cli query utxo --tx-in f698177b120365e9f906974a4f1ade4bc2698f27c88f7df731608aa2a4ef896b#1 --$PREVIEW

### 2- Define a single transaction that spend value from your AddressA and send five (5) 100tADA UTxOs to your AddressB.

export _100_=100000000
export UTXO1=f698177b120365e9f906974a4f1ade4bc2698f27c88f7df731608aa2a4ef896b#1
: '
cardano-cli transaction build \
    --babbage-era     \
    --$PREVIEW        \
    --tx-in  $UTXO1   \
    --tx-out $BADR1+$_100_   \
    --tx-out $BADR1+$_100_   \
    --tx-out $BADR1+$_100_   \
    --tx-out $BADR1+$_100_   \
    --tx-out $BADR1+$_100_   \
    --change-address $EADR1  \
    --protocol-params-file protocol.params \
    --out-file handsOnTX2.unsigned
'
# WARNING: '--protocol-params-file' for 'transaction build' is deprecated
# Estimated transaction fee: Lovelace 178745
: ' 
 cardano-cli transaction sign \
    --$PREVIEW        \
    --signing-key-file  ../wallets/enterprise1.skey \
    --tx-body-file      handsOnTX2.unsigned         \
    --out-file          handsOnTX2.signed 
'
: '
cardano-cli transaction submit \
    --$PREVIEW \
    --tx-file  handsOnTX2.signed 
'
#FEITO:
# Transaction successfully submitted.

# cardano-cli query utxo --address $BADR1 --$PREVIEW
#                            TxHash                                 TxIx        Amount
# --------------------------------------------------------------------------------------
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     0        100000000 lovelace + TxOutDatumNone
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     1        100000000 lovelace + TxOutDatumNone
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     2        100000000 lovelace + TxOutDatumNone
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     3        100000000 lovelace + TxOutDatumNone
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     4        100000000 lovelace + TxOutDatumNone

# cardano-cli query utxo --address $EADR1 --$PREVIEW
#                            TxHash                                 TxIx        Amount
# --------------------------------------------------------------------------------------
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     5        7399488581 lovelace + TxOutDatumNone

#====================================================================================================================

### 3- Define a single transactino that spend value from  AddressB and send two(2) 100tADA UTxOs to your AddressA 
###    and three(3) 50tADA UTxOs to Roberto's address.

# Total: 500 tADA. Note: 100 in each Utxo:ixs (0,1,2,3,4)
# Amount to be transfered: 100 x 2 + 50 x 3 = 350 tADA
# Minimun needed: 400 tADA (4 Utxo's) + fee
# money back    : 50  tADA

export _100_=100000000
export _50_=50000000
# I will consume only the last 4 ones [1,2,3,4]
export UTXO1=481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a#1
export UTXO2=481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a#2
export UTXO3=481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a#3
export UTXO4=481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a#4
# from $BADR1 ADDRESS_B
# to 2x 100 to ADDRESS_A (EADR1)
# to 3x 50  to ROBERTO ADDR
# change back to ADDRESS_A (EADR1)
: '
cardano-cli transaction build \
    --babbage-era     \
    --$PREVIEW        \
    --tx-in  $UTXO1   \
    --tx-in  $UTXO2   \
    --tx-in  $UTXO3   \
    --tx-in  $UTXO4   \
    --tx-out $EADR1+$_100_   \
    --tx-out $EADR1+$_100_   \
    --tx-out $RobADDR+$_50_  \
    --tx-out $RobADDR+$_50_  \
    --tx-out $RobADDR+$_50_  \
    --change-address $EADR1  \
    --protocol-params-file protocol.params \
    --out-file handsOnTX3.unsigned
'

# WARNING: '--protocol-params-file' for 'transaction build' is deprecated
# Estimated transaction fee: Lovelace 194365

# cardano-cli transaction txid --tx-file ./handsOnTX3.unsigned 
# 6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b

# ADDR_B <- enterprise1.skey

# cardano-cli transaction sign \
#     --$PREVIEW               \
#     --signing-key-file  ../wallets/enterprise1.skey \
#     --tx-body-file      handsOnTX3.unsigned      \
#     --out-file          handsOnTX3.signed 

# cardano-cli transaction submit \
#     --$PREVIEW \
#     --tx-file  handsOnTX3.signed 

#Transaction successfully submitted.

# https://preview.cexplorer.io/address/addr_test1qzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30q2qctfvr5298c0hnedumpv4n4yaqrawmq4q5sa0558a2r7snx8aq2/tx#data

### 4- Define a single transaction that takes 2 inputs from your AddressA with more than 100tADA and pay to Roberto's Address 90, 
###    and your wallet 10, and send the change back to your wallet.

# cardano-cli query utxo --address \
# > addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh \
# > --$PREVIEW
#                            TxHash                                 TxIx        Amount
# --------------------------------------------------------------------------------------
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     5        7399488581 lovelace + TxOutDatumNone
# 6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b     0        100000000 lovelace + TxOutDatumNone
# 6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b     1        100000000 lovelace + TxOutDatumNone
# 6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b     5        49805635 lovelace + TxOutDatumNone

export _90_=90000000
export _10_=10000000
export UTXO0=6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b#0
export UTXO1=6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b#1

# cardano-cli transaction build \
#     --babbage-era     \
#     --$PREVIEW        \
#     --tx-in  $UTXO0   \
#     --tx-in  $UTXO1   \
#     --tx-out $RobADDR+$_90_  \
#     --tx-out $EADR1+$_10_    \
#     --change-address $EADR1  \
#     --protocol-params-file protocol.params \
#     --out-file handsOnTX4.unsigned

#Estimated transaction fee: Lovelace 174697

# cardano-cli transaction sign \
#     --$PREVIEW               \
#     --signing-key-file  ../wallets/enterprise1.skey \
#     --tx-body-file      handsOnTX4.unsigned         \
#     --out-file          handsOnTX4.signed 

# cardano-cli transaction submit \
    # --$PREVIEW \
    # --tx-file  handsOnTX4.signed 

# https://preview.cexplorer.io/tx/a04fa1f4dab7839875f2e4814745d4f4a2abf82739128c7cfaa3560d00212d05
