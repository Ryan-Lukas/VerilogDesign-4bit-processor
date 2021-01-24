4 bit Processor
==============

Ryan Lukas

ECE 3700 - Digital System Design - Spring 2019

*Verilog*

Background
------------

I designed and implemented a 4 bit processor that has a total of 4 registers, ALU, PC Counter, ROM, and an ALU. The given operations and the instruction encoding is below. To load or store bits within a register, select the register by having the encoding Rx or Ry bits {00,..,11}.

Possible Operations
------------

```
|   Operation   | Function performed | Instruction Encoding |
|:-------------:|--------------------|----------------------|
| Load Rx,Data  | Rx ← Data          | 00,Rx,Data           |
| Store Rx,Data | LEDs ← [Rx]        | 01,Rx,XXX            |
| Move Rx,Ry    | Rx ← [Ry]          | 10,Rx,Ry,X           |
| Add Rx,Ry     | Rx ← [Rx] + [Ry]   | 11,Rx,Ry,00          |
| Sub Rx,Ry     | Rx ← [Rx]−[Ry]     | 11,Rx,Ry,01          |
| And Rx,Ry     | Rx ← [Rx] & [Ry]   | 11,Rx,Ry,10          |
| Not Rx,Ry     | Rx ← ![Rx]         | 11,Rx,XX,11          |

```

