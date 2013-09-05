/*

                    P r o c e s s i n g   G o r i l l a s

                                 Gorilla.PDE
                          Copyleft Ureka Studio 2013
                          
 A B O U T
 =========
 Really crappy Gorilla.BAS port for Processing 2.
 I will try to minimize the use of libraries, so to avoid deprecated
 dependencies.
 I will use J
 Box2D to simulate physics, since I only have two days 
 to develop this game.
 David Chang
 @DavidFernandoC

 Based on The Nature of Code Box2D Examples
 <http://www.shiffman.net/teaching/nature>
 
 T H E   G A M E 
 ===============

 Your mission is to hit your opponent with the exploding banana
 by varying the angle and power of your throw, taking into account
 wind speed, gravity, and the city skyline.
 Each player takes their turn in trying to hit the other gorilla.

 To control Gorilla, use up and down arrows during each turn.
 To launch a banana, press spacebar.
 
 To exit, press X.

 To get help on a BASIC keyword, move the cursor to the keyword and press
 F1 or click the right mouse button.


*/

import pbox2d.*;
import org.jbox2d.common.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.dynamics.*;





// A reference to our box2d world
PBox2D box2d;

PFont f;

int elapsedDraws = 0;


// A list to track fixed objects
ArrayList<Building> buildings;
// A list for all gorillas
ArrayList<Gorilla> gorillas;
// A list for all bananas
ArrayList<Banana> bananas;

Sun sunBody;
int sunWidth = 80;

boolean P1turn = true;
boolean P1wins = true;

float P1angle = 45;
float P2angle = 45;

float P1velocity = 30;
float P2velocity = 30;


Vec2 impulse; 

boolean playOrderInVelocity = true; //true: Players setting velocity, false: Players setting angle


// An object to store information about the floor surface
Surface terrain;

int FnRan(int x){
  return (int)(random(1,x));
}

void createBuildings(int citySlope) //
{  

  
  int minBldgW = 100;
  int maxBldgW = 110;
  
  int maxBldgH = (int) (height * 0.6);
  int minBldgH = 50;
  
  int lastWidth = 0;
  int lastHeight = 0;
  int iteration = 0;
  
  int normalizedX = 0;
  int normalizedY = 0;
  
  int newHeight = 130;
  int maxVariation = 90;
  
  for (int widthDrawn = -2; widthDrawn < width ;  widthDrawn = widthDrawn + lastWidth ){
    
    lastWidth = (int)random (minBldgW, maxBldgW);
    lastHeight = (int)random (minBldgH, maxBldgH);
    normalizedX = widthDrawn + (lastWidth/2);
    normalizedY = (height-lastHeight) +(lastHeight/2);
        
    buildings.add(new Building(normalizedX, normalizedY, lastWidth, lastHeight, 0));
    
  }
  
  
  /* 
  
  switch(citySlope){
    case 0: //Upward slope
        
        break;
    case 1:  //Downward slope
        NewHeight = map(130,  0,130,  minY,maxY);
        break;
    case 2: case 3: case 4: //Inverted "V" slope
        NewHeight = map(15,  0,130,  minY,maxY);
        break;
    case 5:  //"V" slope - most common
        NewHeight = map(130,  0,130,  minY,maxY);
        break;  
    case default: //"V" slope - most common
        NewHeight = map(130,  0,130,  minY,maxY);
        break;
  }
  
  
  
  
  
  
  
  
 
  int numberOfBuildings = (int) random (6,13);
  int BottomLine = 335;  //Bottom of building
  int DefaultBuildingWidth = 100; //default building height
  int RandomHeight = 200;  //random height difference
  int BuildingWidth = 0;
  int BuildingHeight = 0;
  
  int WindowWidth = 9;
  int WindowHeight = 18;
  int WindowMarginV = 45;
  int WindowMarginH = 30;
  
  int CurrentBuilding = 1;
  
  int HeightIncrement = 30; // Building Height increment
  int NewHeight = height*30;
  
    switch(citySlope){
    case 1: //Upward slope
        NewHeight = map(130,  0,130,  minY,maxY);
        break;
    case 2:  //Downward slope
        NewHeight = map(130,  0,130,  minY,maxY);
        break;
    case 3: case 4: case 5: //Inverted "V" slope
        NewHeight = map(15,  0,130,  minY,maxY);
        break;
    case 6:  //"V" slope - most common
        NewHeight = map(130,  0,130,  minY,maxY);
        break;  
    case default: //"V" slope - most common
        NewHeight = map(130,  0,130,  minY,maxY);
        break;
    
  }
  
 */
  
}


void createGorillas(){
  
  float GorillaW = 60;
  
  float Gorilla1x = map (5, 0,100, 0,width);
  float Gorilla1y = map (30, 0,100, 0,height);

  float Gorilla2x = map (95, 0,100, 0,width);
  float Gorilla2y = map (30, 0,100, 0,height);
  
  gorillas.add(new Gorilla(Gorilla1x,Gorilla1y,GorillaW,true)); //player 1
  
  gorillas.add(new Gorilla(Gorilla2x,Gorilla2y,GorillaW, false)); //player 2
}

void setup() {
  size(800, 600);
  smooth();

  
  f = createFont("8bitoperator.ttf",11,true); // Arial, 11 point, anti-aliasing on
  
  box2d = new PBox2D(this);
  box2d.createWorld();
  
  // Add a listener to listen for collisions!
  box2d.world.setContactListener(new CustomListener());
  
  box2d.setGravity(0, -30);
    
  buildings = new ArrayList<Building>();
  gorillas = new ArrayList<Gorilla>();
  bananas = new ArrayList<Banana>();
  
  sunBody = new Sun (sunWidth);
  
  // Create the floor
  terrain = new Surface();
  
  

  createBuildings((int)random(0,5));
  
  createGorillas();



//  PolygonShape ps = new PolygonShape();



}

void gorillaVictoryDance(){
	  
	  textFont(f,22);
	  fill(255);
	  if (P1wins){
	    text("P L A Y E R   1   W I N S ! !",70,40);
	    if (elapsedDraws<50)
	    	gorillas.get(0).selectImage(2);
	    else{
	    	gorillas.get(0).selectImage(3);
	    	elapsedDraws =0;
	    }
	  }
	  else{
	    text("P L A Y E R   2   W I N S ! !",70,40);
	    if (elapsedDraws<50)
	    	gorillas.get(1).selectImage(2);
	    else{
	    	gorillas.get(1).selectImage(3);
	    	elapsedDraws =0;
	    }
	  }
	  elapsedDraws++;

  
}

 
void draw() {
  
  box2d.step();
  
  background(210,130,250);
  
  terrain.display();
  
   sunBody.display();
  
  // Display all the buildings
  for (Building city: buildings) {
    city.display();
  }

  // Display all the gorillas
  for (Gorilla kongs: gorillas) {
    kongs.display();
  }
  
 // Look at all bananas
  for (int i = bananas.size()-1; i >= 0; i--) {
    Banana b = bananas.get(i);
    b.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (b.done()) {
      bananas.remove(i);
    }
  }
  
 if (gorillas.get(1).hitPoints <=0){
 	 P1wins = true;
     gorillaVictoryDance();
 }
 else if (gorillas.get(0).hitPoints <=0){
 	 P1wins = false;
     gorillaVictoryDance();
 }
 else{
    displayTurn();
    displayStats();   
 }

    

      
}

void displayTurn(){
  textFont(f,22);
  fill(255);
  if (P1turn)
    text("Player 1's turn",10,40);
  else
    text("Player 2's turn",10,40);
}

void displayStats(){
  textFont(f,16);
  fill(255);  
  if (P1turn){
    if (playOrderInVelocity)
    {
        fill(100);
        text("Velocity: " + P1velocity + " <<",10,60);
        fill(255,255,255,200);
        text("Angle: " + P1angle,10,80);
    }
    else
    {
        fill(255,255,255,200);
        text("Velocity: " + P1velocity,10,60);
        fill(100);
        text("Angle: " + P1angle + " <<",10,80);
    }
    
  }
  else
  {
    if (playOrderInVelocity)
    {
        fill(100);
        text("Velocity: " + P2velocity + " <<",10,60);
        fill(255,255,255,200);
        text("Angle: " + P2angle,10,80);
    }
    else
    {
        fill(255,255,255,200);
        text("Velocity: " + P2velocity,10,60);
        fill(100);
        text("Angle: " + P2angle + " <<",10,80);
    }
  }
  textFont(f,12);
  fill(255,255,255,150);
  text("How to play: Adjust with UP/DN, confirm with ENTER.",10,15);
}






void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      
        if (P1turn){
          if (playOrderInVelocity){
              P1velocity ++;              
          }
          else{
              P1angle ++;
          }
          
        }
        else
        {
          if (playOrderInVelocity){
              P2velocity ++;              
          }
          else{
              P2angle ++;
          }
        }
      
      
      
    } else if (keyCode == DOWN) {
      
      
      if (P1turn){
          if (playOrderInVelocity){
              P1velocity --;              
          }
          else{
              P1angle --;
          }
          
        }
        else
        {
          if (playOrderInVelocity){
              P2velocity --;              
          }
          else{
              P2angle --;
          }
        }

    } 
  } else if (keyCode == ENTER) {
    
        if (P1turn){
          if (playOrderInVelocity){
              gorillas.get(0).selectImage(1);
              playOrderInVelocity = false;              
          }
          else{
              playOrderInVelocity = true;
              Banana b = new Banana(gorillas.get(0).x+10,gorillas.get(0).y);
              b.launchBanana(P1velocity,radians(P1angle));
              bananas.add(b);
              gorillas.get(0).selectImage(3);
              
              P1turn = false;
          }
          
        }
        else
        {
          if (playOrderInVelocity){
              gorillas.get(1).selectImage(2);
              playOrderInVelocity = false;              
          }
          else{
              playOrderInVelocity = true;
              Banana b = new Banana(gorillas.get(1).x-70,gorillas.get(1).y);
              b.launchBanana(P2velocity,-radians(P2angle+180));
              bananas.add(b);
              gorillas.get(1).selectImage(4);
              
              P1turn = true;
          }
        }
    
  }
}


