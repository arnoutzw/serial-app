#set document(title: "ESP Flash Tool — User Manual", author: "Black Sphere Industries")
#set page(paper: "a4", margin: (top: 2.5cm, bottom: 2.5cm, left: 2cm, right: 2cm))
#set text(font: "New Computer Modern", size: 11pt)
#set heading(numbering: "1.1")

// ─── Title Page ───
#align(center)[
  #v(4cm)
  #text(size: 36pt, weight: "bold")[ESP Flash Tool]
  #v(0.5cm)
  #text(size: 16pt, fill: rgb("#71717a"))[Browser-Based ESP Programmer]
  #v(1.5cm)
  #text(size: 18pt)[User Manual]
  #v(1cm)
  #line(length: 40%, stroke: 0.5pt + rgb("#f59e0b"))
  #v(1cm)
  #text(size: 12pt, fill: rgb("#71717a"))[Black Sphere Industries]
  #v(0.3cm)
  #text(size: 11pt, fill: rgb("#a1a1aa"))[Version 1.0 --- March 2026]
]

#pagebreak()
#outline(title: "Table of Contents", indent: 1.5em)
#pagebreak()

= Introduction

The ESP Flash Tool is a browser-based firmware programmer for Espressif ESP32 and ESP8266 microcontrollers, developed by Black Sphere Industries. It uses the Web Serial API to communicate directly with ESP chips from the browser --- no desktop software or drivers required. The tool supports firmware flashing, flash memory erasing, and serial monitoring, all in a single PWA.

== Key Capabilities

- *Firmware flashing* --- program ESP32/ESP8266 devices directly from the browser
- *Flash erase* --- complete flash memory erase
- *Serial monitor* --- real-time serial terminal with configurable baud rates
- *Multi-file support* --- flash multiple firmware partitions at specified addresses
- *Chip detection* --- automatic identification of connected ESP chip type
- *Flash options* --- configurable flash mode (DIO/QIO/DOUT/QOUT), frequency, and size
- *Output logging* --- xterm.js-based terminal for flash progress and debug output
- *PWA support* --- installable as a standalone application
- *Dark/Light theme* --- dual theme support with BSI branding

= Getting Started

== System Requirements

- *Browser*: Google Chrome 89+, Microsoft Edge 89+, or Opera (Web Serial API required)
- *Operating System*: Windows, macOS, or Linux with USB serial driver support
- *Hardware*: ESP32 or ESP8266 board connected via USB
- Firefox and Safari do not support the Web Serial API and will display an "unsupported browser" message

== Launching the ESP Flash Tool

+ *BSI Portal* --- select ESP Flash Tool from the app grid at `blacksphereindustries.nl`
+ *Direct URL* --- navigate to the ESP Flash Tool URL
+ *Installed PWA* --- launch from your OS app launcher after installation

== First-Time Setup

+ Connect your ESP board to the computer via USB
+ Open the ESP Flash Tool in a supported browser
+ The tool will prompt you to grant serial port access when you click "Connect"

= Features

== Flash Tab

The Flash tab is the primary interface for firmware programming and consists of four collapsible sections:

=== Connection Section

- *Baud Rate* --- select the communication speed: 921600, 460800, 230400, or 115200 (default)
- *Debug checkbox* --- enable verbose logging for troubleshooting
- *Connect button* --- open the browser's serial port picker and establish a connection to the ESP chip
- *Disconnect button* --- close the serial connection
- *Copy Trace button* --- copy the raw serial communication trace to clipboard for debugging
- *Chip Info badge* --- after connection, displays detected chip type and MAC address

=== Firmware Files Section

- *File list* --- add one or more firmware binary files, each with:
  - *Address field* --- hex memory address for the binary (e.g., `0x0`, `0x1000`, `0x10000`)
  - *File picker* --- select a `.bin` firmware file from your computer
  - *Remove button* --- remove a file entry
- *Add File button* --- add additional firmware file entries for multi-partition flashing
- *Progress bars* --- per-file progress indicators during flashing

=== Flash Options Section

- *Mode* --- flash mode selection:
  - `keep` (default) --- preserve existing mode
  - `DIO` --- Dual I/O
  - `QIO` --- Quad I/O
  - `DOUT` --- Dual Output
  - `QOUT` --- Quad Output
- *Frequency* --- flash clock frequency (populated after chip detection)
- *Size* --- flash memory size: `detect` (auto-detect) or `keep` (preserve)
- *Flash button* --- start the firmware programming process
- *Erase button* --- erase the entire flash memory

=== Output Log Section

An xterm.js-based terminal that displays:
- Connection status messages
- Chip detection results
- Flash progress (percentage per file)
- Error messages and debug output

== Monitor Tab

The Monitor tab provides a full serial terminal for communicating with the ESP device after flashing:

=== Serial Monitor Controls

- *Baud Rate* --- configurable from 9600 to 921600 (default: 115200)
- *Start button* --- begin serial monitoring
- *Stop button* --- end the monitoring session
- *Reset button* --- send a hardware reset signal to the ESP device
- *Clear button* --- clear the terminal output

=== Monitor Terminal

An xterm.js terminal window displaying incoming serial data from the ESP device in real time.

=== Send Bar

- *Input field* --- type commands or data to send to the device
- *Line ending selector* --- choose the line ending format:
  - `\\r\\n` (CR+LF, default)
  - `\\n` (LF only)
  - `\\r` (CR only)
  - None
- *Send button* --- transmit the input to the device

=== Monitor Statistics

Three stat cards showing real-time metrics:
- *RX* --- bytes received
- *TX* --- bytes transmitted
- *Uptime* --- connection duration

== PWA Installation

The ESP Flash Tool supports PWA installation:
- Click the "Install" button in the header (appears when the browser supports installation)
- The app will be added to your desktop or home screen
- Runs in a standalone window without browser chrome

= User Interface

== Header

The header bar displays:
- ESP Flash Tool branding with chip icon
- Connection status indicator (colored dot: green = connected, yellow = connecting, red = disconnected)
- Status text showing current connection state
- Install button (when available)

== Tab Bar

Two tabs below the header:
- *Flash* --- firmware programming interface
- *Monitor* --- serial terminal interface

Tabs can also be switched via URL hash (`#flash`, `#monitor`).

== Collapsible Sections

Each section in the Flash tab can be collapsed or expanded by clicking the section header. The chevron icon rotates to indicate the current state.

== Toast Notifications

Success and error messages appear as temporary toast notifications at the bottom of the screen.

== Alert Banners

Critical errors (e.g., connection failures) display as persistent alert banners at the top of the Flash tab with a dismiss button.

= Workflows

== Firmware Flashing Workflow

+ Select the appropriate baud rate (115200 is a safe default; 921600 is faster)
+ Click *Connect* and select the serial port from the browser dialog
+ Wait for chip detection --- the Chip Info badge will display the chip type
+ Add firmware file entries with the correct flash addresses:
  - For ESP32: bootloader at `0x1000`, partition table at `0x8000`, application at `0x10000`
  - For ESP8266: typically a single binary at `0x0`
+ Select flash options (Mode, Frequency, Size) --- use `keep`/`detect` if unsure
+ Click *Flash* to begin programming
+ Monitor progress in the Output Log terminal
+ After completion, click *Disconnect* or switch to the Monitor tab

== Flash Erase Workflow

+ Connect to the ESP device (same as above)
+ Click *Erase* in the Flash Options section
+ Wait for the erase operation to complete (shown in Output Log)
+ The device's flash memory is now blank and ready for fresh firmware

== Serial Monitoring Workflow

+ Switch to the *Monitor* tab
+ Set the baud rate to match your firmware's serial output rate
+ Click *Start* to begin monitoring
+ View incoming serial data in the terminal
+ Use the Send bar to transmit commands to the device
+ Click *Reset* to reboot the ESP device
+ Click *Stop* to end the monitoring session

== Debug Workflow

+ Enable the *Debug* checkbox before connecting
+ Connect to the device
+ Perform the flash or monitor operation
+ If issues occur, click *Copy Trace* to capture the raw serial communication
+ Share the trace for troubleshooting

= Architecture

The ESP Flash Tool is a single-file HTML application using vanilla JavaScript, the Web Serial API, and the esptool.js library for ESP communication.

== Architecture Overview

#figure(
  image("uml-architecture.svg", width: 100%),
  caption: [ESP Flash Tool system architecture],
)

== Class Diagram

#figure(
  image("uml-class-diagram.svg", width: 100%),
  caption: [ESP Flash Tool class and component diagram],
)

== Main Flash Sequence

#figure(
  image("uml-seq-main.svg", width: 100%),
  caption: [Main firmware flashing sequence],
)

== Monitor and Secondary Operations Sequence

#figure(
  image("uml-seq-secondary.svg", width: 100%),
  caption: [Serial monitor and secondary operations sequence],
)

== State Diagram

#figure(
  image("uml-states.svg", width: 100%),
  caption: [ESP Flash Tool application state diagram],
)

= Configuration

== Baud Rate Selection

- *115200* --- most reliable, works with all ESP devices
- *921600* --- fastest, recommended for ESP32 with stable USB connections
- *460800 / 230400* --- intermediate options for unstable connections

== Flash Mode

- *DIO* --- most compatible, works with all ESP32 modules
- *QIO* --- faster, requires quad-SPI flash support
- *DOUT / QOUT* --- alternative modes for specific hardware configurations
- *keep* --- preserve the existing flash mode (safest option)

== Flash Size

- *detect* --- automatically detect flash size from the chip
- *keep* --- preserve the existing flash size setting
- Manual sizes: 256KB through 128MB

== Theme

- *Dark* (default) --- amber accent on dark background
- *Light* --- blue accent on white background
- Theme is controlled by the portal when embedded, or toggled locally in standalone mode

= Troubleshooting

== Browser Not Supported

- *Symptom*: "Browser Not Supported" message displayed
- *Cause*: Web Serial API is not available
- *Fix*: use Google Chrome, Microsoft Edge (v89+), or Opera

== Cannot Connect to Device

- *Symptom*: no serial port appears in the browser dialog
- *Cause*: USB driver not installed, or device not recognized
- *Fix*: install the appropriate USB-to-UART driver (CP2102, CH340, or FTDI); try a different USB cable (ensure it is a data cable, not charge-only); check Device Manager (Windows) or `ls /dev/tty*` (macOS/Linux)

== Flash Fails Midway

- *Symptom*: flash progress stops and an error appears
- *Cause*: baud rate too high, unstable connection, or incorrect flash addresses
- *Fix*: reduce baud rate to 115200; ensure a stable USB connection; verify firmware addresses match your partition table

== Device Not Entering Bootloader

- *Symptom*: connection timeout or "Failed to connect" error
- *Cause*: ESP device is not in bootloader mode
- *Fix*: hold the BOOT button while clicking Connect; some boards require holding BOOT and pressing RESET; check that the correct serial port is selected

== Monitor Shows Garbage Characters

- *Symptom*: unreadable output in the serial terminal
- *Cause*: baud rate mismatch between the tool and the firmware
- *Fix*: match the monitor baud rate to the value used in your firmware's `Serial.begin()` call (commonly 115200 or 9600)

== Erase Takes Too Long

- *Symptom*: erase operation runs for several minutes
- *Cause*: large flash size (8MB or more)
- *Fix*: this is normal for large flash chips; wait for completion; do not disconnect during erase
