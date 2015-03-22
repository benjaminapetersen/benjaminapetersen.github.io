sketch a few approaches.  flex is my favorite, of course


Using flex:

display:flex;align-items:center;



Avoiding flex:

http://zerosixthree.se/vertical-align-anything-with-just-3-lines-of-css/
.element {
  position: relative;
  top: 50%;
  transform: translateY(-50%);
}



Avoiding blurry by setting parent props.  Annoying to fuss with parent, but works!

.parent-element {
  -webkit-transform-style: preserve-3d;
  -moz-transform-style: preserve-3d;
  transform-style: preserve-3d;
}

.element {
  position: relative;
  top: 50%;
  transform: translateY(-50%);
}



