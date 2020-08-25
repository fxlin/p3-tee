# Lab3: Trusted Execution Environment (TEE)

<img src="https://www.thefastmode.com/media/k2/items/src/7df193d5a2be86814850ef16aacb19d6.jpg?t=20200606_093102?date=13042020" alt="Enterprises Need To Focus On IoT Security" style="zoom: 67%;" />

In this lab, we will experience with Arm's TEE - TrustZone. 

Instead of writing baremetal TEE code, we will write our TEE code running atop a popular TEE framework -- OPTEE. 

## Objective

* (primary) experience with modern hardware-based isolation mechanism.
* (primary) security-oriented programming. 
* (primary) porting existing libs to a new environment 
* (secondary) building embedded AI

## Overview

This las has three phases: 

* [Quickstart](quickstart.md): set up the OPTEE development environment. You should follow the instructions. 
* [App examples](helloworld.md): demo two simple OPTEE apps which show basic app structures. You should reproduce the demo and tinker with the apps
* Porting libs to OPTEE: 
  * [Guidelines](porting.md)
  * [Case study: the SOD lib](sod.md)
* [Experiment](exp.md): an assignment in which you will build a machine learning service inside TrustZone. 
