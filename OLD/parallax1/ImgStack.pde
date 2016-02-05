import java.io.*; 

/*----------------------
ImgStack 

Stores all images within a folder as an array of PImages. 
Default folder is "data". 
Contains screen-res array for preview rendering and original-resolution
images for printing. 
----------------------*/
public class ImgStack {
	int totalImg; 
	ArrayList<PImage> smallImgs; 
	ArrayList<PImage> fullResImgs; 
	String inputFolderPath = "data"; 



	private void loadImages(String path){
		
		File file = new File(path);
		File[] files = file.listFiles();

		println("path: " + path);
		//println("# of files: " + files.length);

		//Load PImages arrayList
		fullResImgs = new ArrayList<PImage>();
		for (File f : files){
			PImage img = loadImage( path + "/" + f.getName());
			fullResImgs.add(img);
			println(f.getName());
		}
		println("Total images loaded: " + fullResImgs.size());
	}
}