# Session 3

## 課題

レポジトリ画面をデザイン通りに実装しましょう。

ここでは以下の内容を学びます。

- 新規のAPIリクエスト･UseCaseを作成方法
- `Codable`の使い方
- Custom Viewの作成方法
- `UIStackView`の使い方

## 手順

1. [[GET] /repos/{owner}/{repo}](https://docs.github.com/ja/rest/reference/repos#get-a-repository) を使用してレポジトリ詳細を取得する。
   1. APIリクエストを作成
   2. APIレスポンス(`struct`)を作成
   3. UseCaseを作成
2. Custom Viewを作成して似たViewを使い回す。
3. `UIStackView`を使用して並んでいるViewを簡単に設置する。