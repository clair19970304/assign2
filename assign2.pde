final int GAME_START1 = 0;
final int GAME_START2 = 1;
final int GAME_PLAYING = 2;
final int GAME_END1 = 3;
final int GAME_END2 = 4;


int health = 0;
int gameState;

final int GO_RIGHT = 0;
final int GO_DOWN = 1;
final int GO_LEFT = 2;
final int GO_UP = 3;

int state = GO_RIGHT;

PImage end1Image, end2Image, start1Image, start2Image;

PImage enemyImage;
PImage fighterImage;
PImage hpImage;
PImage treasureImage;
PImage bg1Image;
PImage bg2Image;

int x1, y1;  // enemy
float x2, y2;  // fighter
float speed = 3;
int x3, y3;  // hp
int x4, y4;  // treasure
int w;  // hp
int x5;  // bg

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;


void setup () {
  size(640,480) ;
  // load images
  start1Image = loadImage("img/start1.png");
  start2Image = loadImage("img/start2.png");
  end1Image = loadImage("img/end1.png");
  end2Image = loadImage("img/end2.png");
  
  // back ground
  bg1Image = loadImage("img/bg1.png"); 
  bg2Image = loadImage("img/bg2.png"); 
  
  // enemy
  x1 = 0;
  y1 = floor(random(420));
  enemyImage = loadImage("img/enemy.png");
  
  //fighter
  x2 = width-51;
  y2 = floor(random(height));
  fighterImage = loadImage("img/fighter.png");
  
  //hp
  x3 = 10;
  y3 = 10;
  hpImage = loadImage("img/hp.png");
  w = 215;
  
  //treasure
  x4 = floor(random(0,width-41));
  y4 = floor(random(0,height-41));
  treasureImage = loadImage("img/treasure.png");
  
  gameState = GAME_START2;
}

void draw() {
  background(0);
  
  switch (gameState){
    case GAME_START2:
     // mouse action
     if (mouseX > 205 && mouseX < 450 && mouseY > 370 && mouseY < 415){
        if (mousePressed){
          // click
          gameState = GAME_PLAYING;
        }else{
          // hover
          gameState = GAME_START1;
        }
     }
     // show message
      image(start2Image,0,0);
      break;
      
    case GAME_START1:

        if (mousePressed){
          // click
          gameState = GAME_PLAYING;
        }else{
          // hover
          gameState = GAME_START2;
        }
     
    image(start1Image,0,0);
    break;
      
    case GAME_PLAYING:
    if (w <= 20){
      gameState = GAME_END2;
    }
  // background
  x5 += 2;
  x5 %= 1280;
  image(bg1Image,x5,0);
  image(bg2Image,-640+x5,0);
  image(bg1Image,-1280+x5,0);
  
  // enemy
  if (x1>width){
    x1 = 0;
    y1 = floor(random(420));
  }
  x1 +=5;
  image(enemyImage,x1,y1);
  
  switch (state){
    case GO_RIGHT:
      x1+=speed;
      if (y1+61 > y2+51){
        state = GO_UP;
      }
      break;
    case GO_DOWN:
      y1+=speed;
      if (y1+61 > y2+102){
        state = GO_UP;
      }
      break;
    case GO_UP:
      y1-=speed;
      if (y1+61 < y2){
        state = GO_DOWN;
      }
      break;   
  }
  
  if (w>20){
    if (x2<=x1+61 && x2>=x1 && y2<=y1+61 && y2>=y1){
      w = w-20;
    }
  }
  if (x2<=x1+61 && x2>=x1 && y2<=y1+61 && y2>=y1){
    x1 = 0;
    y1 = floor(random(height-61));
  }
  
  // fighter
  image(fighterImage,x2,y2);
  if (upPressed) {
    y2 -= speed;
  }
  if (downPressed) {
    y2 += speed;
  }
  if (leftPressed) {
    x2 -= speed;
  }
  if (rightPressed) {
    x2 += speed;
  }
  
  //boundary detection
  if (x2 > width-51){
    x2 = width-51;
  }
  if (x2 < 0){
    x2 = 0;
  }
  if (y2 > height-51){
    y2 = height-51;
  }
  if (y2 < 0){
    y2 = 0;
  }
  
  // hp
  fill(255,0,0);
  stroke(255,0,0);
  rectMode(CORNERS);
  rect(20,15,w,30);
  image(hpImage,x3,y3);
  
  // treasure
  image(treasureImage,x4,y4);
  if (w<215){
    if (x2<=x4+41 && x2>=x4 && y2<=y4+41 && y2>=y4){
      w = w+10;
    }
  }
  if (x2<=x4+41 && x2>=x4 && y2<=y4+41 && y2>=y4){
    x4 = floor(random(width-41));
    y4 = floor(random(height-41));
  }
      
      break;
      
   case GAME_END2:
      // mouse action
     if (mouseX > 210 && mouseX < 430 && mouseY > 310 && mouseY < 350){
        if (mousePressed){
          // click
          gameState = GAME_PLAYING;
        }else{
          // hover
          gameState = GAME_END1;
        }
     }
      // show message
      image(end2Image,0,0);
      w = 215;
      break;
      
      case GAME_END1:
        if (mousePressed){
          // click
          gameState = GAME_PLAYING;
        }else{
          // hover
          gameState = GAME_END2;
        }
     
       image(end1Image,0,0);
       break;
  }
      

}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
