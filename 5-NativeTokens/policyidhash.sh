echo "Generating Policy id Hash:"
# Calculate the PolicyId from the monetary policy script.
cardano-cli transaction policyid \
    --script-file mypolicy.script \
    > mymonetary2.pid    