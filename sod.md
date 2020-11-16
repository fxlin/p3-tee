# Porting SOD to OPTEE

## Purpose 
* describe how to use the SOD library that we have ported to OPTEE
* describe our porting & debugging methodologies, which is crucial for you to use SOD and port other libs to OPTEE

## Quickstart

To use the ported SOD:

1. Grab the code from https://github.com/zaxguo/sod/tree/tz (branch tz). 

2. Put `libm.a` under the same directory as `libutee.a`, `libteec.a`; put all other source files (e.g. `sod.h`, `sod.c`) under the source path of your TA.

3. Modify your TA Makefile so that `sod.c` can be compiled and `libm.a` can be located and linked.

4. Include `sod.h` in your TA source code. Call supported `sod` functions as you like. 

5. Compile the TA normally. 

<!--- can we provide a tiny example? --->

## What's working?

After bringing the necessary libraries, SOD can be compiled and linked together with a TA. However, some functions are apparently not working due to the measures we take to port the libraries, as described above. The working functions and caveats are summarized below.

* What's working:
  * SOD's own library functions: these functions are SOD self-contained. E.g. converting a chunk of byte to an RGB image, denoted by the type `sod_img`. 
  * Image processing functions:  some basic algorithms such as load the grayscale image (i.e. `sod_img_load_grayscale`), canny edge detection (i.e. `sod_canny_edge_image`). These functions will be used to perform the license plate detection function.
* What's not working:
  * CNN related functions: embedded machine learning is cool, and theoretically can be supported. However, it requires a fully functional on-demand paging of OP-TEE since SOD-supported NN model consumes ~80MB of RAM which does not fit in TrustZone.
    * Big bonus if you CAN make it work

## What we did? 

Despite SOD is designed for "embedded" environment, it depends on a set of functionalities provided by the underlying OS: 

1. Filesystem (related) services*. E.g., `open`,`close`, `read,` `write,` `mmap` 
2. Standard libraries. E.g. `stdlib.h`, `stdio.h`, `math.h`

*: SOD implements an abstraction layer to handle the filesystem API differences of Unix & Windows and allows custom APIs for other OSes. 

To port SOD into TEE, we will bridge the services provided by OPTEE to what is expected by SOD. 

For 1. the solution is simple -- simply supply the required semantics to SOD while ensuring it can execute correctly. This is done in `fs.h` and `stat.h` added to the ported library. As you may see, required but not necessary APIs are substituted by a stub function, which does nothing. 

For 2. it is slightly trickier, as these libraries need actual implementation (e.g. for math functions) and cannot be simply substituted by stubs. Luckily, OP-TEE OS provides its version of standard libraries (i.e. `stdlib.h` and `stdio.h`) with some missing functions (e.g. `fputs`, `fwrite`). Porting them would only need to implement stubs for these functions. Examples can be found in `sod.c` which adds stub implementation for symbols such as  `fputs`, `fwrite`, and `stderr`. For math functions, which need actual implementation, I took the pre-compiled `libm.a`, slightly modified its header file `math.h` & `ctype.h`, and brought them to TZ for SOD to link against.  

## How to debug? 

As you might imagine, the ported library is flaky and might crash. The output might look like the following: <!--- where does the trace show?--->

```c
D/TC:? 0 tee_ta_init_pseudo_ta_session:284 Lookup pseudo TA deadbeef-2450-11e4-abe2-0002a5d5cb
D/TC:? 0 load_ldelf:703 ldelf load address 0x40006000
D/LD:  ldelf:134 Loading TA deadbeef-2450-11e4-abe2-0002a5d5c51b
D/TC:? 0 tee_ta_init_session_with_context:573 Re-open TA 3a2f8978-5dc0-11e8-9c2d-fa7ae01bbebc
D/TC:? 0 system_open_ta_binary:257 Lookup user TA ELF deadbeef-2450-11e4-abe2-0002a5d5c51b (S)
D/TC:? 0 system_open_ta_binary:259 lwg: open = 0x101055e8
D/TC:? 0 secstor_ta_open:21 lwg:secstor_ta_open:21: res = ffff0008
D/TC:? 0 system_open_ta_binary:261 res=0xffff0008
D/TC:? 0 system_open_ta_binary:257 Lookup user TA ELF deadbeef-2450-11e4-abe2-0002a5d5c51b (R)
D/TC:? 0 system_open_ta_binary:259 lwg: open = 0x10105124
D/TC:? 0 system_open_ta_binary:261 res=0x0
D/LD:  ldelf:169 ELF (deadbeef-2450-11e4-abe2-0002a5d5c51b) at 0x40088000
D/TC:? 0 tee_ta_close_session:499 csess 0x101776e0 id 1
D/TC:? 0 tee_ta_close_session:518 Destroy session
D/TC:0 0 abort_handler:524 [abort] abort in User mode (TA will panic)
E/TC:? 0 
E/TC:? 0 User TA data-abort at address 0x10 (translation fault)
E/TC:? 0  esr 0x92000045  ttbr0 0x200001018f000   ttbr1 0x00000000   cidr 0x0
E/TC:? 0  cpu #0          cpsr 0x20000100
E/TC:? 0  x0  0000000000000010 x1  0000000000000000
E/TC:? 0  x2  00000000400cb953 x3  0000000000000000
E/TC:? 0  x4  00000000400cd490 x5  0000000000000080
E/TC:? 0  x6  00000000400d3ce0 x7  0000000000000020
E/TC:? 0  x8  0000000040013e20 x9  00000000400cbe24
E/TC:? 0  x10 0000000000000000 x11 0000000000000000
E/TC:? 0  x12 0000000000000000 x13 0000000040013c38
E/TC:? 0  x14 0000000000000000 x15 0000000000000000
E/TC:? 0  x16 0000000000000000 x17 0000000000000000
E/TC:? 0  x18 0000000000000000 x19 0000000000000001
E/TC:? 0  x20 0000000040094e2c x21 00000000400d3ce0
E/TC:? 0  x22 00000000400d7ce0 x23 0000000000000001
E/TC:? 0  x24 0000000000000008 x25 00000000400d3ce0
E/TC:? 0  x26 0000000040013b90 x27 0000000000000000
E/TC:? 0  x28 0000000000000000 x29 00000000400138a0
E/TC:? 0  x30 0000000040098ac0 elr 0000000040098aec
E/TC:? 0  sp_el0 00000000400138a0
E/LD:  Status of TA deadbeef-2450-11e4-abe2-0002a5d5c51b
E/LD:   arch: aarch64
E/LD:  region  0: va 0x40004000 pa 0x10800000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x40006000 pa 0x10802000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x4000e000 pa 0x1080a000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x4000f000 pa 0x1080b000 size 0x003000 flags rw-s (ldelf)
E/LD:  region  4: va 0x40012000 pa 0x1080e000 size 0x001000 flags r--s
E/LD:  region  5: va 0x40013000 pa 0x10860000 size 0x001000 flags rw-s (stack)
E/LD:  region  6: va 0x40088000 pa 0x00001000 size 0x045000 flags r-xs [0]
E/LD:  region  7: va 0x400cd000 pa 0x00046000 size 0x00c000 flags rw-s [0]
E/LD:   [0] deadbeef-2450-11e4-abe2-0002a5d5c51b @ 0x40088000
E/LD:  Call stack:
E/LD:   0x0000000040098aec
E/LD:   0x00000000400a25b0
E/LD:   0x00000000400a52a0
E/LD:   0x00000000400a5450
E/LD:   0x00000000400a6490
E/LD:   0x00000000400a698c
E/LD:   0x00000000400944e0
E/LD:   0x00000000400abcb4
E/LD:   0x00000000400a6b90
E/LD:   0xfffffffffffffffc
D/TC:? 0 user_ta_enter:167 tee_user_ta_enter: TA panicked with code 0xdeadbeef
```

This is the dumped stack trace, which is hard to parse by human eyes. Luckily, OP-TEE OS has already provided a script to parse the stack trace into human-readable function call stack. The script can be found in `optee_os/scripts/symbolize.py` . Its usage is simple -- simply feed the stack trace dump to the script, and supply the directory of your TA:  <!---- how to collect stack.dump--->

```
$ export CROSS_COMPILE=aarch64-linux-gnu-
$ cat stack.dump | optee_os/scripts/symbolize.py -d optee_examples/hellow_world/ta/` 
```

It then translates the call stack into the following:

```c
E/LD:  Call stack:
E/LD:   0x0000000040098aec stbi__err at /home/liwei/optee-rpi3/optee_examples/cv/ta/lib/sod_img_reader.h:933
E/LD:   0x00000000400a25b0 stbi__jpeg_test at /home/liwei/optee-rpi3/optee_examples/cv/ta/lib/sod_img_reader.h:3953
E/LD:   0x00000000400a52a0 stbi__load_and_postprocess_8bit at /home/liwei/optee-rpi3/optee_examples/cv/ta/lib/sod_img_reader.h:1193
E/LD:   0x00000000400a5450 stbi_load_from_memory at /home/liwei/optee-rpi3/optee_examples/cv/ta/lib/sod_img_reader.h:1359
E/LD:   0x00000000400a6490 sod_img_load_from_file at /home/liwei/optee-rpi3/optee_examples/cv/ta/lib/sod.c:13637
E/LD:   0x00000000400a698c sod_bench at /home/liwei/optee-rpi3/optee_examples/cv/ta/lib/sod.c:14040
E/LD:   0x00000000400944e0 TA_OpenSessionEntryPoint at /home/liwei/optee-rpi3/optee_examples/cv/ta/hello_world_ta.c:83
E/LD:   0x00000000400abcb4 entry_open_session at /home/liwei/optee-rpi3/optee_os/lib/libutee/arch/arm/user_ta_entry.c:239
E/LD:   0x00000000400a6b90 __ta_entry at /home/liwei/optee-rpi3/optee_os/out/arm/export-ta_arm64/src/user_ta_header.c:48
```

This makes it so much easier to locate where the bug is. <!--- explain the callstack ---> 
