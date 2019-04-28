# Stringly
Work in progress easily extensible library for creating formatted NSAttributedStrings from basic XML.

## Current Functionality
Currently you can create a string like so:
```Swift
let content =
"""
<img url-src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" orientation="up" padding="100" align="center"/>
<h1 align="center">This is <b font-size="40">heading</b> 1</h1>
<h2>This is <h2 highlight="#ff0000a0">heading 2</h2></h2>
<h3><u>This is heading 3</u></h3>
<h4>This is <i>heading</i> 4</h4>
<h5>This is <h5 color="#ff0000a0">heading</h5> 5</h5>
<h6>This is heading 6</h6>
<t font-style="footnote">Footnote</t>
<t underline-style="double,patternDash" font-size="20">Testing, yahoo!</t>
<t font="Helvetica Neue" font-size="20">Testing, yahoo!</t>
<t font-size="20">You can also redact <r>stuff</r> if you like</t>

<img url-src="https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png" orientation="down" padding="100" align="center"/>
<img orientation="up" src="me" padding="0" align="center"/>
"""
```
and format it:
```Swift
textView.format(text: content)
```
to get the following result:

<img src="https://raw.githubusercontent.com/mattDavo/Stringly/master/images/screenshot.png" width="300"/>

As you will notice there is images that are sourced from urls. This functionality is possible by loading the images asynchronously then as the jobs finish the attributedText of the UITextView is updated to show the images.

## TODO
- [x] More options for standard tags
- [x] Ability to create custom tags
- [x] Ability to add more attributes to the default tags
- [x] Ability to add more options to the default tags
- [x] Cleaner implementation
- [ ] Customizable link tag
- [ ] Conditional text redacting
- [ ] Ability to execute code when a certain range of text is tapped.
- [ ] Action tag => tap, hold, drag, etc. will execute certain code.
- [ ] More info tag, tapping on a link, will show a floating view next to it. Ability to customise default window, or provide custom UIView
- [ ] Ability to add Asynchronous Tag Options and Asynchronous Waiting Tag Options that wait for asynchronous options to finish before being applied.
- [ ] Images
  - [x] Ability to insert images (see https://stackoverflow.com/a/38479284).
  - [ ] Provide image through custom asynchronous function
  - [ ] Provide image through url
  - [x] Ability to size images
  - [x] Ability to align images
  - [x] Ability to orientate images
  - [ ] Optionally tap to enlarge/execute code (see https://stackoverflow.com/questions/48498366/detect-tap-on-images-attached-in-nsattributedstring-while-uitextview-editing-is)?
- [ ] Gifs
- [ ] Use XML Parser
- [ ] Custom Text Paragraph style
