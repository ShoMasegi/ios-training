# Session 2

## 課題

レポジトリ画面 (RepositoryViewController) を新規作成して、イベント一覧画面から遷移出来るようにしましょう。

ここでは以下の内容を学びます。

- `UITableViewDelegate`の設定
- ViewControllerの作成方法
- XibファイルとStoryboardの違い
- 遷移の仕方と違い

### 修正ファイル

- [MainViewController.swift](./../Training/Scenes/Main/MainViewController.swift)
- [Main.storyboard](./../Training/Scenes/Main/Main.storyboard)

## 手順

1. `UITableViewDelegate`を設定して`UITableView`のタップイベントを実装する。
2. レポジトリ画面を作成する。
3. イベント一覧画面からレポジトリ画面への遷移を実装する。