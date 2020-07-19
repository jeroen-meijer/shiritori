# Shiritori - Flutter App

The Japanese game Shiritori for iOS, Android and web.

**Proof of concept and work in progress -- does not work yet.**

## Highlights

- Well-composed [modern UI](https://dribbble.com/shots/5836646-Quiz-iOS-app-Animation).
- Context-aware theming.
- Full Intl localization.
- Custom animations.

# How to launch

The client can be found in the `app/` directory.
Either open this project in your editor and run it through your
IDE, or go to the `app/` folder and run the app manually.

```bash
cd app/
flutter run
```

A dictionary parser can be found in the `/dict_parser` directory.
It currently only supports parsing the Japanese `JMdict_e` document,
but can be refactored to support more languages and formats relatively easily.

A script is included that compiles the parser to native and then runs it against
the included `JMdict_e.xml` file.

**Warning: the `JMdict_e.xml` file is extremely large (~30M lines).**
**Opening it in an editor may make your text editor lag or crash altogether.**

Run the dict_parser by using the included script:
```bash
./scripts/run_dict_parser.sh
```

# TODO

Here are some things I still need/want to implement.

- Actually being able to play the game.
- Backend integration to play against other players preferably using Firebase.
- More pretty animations.

### Credits

As an exercise, I tried to copy this [beautiful UI mockup](https://dribbble.com/shots/5836646-Quiz-iOS-app-Animation) done by [Mike from Creative Mints](https://dribbble.com/creativemints). Give 'em some love.

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,🎉
samples, guidance on mobile development, and a full API reference.

## License

MIT License

Copyright (c) 2020 Jeroen Meijer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
