cardano-cli query protocol-parameters --testnet-magic 2 --out-file protocol.params

export EADR1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
export EADR2=addr_test1vrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94gsr7qk0
# Note: EADR2 has nothing 

#EADR1's UTXOs:
export UTXO1=6e080cd142f556c29e108db4fecb18860e2985832f22437458ace3cb32b01a2b#5
export UTXO2=a04fa1f4dab7839875f2e4814745d4f4a2abf82739128c7cfaa3560d00212d05#2
# Totoal 149.00 tADA

#Base addresess:
#BADR1 UTXO:
# 100 tADA
export BADR1=addr_test1qzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30q2qctfvr5298c0hnedumpv4n4yaqrawmq4q5sa0558a2r7snx8aq2
export UTXO3=481e2d3192433b8c525f0ad4b717e6e44bbdca015c59656d8a99c22a8acb0f3a#0

#BADR2 UTXO:
# 1000
export BADR2=addr_test1qrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94d3djssjl78ezxgvpx69ct6tng8evye0a9xmp4l3dctplps06xa3f
export UTXO4=93265481d5dfba506b8706269ef82fb3bff91b775cb6d8f2f2048ec68dc74226#0
# Total 1,100.00 tADA

export NAMI=addr_test1qpc6mrwu9cucrq4w6y69qchflvypq76a47ylvjvm2wph4szeq579yu2z8s4m4tn0a9g4gfce50p25afc24knsf6pj96sz35wnt

export PREVIEW="testnet-magic 2"
export _1000_=1000000000

# Total sum UTXos: 149.00 + 1,100.00 = 1,249.00 + fee
cardano-cli transaction build \
  --babbage-era  \
  --$PREVIEW     \
  --tx-in $UTXO1 \ 
  --tx-in $UTXO2 \ 
  --tx-in $UTXO3 \ 
  --tx-in $UTXO4 \ 
  --tx-out $NAMI+$_1000_   \ 
  --change-address $EADR2  \ 
  --protocol-params-file protocol.params \
  --out-file paymw.unsigned

# Estimated transaction fee: Lovelace 185037

# EADR1
cardano-cli transaction witness \
  --tx-body-file paymw.unsigned \
  --signing-key-file  ../wallets/enterprise1.skey \
  --testnet-magic 2 \
  --out-file enterprise1.witness

# BADR1
cardano-cli transaction witness \
  --tx-body-file paymw.unsigned \
  --signing-key-file  ../wallets/enterprise1.skey \
  --testnet-magic 2 \
  --out-file base1.witness

# BADR2
  cardano-cli transaction witness \
  --tx-body-file paymw.unsigned \
  --signing-key-file  ../wallets/enterprise2.skey \
  --testnet-magic 2 \
  --out-file base2.witness

cardano-cli transaction assemble \
  --tx-body-file paymw.unsigned \
  --witness-file enterprise1.witness \
  --witness-file base1.witness    \
  --witness-file base2.witness    \
  --out-file paymw.assembled 

cardano-cli transaction submit \
  --tx-file paymw.assembled \
  --testnet-magic 2