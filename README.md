# Stringly
Work in progress easily extensible library for creating formatted NSAttributedStrings from basic XML.

## Current Functionality
Currently you can create a string like so:
```Swift
let content =
"""
<h1>This is <b size="40">heading</b> 1</h1>
<h2>This is heading 2</h2>
<h3><u>This is heading 3</u></h3>
<h4>This is <i>heading</i> 4</h4>
<h5>This is <h5 color="#ff0000a0">heading</h5> 5</h5>
<h6>This is heading 6</h6>
"""
```
and format it:
```Swift
textView.attributedText = content.format()
```
to get the following result:

<img src="https://raw.githubusercontent.com/mattDavo/Stringly/master/screenshot.png" width="300"/>

## TODO
- [x] More options for standard tags
- [x] Ability to create custom tags
- [x] Ability to add more attributes to the default tags
- [x] Ability to add more options to the default tags
- [x] Cleaner implementation
- [ ] Customizable link tag
- [ ] Conditional text redacting
- [ ] Ability to execute code when a certain range of text is executed.
- [ ] Action tag => tap, hold, drag, etc. will execute certain code.
- [ ] More info tag, tapping on a link, will show a floating view next to it. Ability to customise default window, or provide custom UIView
- [ ] Images
  - [x] Ability to insert images (see https://stackoverflow.com/a/38479284).
  - [ ] Provide image through custom function
  - [ ] Ability to size images
  - [ ] Optionally tap to enlarge/execute code (see https://stackoverflow.com/questions/48498366/detect-tap-on-images-attached-in-nsattributedstring-while-uitextview-editing-is)?
