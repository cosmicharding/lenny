
int images = 18;
int frames = 3;
int skip = ((images-frames)/(frames-1))+1;
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
      for (int i=0; i<frames; i++){
       imgFile2 = nf(1+(i*skip));
       imgFile[1] = imgFile2;
       img = join(imgFile,"");
       imgs[i] = loadImage(img);
       println(imgFile2);
      }
}

void draw() {
  background(0,0,0,255);
  for (int i=0; i < frames; i++){
    centermouse = mouseX-width/2;
    mouse = centermouse*i/(frames-1)+width/2-imgs[i].width/2;
    opac = 255/(i+1);
    tint(255, opac);  // Display at partial opacity
    image(imgs[i], mouse, 0);
//    filter(INVERT); // helpful?
    imgs[i].resize(0,height); //make dynamic with stroke?
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
    fill(255,255,255);
    rect(0,0,croptopx, displayHeight);  
    rect(croptopx + cropwidth, 0, displayWidth-(croptopx + cropwidth), displayHeight);  

cropx = croptopx - (i * centermouse/(frames-1));
cropx = cropx-(width-imgs[i].width)/2;
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