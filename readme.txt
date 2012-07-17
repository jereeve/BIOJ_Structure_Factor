-----------------------------------------
2D Droplet Image Processing 1.2.1
James E. Reeve
06JUL2011
-----------------------------------------

1. 	Currently requires a tiff type image.
2. 	Run 'imageprocessing.fig'.
3. 	Click 'Open File' and select the image to process. The image and its 3D representation are displayed.
4.	Select whether the image was taken with polarisation parallel or perpendicular to the incident light.
5. 	Slide the threshold until you have a perfect circle, or the circle is clearly delineated.
6a.	If you have a perfect circle, click 'Auto Limits'. The centrepoint is displayed.
6b. 	If you don't have a perfect circle, click 'Manual Limits' then click on the image of the circle: 
	Once to bound the top and left portions then again to bound the bottom and right portions.
	The centrepoint is displayed. (Manual Limits may also be taken without thresholding first).
7.	If you want to remove noise from the bilayer region, click 'Remove Segment', then click before and after the noise going clockwise. 
8.	Slide the 'Estimated Max' to your best guess at the maximum value (approx. the top of the axes on the
	surface plot is fine. Better guesses speed up the fitting algorithm.
9. 	Click 'Plot'. 5 plots are added to the surface already displayed (Surface Plot):

	--------------------------------------------
	|     (a)    |	      (b)	|   (c)	   |
	|Surface Plot|Model Surface Plot|Image Plot|
	|	     |			|	   |
	--------------------------------------------
	|     (d)    |	      (e)	|   (f)	   |
	|Angular Plot|    Radial Plot   |Model Plot|
	|	     |			|	   |
	--------------------------------------------

(a)	Surface representation of the image.
(b)	Surface plotted from fitting parameters and function.
(c)	Image.
(d)	Plot of intensity as a function of angle (blue) with the model fit (red).
(e)	Plot of intensity as a function of radius (blue) with the model fit (red).
(f)	Image plotted from fitting parameters and function.

10. 	The fitting parameters have been copied to your clipboard. Paste them into the 'results.xls' file.
11.	The images may be zoomed into by clicking on their axes.
12.	Repeat!

Note: To fit fluorescence, you need to edit fitfun and angfun so that the correct fitting functions are used.

-----------------------------------------
2D Droplet Image Processing
Revision History
-----------------------------------------


1.2.1 	Removed various hardcode relics
	Automatically calculates radius for fitting.
	Commented lines
	Added fit error measurement (needs normalisation)
	Automatically selects bounds for angular and radial plots
1.2	Added general architecture creation allowing any image dimensions
	Removed t.mat	
1.1 	Added perpendicular and parallel models
1.0 	Original surface-plotting version