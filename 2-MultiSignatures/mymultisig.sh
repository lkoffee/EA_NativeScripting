cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

# cardano-cli query utxo --address $EADR1 --$PREVIEW
#                            TxHash                                 TxIx        Amount
# --------------------------------------------------------------------------------------
# 481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a     5        7399488581 lovelace + TxOutDatumNone
# 6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b     5        49805635 lovelace + TxOutDatumNone
# a04fa1f4dab7839875f2e4814745d4f4a2abf82739128c7cfaa3560d00212d05     1        10000000 lovelace + TxOutDatumNone
# a04fa1f4dab7839875f2e4814745d4f4a2abf82739128c7cfaa3560d00212d05     2        99825303 lovelace + TxOutDatumNone

# cardano-cli query utxo --address $EADR2 --$PREVIEW
#                            TxHash                                 TxIx        Amount
# --------------------------------------------------------------------------------------
# 8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0     0        1000000000 lovelace + TxOutDatumNone

#EADR1's UTXO 1:
export UTXO1=a04fa1f4dab7839875f2e4814745d4f4a2abf82739128c7cfaa3560d00212d05#1
#EADR2's UTXO 0:
export UTXO0=8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0#0  

export EADR1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
export EADR2=addr_test1vrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94gsr7qk0

#Full/Base addresess:
export BADR1=addr_test1qzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30q2qctfvr5298c0hnedumpv4n4yaqrawmq4q5sa0558a2r7snx8aq2
export BADR2=addr_test1qrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94d3djssjl78ezxgvpx69ct6tng8evye0a9xmp4l3dctplps06xa3f

export NAMI=addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt

export PREVIEW="testnet-magic 2"
export _1000_=1000000000

# The sum of 2 UTXOs gives 1,010.00 (One thousand and Ten) tADAS
cardano-cli transaction build \
  --babbage-era  \
  --$PREVIEW     \
  --tx-in $UTXO1 \
  --tx-in $UTXO0 \
  --tx-out $BADR2+$_1000_ \
  --change-address $NAMI   \
  --protocol-params-file protocol.params \
  --out-file multisig.unsigned

cardano-cli transaction sign \
    --tx-body-file multisig.unsigned \
    --signing-key-file ../wallets/enterprise1.skey \
    --signing-key-file ../wallets/enterprise2.skey \
    --$PREVIEW \
    --out-file multisig.signed

 cardano-cli transaction submit \
    --$PREVIEW \
    --tx-file multisig.signed

# Transaction successfully submitted. Feb 29 2024 11:38
# https://preview.cexplorer.io/tx/93265481d5dfba506b8706269ef82fb3bff91b775cb6d8f2f2048ec68dc74226

cardano-cli query utxo --address $EADR1 --$PREVIEW
echo ""
cardano-cli query utxo --address $EADR2 --$PREVIEW
echo ""
cardano-cli query utxo --address $BADR2 --$PREVIEW
echo ""
cardano-cli query utxo --address $NAMI  --$PREVIEW
