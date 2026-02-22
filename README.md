# ESP Flash Tool

A web-based utility for flashing firmware to ESP32 and ESP8266 microcontrollers via Web Serial API.

![Screenshot Placeholder](https://via.placeholder.com/800x400)

## Features

- **Serial Port Management** - Connect/disconnect from ESP devices via Web Serial API
- **Configurable Baud Rates** - Default 115200 bps with custom rate support
- **Multiple Firmware Upload** - Load multiple binary files with configurable offset addresses
- **Flash Configuration** - Set flash mode (QIO/DIO/QOUT/DOUT), frequency (40/80 MHz), and size
- **Flash & Erase Functions** - Erase flash memory or program new firmware
- **Real-time Serial Monitor** - Live output display from device during operations
- **Debug Logging** - Comprehensive logging for troubleshooting connections and transfers
- **Progressive Web App** - Install as PWA for offline capability and homescreen access

## Tech Stack

- HTML5
- JavaScript
- Web Serial API
- Progressive Web App (PWA)
- Service Worker

## Getting Started

Access the tool online:

1. Visit: [ESP Flash Tool](https://arnoutzw.github.io/serial-app/)
2. Connect your ESP32/ESP8266 via USB
3. Select the serial port from the dropdown
4. Upload firmware files with appropriate offset addresses
5. Configure flash options and click "Flash"
6. Monitor the real-time output for status

**Note:** Web Serial API requires HTTPS and is supported in Chromium-based browsers (Chrome, Edge, Opera).

## Supported Devices

- ESP32 (all variants)
- ESP8266

## Usage Tips

- Default baud rate 115200 works with most devices
- Set correct offset addresses for firmware files (typically 0x0000 or 0x1000)
- Erase flash before flashing for clean installation
- Monitor output for error messages or timeout issues


## Theme Support

The app supports two themes:

- **Dark** (default) - Dark background with amber accents
- **ASML Light** - Light theme following ASML corporate design (deep blue #10069f, cyan accents)

When embedded in the Black Sphere Industries portal, theme changes are communicated via `postMessage`:

```javascript
// Sent to parent when theme changes
window.parent.postMessage({ type: "theme-change", theme: "dark" | "asml" }, "*");
```

## License

MIT License - See LICENSE file for details
