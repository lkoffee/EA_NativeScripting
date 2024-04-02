#OBS: USEI pra enviar TADA pra minha Nami walletTEST CRIADA EM MARÇO 31 2024

#ADR1's UTXO:
export UTXO1=c7d3598cabe6fcca84b45c136a82f5d055829e6ff7fbfe0c8a7dc67936593fb4#1

#Enterprise addresses:
export EADR1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
export NAMI=addr_test1qrpmvcvdz2rhhpfay8kd982e2lhq3cvvtzcsan4n7774m7frkqska89mrm0p0fz94qhykea6agc4kqgl508039n6v9dshqfmka

#Full/Base addresess:
export BADR1=addr_test1qzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30q2qctfvr5298c0hnedumpv4n4yaqrawmq4q5sa0558a2r7snx8aq2
export BADR2=addr_test1qrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94d3djssjl78ezxgvpx69ct6tng8evye0a9xmp4l3dctplps06xa3f

export PREVIEW="testnet-magic 2"

# TEST - From Enterprise addr to Enterprise addr
cardano-cli transaction build \
    --babbage-era   \
    --$PREVIEW      \
    --tx-in  $UTXO1 \
    --tx-out $NAMI+1000000000  \
    --change-address $EADR1     \
    --out-file _paymentTX.unsigned
#Resp:
# WARNING: '--protocol-params-file' for 'transaction build' is deprecated
# Estimated transaction fee: Lovelace 165721

# Pergunta: Quando eu build uma transação ela não vai para a MemPool? - Eu não encontrei nada lá

#comando: Print a transaction identifier.
# cardano-cli transaction txid --tx-body-file ./paymentTX.unsigned
# Retorno: 8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0 (Nesse momento a TX ainda nao existe na rede)

# Assinando a Tx:
cardano-cli transaction sign \
    --$PREVIEW               \
    --signing-key-file  ../wallets/enterprise1.skey \
    --tx-body-file      _paymentTX.unsigned          \
    --out-file          _paymentTx.signed

#  Submit a transaction to the local node whose Unix domain socket is obtained
#  from the CARDANO_NODE_SOCKET_PATH environment variable.

cardano-cli transaction submit \
    --$PREVIEW \
    --tx-file  _paymentTx.signed

#Transaction successfully submitted.

#OBS: A hash da transação vista no comando anterior aparece exatamente como é na rede apos submetida
# UTXO do EADR1: passou a ser: https://preview.cexplorer.io/address/addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh/utxo#data
#                              https://preview.cexplorer.io/tx/8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0
# txo   : 8431f6abe67eb0f0682d78ef333390e809c77035435856abf6134c3c76ec62e0#1


cardano-cli query utxo --address $(cat ../wallets/enterp1.addr) --$PREVIEW

cardano-cli query utxo --address $(cat ../wallets/enterp2.addr) --$PREVIEW

cardano-cli query utxo --address $NAMI --$PREVIEW