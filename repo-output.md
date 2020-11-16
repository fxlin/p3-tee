```bash
xzl@granger1[p3]$ mkdir optee-qemuv8 && cd optee-qemuv8 && \
repo init -q -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml -b 3.9.0 && \
repo sync -j4 --no-clone-bundle

remote: Enumerating objects: 360, done.
remote: Counting objects: 100% (360/360), done.
remote: Compressing objects: 100% (256/256), done.
remote: Enumerating objects: 124, done.
remote: Counting objects: 100% (124/124), done.
remote: Compressing objects: 100% (94/94), done.
remote: Total 124 (delta 15), reused 73 (delta 7), pack-reused 0
Receiving objects: 100% (124/124), 52.77 KiB | 6.60 MiB/s, done.
Resolving deltas: 100% (15/15), done.
remote: Enumerating objects: 74386, done.         | 23.27 MiB/s
remote: Enumerating objects: 7, done.         MiB | 23.27 MiB/s
remote: Counting objects: 100% (7/7), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 393713 (delta 161), reused 221 (delta 104), pack-reused 393353
Receiving objects: 100% (393713/393713), 115.01 MiB | 29.39 MiB/s, done.
remote: Counting objects: 100% (74386/74386), done.        iB/s
remote: Enumerating objects: 977, done.         MiB | 16.78 MiB/sg objects:  21% (14590/69476)
remote: Counting objects: 100% (977/977), done.        6.78 MiB/s
Resolving deltas: 100% (261566/261566), done.       | 16.78 MiB/s
remote: Compressing objects: 100% (818/818), done.        2 MiB/s
remote: Total 977 (delta 269), reused 517 (delta 149), pack-reused 0
Receiving objects: 100% (977/977), 2.49 MiB | 10.44 MiB/s, done.
Resolving deltas: 100% (269/269), done.
remote: Total 348883 (delta 0), reused 1 (delta 0), pack-reused 348876
Receiving objects: 100% (348883/348883), 288.77 MiB | 21.27 MiB/s, done.
remote: Enumerating objects: 95, done.        )        ving deltas:  16% (41754/251879)
remote: Counting objects: 100% (95/95), done.
remote: Compressing objects: 100% (75/75), done.
remote: Total 95 (delta 10), reused 88 (delta 10), pack-reused 0
remote: Enumerating objects: 81, done.        )        rk.gitResolving deltas:  42% (105795/251879)
remote: Counting objects: 100% (81/81), done.
remote: Compressing objects: 100% (74/74), done.
remote: Total 81 (delta 19), reused 28 (delta 5), pack-reused 0
Resolving deltas: 100% (251879/251879), done.6)        esolving deltas:  65% (163757/251879)
remote: Enumerating objects: 98, done.        )
remote: Counting objects: 100% (98/98), done.
remote: Compressing objects: 100% (74/74), done.
remote: Total 98 (delta 34), reused 50 (delta 14), pack-reused 0
Fetching projects:  46% (6/13) buildroot/buildroot.gitremote: Compressing objects:  72% (50467/69476) remote: Enumerating objects: 2382, done.
remote: Counting objects: 100% (2382/2382), done.
remote: Enumerating objects: 554, done.
remote: Counting objects: 100% (554/554), done.
remote: Compressing objects: 100% (424/424), done.
remote: Total 554 (delta 102), reused 376 (delta 77), pack-reused 0
Receiving objects: 100% (554/554), 3.16 MiB | 22.65 MiB/s, done.
remote: Compressing objects: 100% (1809/1809), done.
Resolving deltas: 100% (102/102), done.
remote: Total 2382 (delta 624), reused 1354 (delta 527), pack-reused 0
Receiving objects: 100% (2382/2382), 3.23 MiB | 12.34 MiB/s, done.
Resolving deltas: 100% (624/624), done.
Fetching projects:  61% (8/13) OP-TEE/optee_os.gitremote: Compressing objects:  92% (63918/69476)     remote: Enumerating objects: 4, done.        6)
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 19 (delta 0), reused 2 (delta 0), pack-reused 15
Fetching projects:  69% (9/13) linaro-swg/soc_term.gitremote: Compressing objects:  94% (65308/69476) remote: Enumerating objects: 6435, done.
remote: Compressing objects: 100% (69476/69476), done.
remote: Counting objects: 100% (6435/6435), done.
remote: Enumerating objects: 3061, done.
remote: Counting objects: 100% (3061/3061), done.
remote: Compressing objects: 100% (2664/2664), done.        mpressing objects:  32% (853/2664)
remote: Total 3061 (delta 618), reused 1127 (delta 174), pack-reused 0
Receiving objects: 100% (3061/3061), 4.17 MiB | 15.89 MiB/s, done.
Resolving deltas: 100% (618/618), done..33 MiB | 14.60 MiB/s
Fetching projects:  84% (11/13) TF-A/trusted-firmware-a.gitremote: Compressing objects:  59% (3505/586remote: Compressing objects: 100% (5862/5862), done.        /s
remote: Total 6435 (delta 850), reused 2407 (delta 443), pack-reused 0
Receiving objects: 100% (6435/6435), 17.53 MiB | 9.36 MiB/s, done.
Resolving deltas: 100% (850/850), done.
Fetching projects:  92% (12/13) qemu/qemu.gitReceiving objects:  39% (29397/74386), 46.33 MiB | 10.29 remote: Total 74386 (delta 6219), reused 23125 (delta 4128), pack-reused 0
Receiving objects: 100% (74386/74386), 195.83 MiB | 8.05 MiB/s, done.
Resolving deltas: 100% (6219/6219), done.
Fetching projects: 100% (13/13), done.
Updating files: 100% (15361/15361), done.oot/buildroot.gitUpdating files:  63% (9680/15361)
Updating files: 100% (70014/70014), done.ore/edk2.gitUpdating files:  27% (19547/70014)
Checking out projects: 100% (13/13), done.
repo sync has finished successfully.
xzl@granger1[optee-qemuv8]$
xzl@granger1[optee-qemuv8]$ ls
build      edk2   mbedtls          optee_client    optee_os    qemu      trusted-firmware-a
buildroot  linux  optee_benchmark  optee_examples  optee_test  soc_term
```
