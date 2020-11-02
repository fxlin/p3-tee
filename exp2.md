# Exp 2: helloworld

## Context & Sessions (20%)

1. What is a TEE "context"? 
2. In one CA, how many TEE contexts can be simultanteonsly alive (i.e. initialized but not finalized)?
3. In one context, how many sessions can be opened simultanteonsly? 

Write some experiment code to prove your answers above. Just state your observations. No code submission is required. 



## Change `helloworld` (40%)

Change the source code: if the resultant value (i.e. after incrementing or decrementing) is NOT in the range of [0, 100], TA should return an error to the CA. Submit the code. 

How would you implement the error code?  (10%)

How do you verify that your code works properly? Attach a screenshot to prove it. (30%)



## Change `helloworld` again (40%)

Can you modify `helloworld` to have **persistent state**? For instance, the TA defines two new commands, SetValue and GetValue. GetValue will return the value that is set in SetValue most recently. 

Can your TA keep the value after the current **session** is closed and a new session is open? 

Can your TA keep the value after the current **context** is closed and a new context is open? 

State your design and your observations. Submit your code for experiment. 



