
//USER INPUT VARS
String IMAGES_FOLDER = "large"; 
int FRAME_COUNT = 6; // 17 for 18 images FIX

ImgStack imgStack; 
int[] staged; 


void setup() {
  size(displayWidth, displayHeight);
  imgStack = new ImgStack(IMAGES_FOLDER);
  staged = getStagedImages(imgStack.totalImgs, FRAME_COUNT);
}

void draw() {
  background(0);

  imageMode(CENTER);
  for (int i=0; i < FRAME_COUNT; i++){
    pushMatrix();
      translate(width/2, height/2);
      int xOffset = mouseX-width/2;
      int xLoc = xOffset*i / (FRAME_COUNT-1); // 
      int opac = 255/(i+1);//Why not even opac for all? 
      tint(255, opac);  // Display at partial opacity
      image(imgStack.get(staged[i]), xLoc, 0);
    popMatrix();
  }


  //Draw Masks
  int cropLeft, cropWidth, cropRight; 
  if (mouseX > width/2){
    cropLeft = mouseX - imgStack.width/2;
    cropRight = width/2+imgStack.width/2;
    cropWidth = ((width/2)+imgStack.width/2)-cropLeft;
  } else {
    cropLeft = width/2-imgStack.width/2;
    cropRight = mouseX+imgStack.width/2;
    cropWidth = (mouseX+imgStack.width/2)-cropLeft;
  }

  tint(255,255);
  fill(255);
  noStroke();
  rect(0,0,cropLeft, displayHeight); //Left Mask 
  rect(cropRight, 0, displayWidth, displayHeight);  //Right mask  
}


//Exports fullres on click
void mouseClicked() {
  float scale = imgStack.scale;
  println("scale: " + scale);

  //Calculated scaled offset values 
  int xOffset =  Math.round( (mouseX-width/2) * scale);
  int[] xLocs = new int[FRAME_COUNT];
  int[] xLocsSmall = new int[FRAME_COUNT]; 

  for(int i = 0; i < FRAME_COUNT; i++){
    xLocs[i] = xOffset*i / (FRAME_COUNT-1);
    xLocsSmall[i] = (mouseX-width/2)*i / (FRAME_COUNT-1);
  }

  println("xLocs BIG: ");
  for(int i : xLocs ){
    print(i + ", ");
  }
  println("\nxLocs SMALL: ");
  for(int i : xLocsSmall ){
    print(i + ", ");
  }

  println();
  //Calculate export area 
  //export width is calculated based on the position of the last staged image
  int exportW = (imgStack.fullWidth - abs(xLocs[FRAME_COUNT-1]));
  int exportH = imgStack.fullHeight;

  PGraphics exportCanvas = createGraphics(exportW, imgStack.fullHeight);
  exportCanvas.beginDraw();  
  exportCanvas.imageMode(CORNER);
  //exportCanvas.translate(exportCanvas.width/2, exportCanvas.height/2);
  exportCanvas.translate(-xLocs[FRAME_COUNT-1], 0);
  for(int i = 0; i < FRAME_COUNT; i++){
    exportCanvas.clear();
    exportCanvas.background(255);
    exportCanvas.image(imgStack.getBig(staged[i]), xLocs[i], 0);
    String sn = String.format("%03d", i);
    exportCanvas.save("./exports/export_" + sn + ".jpg");
    println("EXPORTED: export_" + sn + ".jpg");
  }
  exportCanvas.endDraw();

}





