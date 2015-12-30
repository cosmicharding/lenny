float offset = 0;
int images = 18;
int frames = 5;
int skip;

// Vars: File Names
String imgFile2 = "0";
String img;
PImage imgs[] = new PImage[frames];
PImage imgsLarge[] = new PImage[frames];
String imgFile[] = {"data/large/",imgFile2, ".jpg"};


int opac;
int centermouse;
int croptopx;
int croptopy;
int cropwidth;
int cropheight;


color stroke = color(255, 0 , 0); //AmbiVar
int value = 0;//AmbiVar

String slicenum ="";
String slicearray[] = {"data/slice", slicenum, ".tif"};
String slice;

float mouse;//AmbiVar
PImage[] crop = new PImage[frames];
int[] cropArray = new int[frames];
int cropx;
float cropwidthLarge;
int cropheightLarge;
int cropwidthLargeInt;

void setup() {
  size(displayWidth, displayHeight);

  skip=images/frames; //skip = 18/5 = 3

  //Loads frame 3, 6, 9, 12, 15 into imgs[]
  for (int i=0; i<frames; i++){
   imgFile2 = nf((i+1)*skip);
   imgFile[1] = imgFile2;
   img = join(imgFile,"");
   imgs[i] = loadImage(img);
  }
}

void draw() {
  background(0,0,0,255);

  for (int i=0; i < frames; i++){

    centermouse = mouseX-width/2; //mouse position relative to canvas center
    mouse = centermouse*i/(frames-1) + width/2 - imgs[i].width/2; //image axis offset
    opac = 255/(i+1);
    tint(255, opac);  // Display at partial opacity
    image(imgs[i], mouse, 0);
    //filter(INVERT); // helpful?
    imgs[i].resize(0,height); //make dynamic with stroke? //resize in construction, not in draw loop
    
    //Calculate crop box
    croptopy=0;
    cropwidth=0;
    cropheight=imgs[i].height;
    if (centermouse>0){
      croptopx= mouseX- imgs[i].width/2;
      cropwidth = ((width/2)+imgs[i].width/2)-croptopx;
    }
    if (centermouse<=0){
      croptopx = width/2-imgs[i].width/2;
      cropwidth = (mouseX+imgs[i].width/2)-croptopx;
    }
    fill(255,255,255,0);
    stroke(stroke);
    strokeWeight(2);
    rect(croptopx-2, croptopy-2, cropwidth+4, cropheight+4);  
    cropx = croptopx - (i * centermouse/(frames-1));
    cropx = cropx-(width-imgs[i].width)/2;
    //crop[i]=imgs[i].get(cropx,croptopy,cropwidth, cropheight);
    cropArray[i] = cropx;
  }
}


void mouseClicked() {
  stroke = color(0,255,0); //Setting stroke to Green?
  value=1; //AmbiVar
  clear();
  delay(1000); //why? 


  for (int i=0; i<frames; i++){

    //Create export file name  
    slicenum=nf(i+1);
    slicearray[1]=slicenum;
    slice = join(slicearray,"");
    String path = savePath(slice);
    //crop[i].save(path);

    //Load full size image into imgsLarge array
    imgFile2 = nf((i+1)*skip);
    imgFile[1] = imgFile2;
    img = join(imgFile,"");
    imgsLarge[i] = loadImage(img);

    //Calculate crop factor
    cropwidthLarge = (1.0 * cropwidth/imgs[i].width*imgsLarge[i].width);
    cropheightLarge = imgsLarge[i].height;
    cropArray[i] = cropArray[i] * imgsLarge[i].width/imgs[i].width;
    println(cropArray[i]);
    cropwidthLargeInt=int(cropwidthLarge);

    //Crop
    crop[i]=imgsLarge[i].get(cropArray[i],croptopy,cropwidthLargeInt,cropheightLarge);
    
    //Export
    crop[i].save(path);
  }
}