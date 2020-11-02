# Exp 4: secure vision -- alpha

Read the "secure vision" experiment document. 

## Design choices (20%)

1. List the TA commands that you plan to implement. For each command, list the arguments and its intended function. 
2. List your choices of libraries for: (a) license plate detection; (b) cryptos

## Reasoning about security (40%)

Each design decision you made above is crucial to the security of the system. Consider the following questions: 

* With your design of CA/TA interface, what could normal world learn at best? Does this affect the design goal of your system? 
* What is the implication of accepting user-input images and run algorithms on them inside secure world? Is the system safe for good by putting the security sensitive code inside secure world?
* With your choice of crypto, what additional assumptions you **must** make to ensure security? Hints: 
  * Symmetric encryption uses only one key. Can you expose it to normal world? If you have to do so to encrypt images, what assumption you must make to ensure the images are still confidential?  
  * How do you store the key(s)? Can you bake them into TA and why?   

## Alpha version (40%)

Implement CA/TA: CA submits an image; the TA returns a dummy license plate string.  

* The data in & out of the secure world must be encrypted
* The license plate detection could be absent in the secure world. 