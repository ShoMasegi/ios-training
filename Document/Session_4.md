# Session 4

## 課題

ユーザー詳細画面をデザイン通りに実装しましょう。

ここでは以下の内容を学びます。

- `UIButton`のタップイベントの実装方法
- `UITableView`の使い方
  - `UITableViewDiffableDataSource`･`NSDiffableDataSourceSnapshot`の使い方
  - `UITableHeaderView`の追加方法
  - `UITableViewHeaderFooterView`の追加方法

## 手順

1. レポジトリ画面の`Detail`ボタンをタップしたときにユーザー詳細画面へ遷移する。
2. [[GET] /users/{username}](https://docs.github.com/ja/rest/reference/users#get-a-user) と [[GET] /users/{username}/repos](https://docs.github.com/ja/rest/reference/repos#list-repositories-for-a-user) を使って必要な情報を取得する。
3. ユーザーのレポジトリ一覧を表示する。
4. `UITableHeaderView`を使ってユーザー詳細を表示する。
5. `UITableViewHeaderFooterView`を使ってセクションヘッダーを表示する。