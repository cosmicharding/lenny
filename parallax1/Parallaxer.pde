import java.io.*; 

public class Parallaxer {
	PImage[] smallImgs; 
	PImage[] fullResImgs; 

	int lenFrames; 
	int totalImages; 

	//File IO vars
	String inputFolderPath; 


	Parallaxer(){
		inputFolderPath = "/data/";
		loadImage(inputFolderPath);
	}

	private void loadImages(String path){
		File folder = new File(path);
		File[] files = folder.listFiles();

		println("path: " + path);
		println("# of files: " + folder.length);

		//Load PImage arrayList
		fullResImgs = new ArrayList<PImage>();
		for (File f : files){
			PImage img = loadImage("data/" + f.getHame());
			PImage smallImg = loadImage("data/" + f.getHame());
			smallImg.resize(0,height);
			fullResImgs.add(img);
			smallImgs.add(smallImg);
			println(f.getName());
		}
		println("Total images loaded :" + fullResImgs.size());
	}

}