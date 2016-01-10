import java.io.*; 
/*----------------------
ImgStack 

Stores all images within a folder as an array of PImages. 
Default folder is "data". 
Contains screen-res array for preview rendering and original-resolution
images for printing. 
----------------------*/
public class ImgStack {
	int totalImgs; 
	ArrayList<PImage> smallImgs; 
	ArrayList<PImage> fullResImgs; 
	String inputFolderPath = "";

	ImgStack(){
		//DANGER FIX THIS
		inputFolderPath = sketchPath("") + "/data/";
		loadImages(inputFolderPath);
		renderSmallImgs();
	}

	ImgStack(String path){
		inputFolderPath = sketchPath("") + "/" + path + "/"; 
		//this();
		loadImages(inputFolderPath);
		renderSmallImgs();
	}

	private void loadImages(String path){
		
		File file = new File(path);
		File[] files = file.listFiles();

		println(files.length);
		//println("# of files found in \"" + path + "\" folder: " + files.length);

		//Load PImages arrayList
		fullResImgs = new ArrayList<PImage>();
		for (File f : files){
			if(!f.getName().contains("DS_Store")){
				PImage img = loadImage( path + "/" + f.getName());
				fullResImgs.add(img);
				println(f.getName());
				}
		}
		totalImgs = fullResImgs.size(); 
		println("Images successfully loaded: " + fullResImgs.size());
	}

	private void renderSmallImgs(){
		smallImgs = new ArrayList<PImage>();
		for(PImage img : fullResImgs){
			PImage resizedImg = img.copy(); 
			resizedImg.resize(0, height);
			smallImgs.add(resizedImg);
		}
		println("Low res previews successfully generated. ");
	}
}