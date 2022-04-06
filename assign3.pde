final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
final int HOG_IDLE=0,HOG_DOWN=1,HOG_LEFT=2,HOG_RIGHT=3;
int hogX,hogY,Block=80;
int hogState, gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soilA, soilB, soilC, soilD, soilE,  soilF, stoneA, stoneB;
PImage cabbage, soldier, hogDown, hog, hogLeft, hogRight, life;

// For debug function; DO NOT edit or remove this!
int YY =-80;
int playerHealth = 2;
int timer;
int stoneCount = 8 ;
float spacing = 80 ;
float stoneX =0 ,stoneY = 0; 
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");

  soilA = loadImage("img/soil0.png");
  soilB = loadImage("img/soil1.png");
  soilC = loadImage("img/soil2.png");
  soilD = loadImage("img/soil3.png");
  soilE = loadImage("img/soil4.png");
  soilF = loadImage("img/soil5.png");
  stoneA = loadImage("img/stone1.png");
  stoneB = loadImage("img/stone2.png");
  
  life = loadImage("img/life.png");
  hog = loadImage("img/groundhogIdle.png");
  hogDown = loadImage("img/groundhogDown.png");
  hogRight = loadImage("img/groundhogRight.png");
  hogLeft = loadImage("img/groundhogLeft.png");
  hogX=4*Block;
  hogY=Block;
  YY=0;
}

void draw() {
    /* ------ Debug Function ------ 

      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.

    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */

    
  switch (gameState) {

    case GAME_START: // Start Screen
    image(title, 0, 0);

    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }

    }else{

      image(startNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;

    case GAME_RUN: // In-Game
    if(YY>-(20*80)){
      hogY=80;} //GROUND MOVE.HOG STOP
    if(YY<-(20*80)){
      YY=20*80;}//GROUND STOP    
    if(hogY>80){
      YY=-(20*80);}//HOG MOVE.GROUND STOP
    // Background
    image(bg, 0, 0);

    // Sun
    stroke(255,255,0);
    strokeWeight(5);
    fill(253,184,19);
    ellipse(590,50,120,120);

    pushMatrix(); 
    translate(0,YY );
    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

   //  SoilA
    for ( int x=0; x<=8 ; x++ ) {
      for ( int a=0; a<=3 ; a++ ) {
      image(soilA, x*80, 160+a*80);}
    }
   //SoilB
    for ( int x=0; x<=8 ; x++ ) {
      for ( int b=4; b<=7 ; b++ ) {
      image(soilB, x*80, 160+b*80);}
    }
    //SoilC
    for ( int x=0; x<=8 ; x++ ) {
      for ( int c=8; c<=11 ; c++ ) {
      image(soilC, x*80, 160+c*80);}
    }
    //SoilD
    for ( int x=0; x<=8 ; x++ ) {
      for ( int d=12; d<=15 ; d++ ) {
      image(soilD, x*80, 160+d*80);}
    }  
    //SoilE
    for ( int x=0; x<=8 ; x++ ) {
      for ( int e=16; e<=19 ; e++ ) {
      image(soilE, x*80, 160+e*80);}
    }
    //SoilF
    for ( int x=0; x<=8 ; x++ ) {
      for ( int f=20; f<=23 ; f++ ) {
      image(soilF, x*80, 160+f*80);}
    }
    
    //StoneAB
    for ( int s = 0 ; s <= stoneCount ; s++ ){
      stoneX = s * spacing ;
      image ( stoneA, stoneX-80, 160+stoneY ) ;
      stoneY = s * spacing ;
    }    
    //StoneCD
    for ( int t = 8 ; t >0 ; t-- ){
      stoneX = t * spacing ;
      stoneY += spacing ;
      image ( stoneA, stoneX+80, 80+stoneY ) ;
      image ( stoneA, stoneX-80*3, 80+stoneY ) ;
      image ( stoneA, stoneX-80*7, 80+stoneY ) ;
      image ( stoneA, stoneX+80*5, 80+stoneY ) ;
    }
    for ( int t = 0 ; t <8 ; t++ ){
      stoneX = t * spacing ;
      stoneY += spacing ;
      image ( stoneA, stoneX+80*2, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX+80*6, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX-80*2, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX-80*6, 80+stoneY-320*2 ) ;
    }
    //StoneEF
     for ( int o = 8 ; o >0 ; o-- ){
      stoneX = o * spacing ;
      stoneY += spacing ;
      image ( stoneA, stoneX-80, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX-80*3, 80+stoneY-320*2 ) ;
      image ( stoneB, stoneX-80*3, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX-80*4, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX-80*6, 80+stoneY-320*2 ) ;
      image ( stoneB, stoneX-80*6, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX-80*7, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX+80*2, 80+stoneY-320*2 ) ;
      image ( stoneB, stoneX, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX+80*3, 80+stoneY-320*2 ) ;
      image ( stoneB, stoneX+80*3, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX+80*5, 80+stoneY-320*2 ) ;
      image ( stoneA, stoneX+80*6, 80+stoneY-320*2 ) ;
      image ( stoneB, stoneX+80*6, 80+stoneY-320*2 ) ;
  }
    popMatrix();    
    // Player
    if(timer==15){
          hogState=HOG_IDLE;
          if(hogY%Block<30){
            hogY=hogY-hogY%Block;
          }else{
            hogY=hogY-hogY%Block+Block;
          }
          if(hogX%Block<30){
            hogX=hogX-hogX%Block;
          }else{
            hogX=hogX-hogX%Block+Block;
          }
          println(hogX);
          println(hogY);
          timer=0;
        }
/*    if(hogY>400){
      hogY-=80/15.0;}    */
    //Draw hog
    switch(hogState){
      case HOG_IDLE:
        image(hog,hogX,hogY);
        break;
      case HOG_DOWN:
        image(hogDown,hogX,hogY);
        timer+=1;
        hogY+= 80.0/15;        
        break;
      case HOG_RIGHT:
        image(hogRight,hogX,hogY);
        timer+=1;
        hogX+=80.0/15;
        break;
      case HOG_LEFT:
        image(hogLeft,hogX,hogY);
        timer+=1;
        hogX-=80.0/15;
        break;
        }
    if(timer==15){
          hogState=HOG_IDLE;
          if(hogY%Block<30){//fix float point offset
            hogY=hogY-hogY%Block;
          }else{
            hogY=hogY-hogY%Block+Block;
          }
          if(hogX%Block<30){
            hogX=hogX-hogX%Block;
          }else{
            hogX=hogX-hogX%Block+Block;
          }
          //println(hogX);
          //println(hogY);
          timer=0;
        }     
        
    // Health UI
    for(int i=0;i<playerHealth;i++){
      image(life,10+i*70,10);
    }        
    if(playerHealth==0){
      gameState=GAME_OVER;
    }

    break;

    case GAME_OVER: // Gameover Screen
    image(gameover, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {

      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        playerHealth=2;
        //mousePressed = false;
        // Remember to initialize the game here!
      }
    }else{

      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

    }
    break;
    
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
  // Add your moving input code here

  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){                     
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
      
    }
   if(key ==CODED){
    switch(keyCode){
      case DOWN:
        if(hogY+Block<height&&hogState==HOG_IDLE){
          hogState=HOG_DOWN;
          YY -= 80;
          timer=0;
        }
        break;
      case RIGHT:
        if(hogX+Block<width&&hogState==HOG_IDLE){
          hogState=HOG_RIGHT;
          timer=0;
        }
        break;
      case LEFT:
        if(hogX>0&&hogState==HOG_IDLE){
          hogState=HOG_LEFT;
          timer=0;
        }
        break;
    }
  }
}

void keyReleased(){
}
