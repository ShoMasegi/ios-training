# Session 1

## 課題

イベント一覧画面 ([Main](./../Training/Scenes/Main)) を [デザイン](https://www.figma.com/file/B0Pp2PNSmTugNxQ01dKeiy/ios-training) 通りの見た目に修正しましょう。<br>

ここでは以下の内容を学びます。

- [Interface Builderの使い方](./Page/Interface_Builder.md)
- [Viewの角を丸くする](https://i-app-tec.com/ios/corner-radius.html)
- [Swift Package Managerを使ったライブラリの導入方法](https://qiita.com/hironytic/items/09a4c16857b409c17d2c)

### 修正ファイル

- [EventTableViewCell.xib](./../Training/Scenes/Main/Subviews/EventTableViewCell.xib)
- [EventTableViewCell.swift](./../Training/Scenes/Main/Subviews/EventTableViewCell.swift)

## 手順

1. 各Viewをデザイン通りに設置する。
2. 画像読み込みライブラリである [Nuke](https://github.com/kean/Nuke) を Swift Package Manager でインストールする。
3. アイコンを表示する。