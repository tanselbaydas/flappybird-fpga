# flappybird-fpga

**Description of the Game**

The original Flappy Bird game aims to pass the coming obstacles by bouncing the bird. This project implements a redesigned Flappy Bird game with FPGA implementation on the
VGA driver. The difference between the project and the original game is about motion features and the playing style of the game. In the original game, the obstacles are coming
towards the bird, and the bird jumps up to and then falls in to pass the obstacles. In our redesigned version of the game, the bird can go up down right left with 4 input buttons 
while obstacles are stable. If the user can direct the bird until the endpoint, the game ends and the user wins it.

**How to Use**

Create a bit file using "topdesign.vhd" and "constraintsforlab7.ucf" and "Nexys3_master.ucf" files. With this file, you can play the game on a Nexys FPGA board. 


This project is made for "Digital System Design" course at Bogazici Electrical&Electronics Engineering Department in Spring 2022.
