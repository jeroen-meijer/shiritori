<div align="center">
  <h1>Shiritori (Flutter App)</h1>
  <h4>The Japanese game Shiritori for iOS, Android and the web.</h4>
</div>

<div align="center">
  <a
    href="https://github.com/jeroen-meijer/shiritori/actions?query=workflow%3Aci"
  >
    <img
      alt="GitHub Workflow Status"
      src="https://img.shields.io/github/workflow/status/jeroen-meijer/shiritori/CI?logo=github&label=ci"
    />
  </a>
  <a href="https://github.com/jeroen-meijer/shiritori/commits/"
    ><img
      alt="GitHub last commit"
      src="https://img.shields.io/github/last-commit/jeroen-meijer/shiritori?logo=github"
  /></a>
  <a href="https://github.com/jeroen-meijer/shiritori">
    <img
      alt="GitHub stars"
      src="https://img.shields.io/github/stars/jeroen-meijer/shiritori.svg?logo=github&colorB=deeppink&label=stars"
    />
  </a>
  <br />
  <a href="https://github.com/jeroen-meijer/shiritori/issues">
    <img
      alt="GitHub issues"
      src="https://img.shields.io/github/issues/jeroen-meijer/shiritori?logo=github"
    />
  </a>
  <a href="https://github.com/tenhobi/effective_dart">
    <img
      alt="style: effective dart"
      src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg?logo=data:image/svg%2bxml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4KPHN2ZyB2ZXJzaW9uPSIxLjEiIGlkPSJMYXllcl8xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB4PSIwcHgiIHk9IjBweCIgdmlld0JveD0iMCAwIDUxMiA1MTIiIHN0eWxlPSJlbmFibGUtYmFja2dyb3VuZDpuZXcgMCAwIDUxMiA1MTI7IiB4bWw6c3BhY2U9InByZXNlcnZlIj4KCTxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyI+Cgkuc3Qwe2ZpbGw6I2ZmZmZmZjt9Cjwvc3R5bGU+Cgk8Zz4KCQk8cGF0aCBjbGFzcz0ic3QwIiBkPSJNMTI2LjUsMTAyLjFMMCwyNTZsMTI2LjUsMTUzLjlsMjkuOS00OS4yTDcxLjIsMjU2bDg1LjItMTA0LjdMMTI2LjUsMTAyLjF6IE0xODEuOCw0MDYuMmg1NS41bDg4LjItMzAxLjMKCQloLTU1LjVMMTgxLjgsNDA2LjJ6IE0zODUuNSwxMDIuMWwtMjkuOSw0OS4yTDQ0MC44LDI1NmwtODUuMiwxMDQuN2wyOS45LDQ5LjJMNTEyLDI1NkwzODUuNSwxMDIuMXoiIC8+Cgk8L2c+Cjwvc3ZnPgo="
    />
  </a>
  <a href="https://opensource.org/licenses/MIT">
    <img
      alt="MIT License"
      src="https://img.shields.io/badge/License-MIT-blue.svg?label=license&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNTYiIGhlaWdodD0iMjU2Ij48cGF0aCBkPSJNMjQ1LjQ2NyAxMzQuNzgyYTExMy4xMzcgMTA5LjA5NiAwIDExMC0uMDAyIiB0cmFuc2Zvcm09Im1hdHJpeCgxLjA1NzIzIDAgMCAxLjA5MzAyIC0xMi4wNDEgLTE4LjgxNCkiIGZpbGw9IiNmZmYiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIxNS4zNDkiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPjxnIGZpbGw9Im5vbmUiIHN0cm9rZS13aWR0aD0iMTQuMTg4Ij48cGF0aCBkPSJNNTIuMjU1IDgzLjA5MXY5Mi4yMDZNODQuMDI5IDgzLjI5OXY2MC4yMjRNMTE1LjU5NSA4My4wOTFsLjIwOCA5MS45OThNMTQ3LjE2IDgzLjA5MWwuMjA5IDE5LjcyOU0xNzguOTM1IDExNC44NjVsLjIwNyA2MC40MzJNMTY5LjE3NCA5Mi44NTJsNTEuMjk1LjIwNyIgc3Ryb2tlPSIjOWMwMDAwIiBzdHJva2Utd2lkdGg9IjE2LjUwMDA3NjQ4Ii8+PHBhdGggZD0iTTE0Ny4zNjkgMTE0Ljg2NXY2MC4yMjQiIHN0cm9rZT0iIzdjN2Q3ZSIgc3Ryb2tlLXdpZHRoPSIxNi41MDAwNzY0OCIvPjwvZz48L3N2Zz4="
    />
  </a>
</div>

---

## Highlights

- Fully playable.
- Well-composed [modern UI](https://dribbble.com/shots/5836646-Quiz-iOS-app-Animation).
- Pretty custom animations.
- Context-aware theming.
- Full GitHub CI/CD.
- Full `intl` localization.
- Custom dictionary parser.
- Expandable to any language.

# How to launch

## 1. (Optional) Run the dictionary parser

This repository comes with a pre-made Japanese dictionary file (`app/assets/dicts/dict_ja.json`).

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

## 2. Run the app

The client can be found in the `app/` directory.
Either open this project in your editor and run it through your
IDE, or go to the `app/` folder and run the app manually.

```bash
cd app/
flutter run
```

# TODO

Here are some things I still need/want to implement.

- Backend integration to play against other players preferably using Firebase.
- More pretty animations.

_Note: though I originally built this to only work with the Japanese language, I did keep the option of expanding this to work with other languages in mind. Therefore, it should not be too difficult to change the parser and client to use multiple languages._
_The above also goes for multiplayer functionality._

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
