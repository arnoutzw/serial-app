# ESP Flash Tool - Test Plan

## 1. Loading & Initialization

- [ ] App loads without console errors
- [ ] All UI elements render correctly
- [ ] Service worker registers successfully
- [ ] App is responsive on mobile, tablet, and desktop viewports
- [ ] Loads correctly when embedded as iframe in home portal

## 2. Theme Support

- [ ] Dark theme renders correctly
- [ ] ASML light theme renders correctly
- [ ] Theme toggle switches between dark and ASML themes
- [ ] Theme preference persists across page reloads
- [ ] Theme change sends postMessage to parent portal
- [ ] postMessage format: `{ type: "theme-change", theme: "dark"|"asml" }`
- [ ] No visual glitches during theme transition

## 3. File Upload / Import

- [ ] File picker opens correctly
- [ ] Valid files are accepted and processed
- [ ] Invalid file types show appropriate error
- [ ] Large files are handled gracefully

## 4. Serial Communication

- [ ] Serial port selection dialog opens
- [ ] Connect/disconnect cycle works
- [ ] Data is received and displayed correctly
- [ ] Graceful handling when no device is connected
- [ ] Error handling for lost connection

## 5. Cross-Browser Compatibility

- [ ] Chrome (latest)
- [ ] Firefox (latest)
- [ ] Safari (latest)
- [ ] Edge (latest)

## 6. Iframe Integration

- [ ] App loads inside home portal iframe
- [ ] No CSP or CORS errors
- [ ] Navigation within app stays in iframe
- [ ] Theme postMessage reaches parent portal
- [ ] App is fully functional inside iframe
