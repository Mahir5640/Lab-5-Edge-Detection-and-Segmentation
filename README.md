# Lab 5 — Edge Detection and Segmentation

**Mahir Foysol Chowdhury**  
Mathematical Algorithms (DSP) — Image Processing Labs

## How to run

Open `lab5_edge_segmentation.m` in MATLAB with Image Processing Toolbox
and click Run. The script exports five figures to `screenshots/` and
prints the Otsu threshold and the number of connected foreground regions.

## 1. Sobel and Prewitt edge detection

Edges occur where image intensity changes rapidly over a short distance.
These sharp changes contribute high spatial frequencies. Sobel and
Prewitt estimate horizontal and vertical intensity gradients. Strong
gradient responses indicate likely edges. Sobel places more weight on
the central row or column of its derivative kernel, while Prewitt uses
uniform weights along the smoothing direction.

![Grayscale input and the Sobel and Prewitt edge maps](screenshots/01-sobel-prewitt.png)

## 2. Canny edge detection

Canny first smooths the image to reduce noise and then estimates its
gradients. Non-maximum suppression keeps local gradient peaks and
produces thin edge traces. The detector uses thresholds of 0.05 and
0.20. Hysteresis keeps strong edge pixels and retains weaker edge
pixels when they connect to strong ones.

![Grayscale input and Canny edge map](screenshots/02-canny.png)

## 3. Laplacian of Gaussian

The Laplacian of Gaussian smooths the image and measures second-order
intensity changes. It looks for zero crossings, where the filtered
response changes sign. These crossings indicate possible edge locations.
The figure compares the LoG edge map directly with the Canny map.

![Canny and Laplacian of Gaussian edge maps](screenshots/03-log.png)

## 4. Otsu thresholding

Otsu's method computes a global threshold from the grayscale image
histogram. It chooses the threshold that maximizes the separation
between two intensity classes, measured by their between-class
variance. Pixels above the threshold become white foreground, and
the other pixels become black background. Foreground in this mask
represents brighter areas, so a pepper can contain both classes.

![Original grayscale image and Otsu binary mask](screenshots/04-otsu-mask.png)

## 5. Connected-region labeling

I labeled the white pixels in the Otsu mask using 8-connectivity.
Pixels can belong to the same region when they touch along a side or
diagonally. Each connected component receives a label, and the color
figure makes the labeled regions easier to distinguish. The reported
count measures connected foreground regions. A single pepper can
contain several separate bright regions.

![Otsu mask and color-coded connected regions](screenshots/05-labeled-regions.png)

## 6. Reflections

1. **Which operator gives the thinnest, cleanest edges?**  
   Canny is expected to give the thinnest, cleanest contours in this
   comparison. Non-maximum suppression thins edge responses, and
   hysteresis helps preserve connected contours while discarding
   isolated weak responses.

2. **Why can Canny outperform simple gradient filters?**  
   Sobel and Prewitt estimate where intensity changes quickly. Canny
   combines gradient estimation with smoothing, edge thinning, and
   two-threshold hysteresis. Together, these stages help reduce
   noise-related detections and keep weak parts of strong contours.

3. **How does Otsu relate to histogram-based thresholding?**  
   Otsu tests possible splits of the intensity histogram and selects
   the split that maximizes the variance between the two classes.
   It works best when the foreground and background occupy
   distinguishable intensity ranges.
