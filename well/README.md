# WELL — Module 2: Interactive Devices

An interactive horror game by Helena Mo. A joystick becomes a flashlight in a night-time forest; a potentiometer changes its size. Find the well and press the joystick switch to reveal a ghost. Press the separate button to return to exploration.

**[Project website and documentation](https://helenamoisme.github.io/well/)** · [Repository](https://github.com/helenamoisme/helenamoisme.github.io/tree/main/well)

![Well gameplay](assets/demo.gif)

## Artistic vision

Inspired by Sadako crawling out of the television in the Japanese film *リング*, Well uses limited visibility and an intentional button press to build suspense before a sudden reveal. The original hard-edged circular light was replaced with a gradual fade to create a more atmospheric beam.

## Hardware

- ESP32 TTGO T-display, USB data cable and laptop
- Analog joystick with built-in switch
- Potentiometer, separate button, breadboard and jumper wires
- Optional LED with appropriate current-limiting resistor (the sketch drives GPIO 15)

| Signal | GPIO |
| --- | --- |
| Joystick X | 39 |
| Joystick Y | 32 |
| Joystick switch | 33 |
| Potentiometer wiper | 27 |
| Separate reset button | 2 |
| LED output | 15 |

Power analog controls from 3.3 V and connect all grounds together. Connect the joystick switch and reset button between their respective GPIO and GND; both use `INPUT_PULLUP` (released = 1, pressed = 0). Connect the potentiometer’s outer terminals to 3.3 V and GND and its center/wiper to GPIO 27. Connect joystick VRx/VRy to 39/32, VCC to 3.3 V, and GND to common ground. Do not feed 5 V into ESP32 analog inputs. Verify labels on your actual modules before wiring.

![Physical controller](assets/controller.jpg)

**Required circuit documentation still missing:** a Fritzing diagram was not provided. This code-derived pin table and photograph are not a Fritzing diagram. Add the actual `.fzz` source and exported circuit image before final submission.

## Run the original project

1. Install Arduino IDE and Espressif’s ESP32 board support. Select the board configuration appropriate to your TTGO T-display and its USB port.
2. Open `code/WellArduino/WellArduino.ino`, wire the controls as above, and upload. Close Arduino Serial Monitor before opening Processing.
3. Install Processing (Java mode). The sketch uses the Processing Serial library (`processing.serial`).
4. Open `code/WellProcessing/WellProcessing.pde`. Keep `data/well.png` and `data/ghost.png` inside that sketch folder.
5. Run once to print `Serial.list()`. Change `Serial.list()[1]` to the index of your ESP32 port. The original sketch assumes index 1, so it will fail if fewer than two ports exist or the board uses another index. Set this before running the game.
6. Run at 9600 baud. Move the joystick, turn the potentiometer, and press the joystick inside the well region (X 250–550, Y 320–520). Use the separate button to reset the scare.

The game needs the physical controller and wired serial connection. The website documents the game; it does not run the Processing sketch in the browser.

## Data and implementation

Every 100 ms, Arduino sends `x,y,joystickSwitch,potentiometer,resetButton` followed by a newline. Processing accepts five-field lines, maps 0–4095 analog readings to an 800 × 600 canvas, and maps the potentiometer to a 100–400 pixel beam diameter.

The joystick press is detected using the previous switch value. A new press within the well rectangle sets `scare = true`. The separate button sets it to false. Reset retains the current beam position and size.

For every pixel, `dist()` measures its distance from the beam center. The inner 60% of the radius remains visible; the outer 40% blends toward black through `constrain(map(...))` and `lerpColor()`. This is a spatial fade, not a timed animation. See the website for the annotated excerpt.

Both sketches are transcribed from the author’s supplied code, with formatting normalized and the equivalent LED if/else shortened. They have not been compiled or tested on the physical hardware in this documentation session. Serial polling runs at approximately 10 Hz; the pixel loop processes the full canvas each frame. The provided sketch does not add button debouncing or serial reconnection.

## AI support and references

The author reports using **Codex, GPT-6.1 Sol light** to generate the forest/well and ghost images and to help implement the flashlight fade. The earlier hard-edged circle was revised to create a softer transition. Both sketches also reference the professor’s Lab 2 sample code.

Prompt examples below are reconstructed summaries, **not verbatim saved prompts**:

- “Create a gloomy forest at night with a stone well, for the background of an interactive horror game.”
- “Create a frightening image of a female ghost crawling out of the well toward the viewer.”
- “Help me change the hard-edged circular flashlight in Processing into a beam with a gradual fade into darkness.”

Replace with actual prompt excerpts if available. Film inspiration: *リング*, specifically Sadako emerging from a television.

## Documentation assets

- `assets/recording.mp4`: screen recording
- `assets/interaction.mp4`: hardware interaction
- `assets/flashlight.mp4`: flashlight size demonstration
- `assets/controller.jpg`: controller photograph
- `assets/well.png`, `assets/ghost.png`: supplied AI-generated game artwork

Videos are playable directly on the project website. Horror imagery is disclosed before viewing the ghost image.

## Submission status

The website covers artistic vision, design decisions, technical implementation, AI disclosure, embedded videos, photographs, and a repository link. A Fritzing diagram and original prompt excerpts remain to be supplied. No historical proposal or classroom showcase completion is claimed here.
