# Processing
## ColorCircles
Draws an image of circles first, colored using gradients. Then, it uses a mask image (also drawn) to mask out most of the circles, cutting down on visual noise.
### Controls
* Change size of mask circles: Left (smaller) and right (larger)
* Change size of background circles: Up (larger) and down (smaller)
* Move mask circles: w (up) and s (down)
* Change amount of rows for mask circles: a (less) and d (more)
* Save image: i

### To-Do:
* Use better colors(?) (use harmonic colors)
* Make it look artistic...
* Clean up code
* Better center the mask circles when changing the amount of rows
* Better determine the Nr. of mask circles to draw regarding the size of the image (never clipped)

## SubCircles
Draws iterations of circles within each other, each iteration tinted differently.
### Controls
* Change amount of passes: Left and right
* Change amount of starting circles: Up and down
* Random colors: c
* Save image: i
* Reset: r

## EndlessRectangles
Draws rectangles within the rectangles drawn earlier... Math somehow doesn't add up so initial rotation not working.
### Controls
* Change position: Left, right, up and down
* Change amount of rectangles: a and d
* Change size of initial rectangle: w and s
* Toggle outline: o
* Save image: i
* Random colors: c
