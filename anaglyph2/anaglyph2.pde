int images = 18; //total images
int frames = 2; //images to be used
int adjust = 8; //adjustment of disparity between R and L images
int offset = 0; //selection between different stereo pairs
int skip = ((images-frames)/(frames-1))+1;

int refresh = 0;
String imgFile2 = "0";
String img;
PImage imgs[] = new PImage[images];
PImage imgsLarge[] = new PImage[images];
String imgFile[] = {"data/large/",imgFile2, ".jpg"};
int opac;
int centermouse;
int croptopx;
int croptopy;
int cropwidth;
int cropheight;

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

void setup() {
  size(displayWidth, displayHeight);
      for (int i=0; i<images; i++){
       imgFile2 = nf(1+i);
       imgFile[1] = imgFile2;
       img = join(imgFile,"");
       imgs[i] = loadImage(img);
       println(imgFile2);
      }

}

void draw() {
      if (adjust >= skip && refresh == 0){ //disallow narrowing of disparity of stereo pairs below 1 frame
    skip=1;
  }
  if (adjust < skip && refresh == 0){
  skip=skip-adjust; 
 }
 if (1+offset+((frames-1)*skip) >= images && refresh == 0){ //failsafe for stereo pairs out of bounds
  offset = images-((frames-1)*skip)-1;
}
refresh = 1;
  background(0,0,0,255);
      blendMode(SCREEN);
  for (int i=0; i < frames; i++){
    int count = offset + (skip*i);
    println(count);
    centermouse = mouseX-width/2;
    mouse = centermouse*i/(frames-1)+width/2-imgs[count].width/2;
    opac = 255/(i+1);
    //tint(255, opac);  // Display at partial opacity
    image(imgs[count], mouse, 0);
    if (i==0){
      tint(0, 255, 255);
    }
    else{
      tint(255, 0, 0);
    }
    imgs[count].resize(0,height); //make dynamic with stroke?
    croptopy=0;
    cropwidth=0;
    cropheight=imgs[count].height;
    if (centermouse>0){
      croptopx= mouseX- imgs[count].width/2;
      cropwidth = ((width/2)+imgs[count].width/2)-croptopx;
  }
    if (centermouse<=0){
      croptopx = width/2-imgs[count].width/2;
      cropwidth = (mouseX+imgs[count].width/2)-croptopx;
    }
    fill(255,255,255);
    rect(0,0,croptopx, displayHeight);  
    rect(croptopx + cropwidth, 0, displayWidth-(croptopx + cropwidth), displayHeight);  
cropx = croptopx - (i * centermouse/(frames-1));
cropx = cropx-(width-imgs[count].width)/2;
//crop[i]=imgs[i].get(cropx,croptopy,cropwidth, cropheight);
cropArray[i] = cropx;
  }
}
void mouseClicked() {

  value=1;
  clear();
  delay(1000);
  for (int i=0; i<frames; i++){ 
  slicenum=nf(i+1);
  slicearray[1]=slicenum;
  slice = join(slicearray,"");
  String path = savePath(slice);
  //crop[i].save(path);
  imgFile2 = nf((i+1)*skip);
  imgFile[1] = imgFile2;
  img = join(imgFile,"");
  imgsLarge[i] = loadImage(img);
  cropwidthLarge = (1.0 * cropwidth/imgs[i].width*imgsLarge[i].width);
  cropheightLarge = imgsLarge[i].height;
  cropArray[i] = cropArray[i] * imgsLarge[i].width/imgs[i].width;
  println(cropArray[i]);
  cropwidthLargeInt=int(cropwidthLarge);
  crop[i]=imgsLarge[i].get(cropArray[i],croptopy,cropwidthLargeInt,cropheightLarge);
  crop[i].save(path);
  }
}