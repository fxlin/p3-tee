# Experiment: secure vision

We will run a computer vision service in the secure world. This is useful when we want to ensure the confidentiality of the input data and also the integrity of the service code in the face of the untrusted normal world.  

[TOC]

## Task overview

We will create a TA that accepts **encrypted** images (in jpg) submitted from the CA. The TA will run license plate detection service on the input images; for each detected license plate on the image, the TA will return the results, e.g. coordinates of its bounding boxes, license plate info, etc. <!--- and the license plate text???--->

<img src="exp-flow.png" alt="exp-flow" style="zoom: 67%;" />


## Challenges

### Designing the CA/TA interface

The basic interaction flow can be learnt from the helloworld example. Passing image data (large chunks, variable length) in/out can be learnt from the sdp (secure data path) example. 

You will come up with the command(s) and the formats of parameters passed in/out of the secure world. 

### Shopping for proper libraries

#### Computer vision library 

We need to run code inside the TA for image decoding and simple vision algorithms. On one hand, we do not want to reinvent the wheel. On the other hand, we cannot use popular frameworks such as Tensorflow or nCNN. Why? Optimized for speed and rich features, they are large and have extensive external dependency. Porting them to the secure world will be tedious, if not impossible. Furthermore, we are limited to libraries implemented in C as OPTEE does not have libs and runtimes, e.g. for C++ or Python. 

Indeed, we are looking for an "embedded" library that is lightweight, self-sufficient, and in C. To this end, SOD seems a good choice. It provides simple sample programs and good documentation. 

https://sod.pixlab.io/intro.html

![license](license.png)

For those who wish to use the SOD library, we have ported the library to the secure world. The build instruction and API documentation can be found [here](sod.md) . 

Meanwhile, you should also feel free to pick your choice of libs. 

See the general [porting guide](porting.md) for porting libraries/apps into TrustZone.

#### Cryptos

You will choose the encryption/decryption algorithm used by the normal/secure worlds. Consider: 

<!------------- For example, prior to asking CA to submit the images to TA, you may have **your own code** to encrypt the images, which is considered trusted and shares a secret key with TA in secure world for decryption.    -------->

1. Symmetric or asymmetric? Two families of crypto schema are at our hand: symmetric and asymmetric. The former uses only ***one*** key for both  encryption and decryption while the latter uses a public/private key pair: ***public*** key for encryption and ***private*** key for decryption.  The choice of these cryptos lead to different performance overhead. 
2. Are there existing implementations for the crypto you chose? Notably, is it easy to port to OPTEE?
3. How would you store the crypto key in the secure world? 

### Reasoning about security

Each design decision you made above is crucial to the security of the system. Consider the following questions: 

* With your design of CA/TA interface, what could normal world learn at best? Does this affect the design goal of your system? 
* What is the implication of accepting user-input images and run algorithms on them inside secure world? Is the system safe for good by putting the security sensitive code inside secure world?
* With your choice of crypto, what additional assumptions you **must** make to ensure security? Hints: 
  * Symmetric encryption uses only one key. Can you expose it to normal world? If you have to do so to encrypt images, what assumption you must make to ensure the images are still confidential?  
  * How do you store the key(s)? Can you bake them into TA and why?   

## Deliverables
*cs6456 students: see assignments from Teams*

1. A tarball that demonstrates your code works. 

2. A report discussing:
   * performance measurement
   * your choices of 3rd-party libs, why you chose them, and how you ported them to TEE
   * security analysis that shows your reasoning 
