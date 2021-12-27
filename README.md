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

**`0. Preparations for the Process`** <br>
- Detect the image orientation.
- Remove unwanted margins.
- Getting number of staves.

**`1. Staff Lines Detection and Removal`** <br>
- Detect the location of all staff lines.
- Remove staff lines.
- Fill in the gaps.

**`2. Segmentation`** <br>
- Process row by row.
- Calculate boundaries for each symbol.
- Extract Symbol.

**`3. Symbol Recognition`** <br>
- Calculate matching score against each training data.
- Minimum score threshold: **74%**.
- Pick a label with a maximum score.

**`4. Note Identification`** <br>
- Calculate centre point coordinate.
- Compare with staff lines coordinates to get the pitch.
- Use a recognition label to get the duration.
     
**`5. Music Transformation`** <br> 
- Generate sound data.
- Play the song.

***

### Getting Started
The user has to open the **`Main.m`** in order to start the program. In the **10th** line, the user has to specify the image path. After setting up correctly the path, the code can be executed.

All the tested images were severally tested, which is provided under the **TestCases** folder.

After inserting the correct image path into the `Main.m` and running it, a `recognizedScore` variable is created, which contains all the necessary information for the music score **excluding** the dynamics (like the mf and ff) and the accidentals.

The created audio sample is located in the **TestCases** folder and it is exported with the name **`GeneratedAudio.wav`**.

### Prerequisites
**`MATLAB`** is required in order to run the current project
(2017 or later is preferable).

#### Copyrights
- Kareem S. Fathy
- KAN Org.
- University of Ain Shams, Egypt
