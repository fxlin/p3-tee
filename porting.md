## Porting existing libraries to TrustZone 

### Who are this doc for? 

People who are trying to port existing codebase/libraries into TrustZone. But really the knowledge is general and can be transferred when porting any software on one runtime environment to another. 

### What is this doc about?

This doc briefly describes the approaches and process of porting an existing codebase into TrustZone running OPTEE.

### Key porting challenges 

The challenges mainly come from OPTEE as a baremetal programming environment:

* No POSIX support. This means the application cannot simply call:
  * `open`, `read` , `write`,  `mmap`, etc.   
  * This is the major challenge but can be addressed via emulation or outsourcing.
* Minimal runtime library support. 
  * No libc -- you cannot use `<stdio.h>`  from libc 
  * Some utilities such as `<string.h>` can still be used   
* Poor-to-none debugging facility. You cannot not `gdb` the TA running in TZ. Debugging relies on printing and instincts.
  * Crash log also differs from what you already know of a normal world user application.

### General approach

The overall guideline for porting an application into TrustZone is simple: **find & substitute**.

* **Find** the interfaces that the application interact with normal world `std` environment and 
* **Substitute** them with their secure world implementation

#### Finding the interfaces

It is easy to find the interfaces -- just compile and let the compiler tell you what interfaces are missing (i.e. symbols that have `undefined referece`). These interfaces/symbols include the ones as listed above,`open`, `mmap`, etc., and also some global variables defined by `libc` such as a per-app error number.

#### Substitute them with TrustZone implementation

Once the interfaces are found, you only need to substitute them by linking them against their respective TrustZone implementations. 

For example, in the case of `open`, you only need to define the same function as `open` with identical arguments and return types, and link against the new `open` during compilation.

The above is just an example of how to get it compiled, but how to get it work? There are two approaches towards getting the substituted interfaces functional:

**Outsource.** This offloads the function to normal world. For example, to `read` a file in normal world,  TrustZone may request a `read`  of the file to normal world, outsourcing the whole storage stack to normal world, and asking it to read the file for TrustZone. Once the file is `read` into normal world memory, TrustZone can thus pull the filedata into secure memory. 

In general, to implement this method, one has to setup a message passing channel between normal and secure world, following the below process:

* Secure world issues a request to execute a `func` 
* Normal world receives the request and execute the `func` for secure world
* Once the execution finishes, normal world returns the results **as byte streams** back to secure world  

**Important notes:**

* The approach gives away the *content* of the request (i.e. the requested function and its arguments) because they are not encryptable. Also the returned results are NOT to be trusted and be used when making security decisions. 
* Sometimes more sophisticated data structure are returned (e.g. `struct stat` returned by `stat()` and `fstat`). They must be reconstructed from bytes stream once received by secure world.  
* Ideally, the outsourced functions shall be simple enough in the sense that their input/output can be easily serialized & deserialized as messages passed between normal and secure world. 

**Emulation.** This approach implements substitute functions inside secure world which have the equivalent functionality as its original function. Since they only seek functional equivalence and their implementations can be entirely different, they *emulate* the behavior of the original functions.  The following example is useful for comprehending this approach:

Imaging one function to be ported is `pow(a, n)` which calculates the `n`th exponent power of `a`. While its normal world implementation has comprehensive implementations for handling corner cases and optimizations, you know somehow (by profiling the normal world app and its workload) the function will only be called to calculate the square of `a` , that is, only `pow(a, 2)` will be called. 

To port, you only need to implement in secure world the same function with the same name `pow` that handles the square case with simplest possible implementation as follows:

```c
int pow(int a, int n) {
    if (n != 2) {
        abort();
    }
    return a * a;
}
```

More complex use will be introduced in the case study section.  

