# Music-Score-Reader (OMR)

Optical music recognition (OMR) has been the subject of research for decades. <br> 
An accessible and easy-to-use OMR application could provide an amazing tool for improving the musical education experience. <br>
For example, a novice musician could use such a tool to hear what a selected piece of music should sound like.

Ideally, an OMR, given an image of a simple or complex music sheet, automatically identifies the notes and plays the musical piece. <br>
For this project, the goal is to develop an algorithm to parse music sheet images, <br>

produce the associated annotation, and implement a playback mechanism for the parsed musical notes. <br>
Also handles the orientated images.

***
## Process Overview
<b> The process is broken down into the following tasks: </b>

**`0. Preparations for the Process`** | **`1. Staff Lines Detection and Removal`** | **`2. Segmentation`** |
| :-----------------------------------: | :-----------------------------------: | :-----------------------------------: |
| <ul><li>Detect the image orientation.</li><li>Remove unwanted margins.</li><li>Getting Number of staves.</li></ul> | <ul><li>Detect the location of all staff lines.</li><li>Remove staff lines.</li><li>Fill in the gaps.</li></ul> | <ul><li>Process row by row.</li><li>Calculate boundaries for each symbol.</li><li>Extract Symbol.</li></ul> |
| **`3. Symbol Recognition`** <br> | **`4. Note Identification`**  | **`5. Music Transformation`** |
| <ul><li>Calculate matching score against training data.</li><li>Minimum score threshold: **74%**.</li><li>Pick a label with a maximum score.</li></ul> | <ul><li>Calculate centre point coordinate.</li><li>Remove staff lines.</li><li>Use a recognition label to get the duration.</li></ul> | <ul><li>Generate sound data.</li><li>Play the song.</li></ul> |


***

### Some Runtime Screenshots

| Annotated JingleBells | Annotated TwinkleTwinleLitterStar | Annotated BashSheet |
| :--------: | :-------------------: | :-------------------------: |
| <img src="Screenshots/Annotated%20JingleBells.png" height="300"/>| <img src="Screenshots/Annotated%20TwinkleTwinleLitterStar.png" height="300"/> | ![](.png)<img src="Screenshots/Annotated%20BashSheet.png" height="300"/> |
| **Stave Section with the BarLines** | **Stafflines Detection** | **Stave Section with the Stems** |
| ![](Screenshots/6.%20Vertical%20Projection%20With%20BarLines.png) | ![](Screenshots/0.%20Stafflines%20Detection.png)  | ![](Screenshots/9.%20Vertical%20Projection%20of%20the%20Stems.png) |


***

### Getting Started
The user has to open the **`Main.m`** in order to start the program. In the **10th** line, the user has to specify the image path. After setting up correctly the path, the code can be executed.

All the tested images were severally tested, which is provided under the **TestCases** folder.

After inserting the correct image path into the `Main.m` and running it, a `recognizedScore` variable is created, which contains all the necessary information for the music score **excluding** the dynamics (like the mf and ff) and the accidentals.

The created audio sample is located in the **TestCases** folder and it is exported with the name **`GeneratedAudio.wav`**.

***

### Prerequisites
**`MATLAB`** is required in order to run the current project
(2017 or later is preferable).

### References
- [VIP Helping Paper](https://publications.waset.org/10005799/automatic-music-score-recognition-system-using-digital-image-processing)
- [Andy Zeng Trial for staff lines detection](http://andyzeng.github.io/omr.pdf)
- [FFT-Based Correlation to Locate Image Features](https://www.mathworks.com/help/images/fourier-transform.html)
- [Identifying round objects](https://www.mathworks.com/help/images/identifying-round-objects.html)
- [Piano key frequencies](https://en.wikipedia.org/wiki/Piano_key_frequencies)
- [Using Fundamental Frequency to play audio](https://www.mathworks.com/matlabcentral/fileexchange/65665-make-a-song?s_tid=prof_contriblnk)
- [Image Orientation](https://www.mathworks.com/help/images/find-image-rotation-and-scale.html)
- [Text Annotation](https://www.mathworks.com/help/matlab/ref/text.html)

#### Copyrights
- Kareem S. Fathy
- KAN Org.
- University of Ain Shams, Egypt
