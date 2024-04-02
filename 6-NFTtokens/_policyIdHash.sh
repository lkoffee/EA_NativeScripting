echo "Generating Policy id Hash:"
# Calculate the PolicyId from the monetary policy script.
cardano-cli transaction policyid \
    --script-file _NFTpolicy.script \
    > _NFTpolicy.pid  

cat ./_NFTpolicy.pid    