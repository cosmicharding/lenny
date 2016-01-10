
int images = 18;
int frames = 3;
int skip = ((images-frames)/(frames-1))+1;
String imgFile2 = "0";
String img;
PImage imgs[] = new PImage[frames];
PImage imgsLarge[] = new PImage[frames];
String imgFile[] = {"data/large/",imgFile2, ".jpg"};

int centermouse;
int croptopx;
int croptopy;
int cropwidth;

int value = 0;
String slicenum ="";
String slicearray[] = {"data/slice", slicenum, ".tif"};
String slice;
float mouse;
PImage[] crop = new PImage[frames];
int[] cropArray = new int[frames];
int cropx;
float cropwidthLarge;
int cropheightLarge;
int cropwidthLargeInt;


//USER INPUT VARS
String IMAGES_FOLDER = "large"; 
int FRAME_COUNT = 3;

ImgStack imgStack; 
int[] staged; 

void setup() {
  size(displayWidth, displayHeight);
  imgStack = new ImgStack(IMAGES_FOLDER);
  staged = getActiveImages(imgStack.totalImgs, FRAME_COUNT);
}

void draw() {
  background(0);

  imageMode(CENTER);
  for (int i=0; i < FRAME_COUNT; i++){
    pushMatrix();
      translate(width/2, height/2);
      int displacementToCenter = mouseX-width/2;
      //xLoc = (mouseDisplacement * imgNum / spaces between images) + shift to center - image's center 
      int xLoc = displacementToCenter*i / (FRAME_COUNT-1); // 
      int opac = 255/(i+1); //why? 
      tint(255, opac);  // Display at partial opacity
      image(imgStack.get(staged[i]), xLoc, 0);
    popMatrix();

    if (displacementToCenter>0){
      croptopx= mouseX - imgStack.get(staged[i]).width/2;
      cropwidth = ((width/2)+imgStack.get(staged[i]).width/2)-croptopx;
    }
    if (displacementToCenter<=0){
      croptopx = width/2-imgStack.get(staged[i]).width/2;
      cropwidth = (mouseX+imgStack.get(staged[i]).width/2)-croptopx;
    }

    //Draw masks
    tint(255,255);
    fill(255);
    noStroke();
    rect(0,0,croptopx, displayHeight);  
    rect(croptopx + cropwidth, 0, displayWidth-(croptopx + cropwidth), displayHeight);  

    cropx = croptopx - (i * displacementToCenter/(FRAME_COUNT-1));
    cropx = cropx-(width-imgStack.get(staged[i]).width)/2;
    cropArray[i] = cropx;
  }
  
}


// void mouseClicked() {
//   value=1;
//   clear();
//   delay(1000);
//   for (int i=0; i<frames; i++){ 
//   slicenum=nf(i+1);
//   slicearray[1]=slicenum;
//   slice = join(slicearray,"");
//   String path = savePath(slice);
//   //crop[i].save(path);
//   imgFile2 = nf((i+1)*skip);
//   imgFile[1] = imgFile2;
//   img = join(imgFile,"");
//   imgsLarge[i] = loadImage(img);
//   cropwidthLarge = (1.0 * cropwidth/imgs[i].width*imgsLarge[i].width);
//   cropheightLarge = imgsLarge[i].height;
//   cropArray[i] = cropArray[i] * imgsLarge[i].width/imgs[i].width;
//   println(cropArray[i]);
//   cropwidthLargeInt=int(cropwidthLarge);
//   crop[i]=imgsLarge[i].get(cropArray[i],croptopy,cropwidthLargeInt,cropheightLarge);
//   crop[i].save(path);
//   }
// }







//PARALLAX HELPER CLASSES
//---------------------------------

//Returns an int[] of the array indices of staged images
int[] getActiveImages(int totalImages, int totalFrames){
  //Assumes max variance between frames is desired. 
  //So first frame should be 0-th image, last frame n-th image of n-size array
  //then (totalFrames - 2) images will be picked from the remaining images in the array

  if(totalFrames > 1 && totalFrames <= totalImages){ 
    int[] stagedImgs = new int[totalFrames]; 
    stagedImgs[0] = 0; 
    stagedImgs[totalFrames-1] = totalImages - 1; 
    int skip = (totalImages - 2) / (totalFrames - 1); //Rounded-down number of images to skip
    for(int i = 0; i < totalFrames - 2; i++){
      stagedImgs[i+1] = (i + 1) * skip; 
    }
    println("Staged images: ");
    for(int x : stagedImgs){
      print(x + ", ");
    }
    return stagedImgs;

  } else {
    throw new ArrayIndexOutOfBoundsException( "Unable to render " + totalFrames + " frames from image array of size " + totalImages);
  }
}