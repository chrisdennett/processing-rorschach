class Rorschach {
  float increment = 0.01;
  float zoff = 0.0;  
  float zincrement = 0.03;
  PImage holderImg;

  Rorschach() {
    holderImg = createImage(600, floor(600), PImage.RGB);
  }

  void update(Rectangle boundingBox) {

    //holderImg = createImage(boundingBox.width, boundingBox.height, PImage.RGB);
    //translate(boundingBox.x, boundingBox.y);
    holderImg.loadPixels();

    float xoff = 0.0; // Start xoff at 0

    // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
    for (int x = 0; x < holderImg.width/2; x++) {
      xoff += increment;   // Increment xoff 
      float yoff = 0.0;   // For every xoff, start yoff at 0
      for (int y = 0; y < holderImg.height; y++) {
        yoff += increment; // Increment yoff

        // Calculate noise and scale by 255
        float bright = noise(xoff, yoff, zoff)*255;

        if (bright > 120) {
          bright = 255;
        } else {
          bright = 0;
        }

        // distance from center
        float distFromCenter = 0;
        float centreX = holderImg.width/2;
        float centreY = holderImg.height/2;
        distFromCenter = dist(centreX, centreY, x, y);
        int loc = x+y*holderImg.width;
        int flippedXPos = holderImg.width - x - 1; 
        int flippedLoc = (y*holderImg.width) + flippedXPos;
        int alpha = 255; 

        int alphaStart = 270;

        if (distFromCenter > alphaStart) {
          alpha = floor(map(distFromCenter,alphaStart, 300, 255, 0));
        }
        holderImg.pixels[loc] = color(bright, bright, bright, alpha);
        holderImg.pixels[flippedLoc] = color(bright, bright, bright, alpha);
      }
    }
    holderImg.updatePixels();

    zoff += zincrement; // Increment zoff
  }
}