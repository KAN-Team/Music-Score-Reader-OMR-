# Music-Score-Reader (OMR)

Optical music recognition (OMR) has been the subject of research for decades. <br> 
An accessible and easy-to-use OMR application could provide an amazing tool for improving the musical education experience. <br>
For example, a novice musician could use such a tool to hear what a selected piece of music should sound like.

Ideally, an OMR, given an image of a simple or complex music sheet, automatically identifies the notes, and plays the musical piece. <br>
For this project, our goal is to develop an algorithm to parse music sheet images, <br>
produce the associated annotation, and implement a playback mechanism for the parsed musical notes.

***
## Process Overview
<b> The process is broken down into the following tasks: </b>

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
- Minimum score threshold: 80%.
- Pick a label with maximum score.

**`4. Note Identification`** <br>
- Calculate center point coordinate.
- Compare with staff lines coordinates to get the pitch.
- Use recognition label to get the duration.
     
**`5. Music Transformation`** <br> 
- Generate sound data.
- Play the song.
