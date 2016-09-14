float increment = 0.01;
// The noise function's 3rd argument, a global variable that increments once per cycle
float zoff = 0.0;  
// We will increment zoff differently than xoff and yoff
float zincrement = 0.008; 

void setup() {
  size(960, 960);
  frameRate(30);
}

void draw() {
  background(255);
  // Optional: adjust noise detail here
  // noiseDetail(8,0.65f)

  loadPixels();

  float xoff = 0.0; // Start xoff at 0

  // For every x,y coordinate in a 2D space, calculate a noise value and produce a brightness value
  for (int x = 0; x < width/2; x++) {
    xoff += increment;   // Increment xoff 
    float yoff = 0.0;   // For every xoff, start yoff at 0
    for (int y = 0; y < height; y++) {
      yoff += increment; // Increment yoff

      // Calculate noise and scale by 255
      float bright = noise(xoff, yoff, zoff)*255;

      if (bright > 120) {
        bright = 255;
      } else {
        bright = 0;
      }

      // distance from center
      float distFromCenter = dist(width/2, width/2, x, y);

      if (distFromCenter < 400) {
        // Set each pixel onscreen to a grayscale value
        pixels[x+y*width] = color(bright, bright, bright);

        // create the reflected pixel
        int flippedXPos = width - x - 1; 
        int loc = (y*width) + flippedXPos;
        pixels[loc] = color(bright, bright, bright);
      }
    }
  }
  updatePixels();

  zoff += zincrement; // Increment zoff
}