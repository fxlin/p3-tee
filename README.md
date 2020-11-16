# Trusted Execution Environment (TEE)

<img src="https://www.thefastmode.com/media/k2/items/src/7df193d5a2be86814850ef16aacb19d6.jpg?t=20200606_093102?date=13042020" alt="Enterprises Need To Focus On IoT Security" style="zoom: 67%;" />



**This project is to be completed on server: granger1**

In this project, we will experience with Arm's TEE - TrustZone. 

Instead of writing baremetal TEE code, we will write our TEE code running atop a popular TEE framework -- OPTEE. 

## Objective

* (primary) experience with modern hardware-based isolation mechanism.
* (primary) security-oriented programming. 
* (primary) porting existing software to a new environment 
* (secondary) building embedded AI

## Overview

* [Quickstart](quickstart.md): set up the OPTEE development environment. You should follow the instructions. 
* [App examples](helloworld.md): demo two simple OPTEE apps which show basic app structures. You should reproduce the demo and tinker with the apps
* Porting libs to OPTEE: 
  * [Guidelines](porting.md)
  * [Case study: the SOD lib](sod.md)
* [Programming challenge](secure-vision.md): an assignment in which you will build a machine learning service inside TrustZone. *(cs6456 students: refer to Teams for assignment)*

## Assignment weights

| Exp  | Weights |
| ---- | ------- |
| 1 TEE basics | 10     |
| 2 helloworld | 10     |
| 3 data path | 10     |
| 4 secure vision -- alpha | 15    |
| 5 secure vision -- beta | 15    |
The weights are relative and may not necessarily add up to 100. 

