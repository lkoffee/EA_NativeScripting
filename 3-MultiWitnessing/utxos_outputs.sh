export EADR1=addr_test1vzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30qgf6duvh
export EADR2=addr_test1vrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94gsr7qk0

export BADR1=addr_test1qzxm33pyftx0fefr8g7e3s9rtd44cwzeqenddyuc5ej30q2qctfvr5298c0hnedumpv4n4yaqrawmq4q5sa0558a2r7snx8aq2
export BADR2=addr_test1qrr4fp9q4vk5mfs3f2x2gfgqef73qq8qdvp8ve0uwr0g94d3djssjl78ezxgvpx69ct6tng8evye0a9xmp4l3dctplps06xa3f

export PREVIEW="testnet-magic 2"

echo $EADR1 >> utxos_after_output.txt
cardano-cli query utxo --address $EADR1 --$PREVIEW >> utxos_after_output.txt
echo >> utxos_after_output.txt

echo $EADR2 >> utxos_after_output.txt
cardano-cli query utxo --address $EADR2 --$PREVIEW >> utxos_after_output.txt
echo >> utxos_after_output.txt

echo $BADR1 >> utxos_after_output.txt
cardano-cli query utxo --address $BADR1 --$PREVIEW >> utxos_after_output.txt
echo >> utxos_after_output.txt

echo $BADR2 >> utxos_after_output.txt
cardano-cli query utxo --address $BADR2 --$PREVIEW >> utxos_after_output.txt