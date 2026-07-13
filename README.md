# CLRS Algorithms in Haskell

『アルゴリズムイントロダクション (Introduction to Algorithms / CLRS)』の
アルゴリズムを Haskell で 1 つずつ実装していく学習用リポジトリ。

- **GHC** 9.10.1 / **cabal** 3.14（`ghcup` 管理）
- テスト: **hspec** + **QuickCheck**（プロパティテスト）

## ディレクトリ構成

```
src/Algorithms/<Topic>/<Name>.hs        -- 実装（1 アルゴリズム = 1 モジュール）
test/Algorithms/<Topic>/<Name>Spec.hs   -- テスト（hspec-discover が自動収集）
app/Main.hs                             -- 手で試すデモ実行
clrs.cabal                              -- パッケージ定義
```

現在の実装:

| 章 | アルゴリズム | モジュール |
|----|------------|-----------|
| 2  | Insertion Sort | `Algorithms.Sorting.InsertionSort` |

## よく使うコマンド

```sh
cabal build        # ビルド
cabal test         # テスト実行（プロパティテスト含む）
cabal run clrs     # デモ実行
cabal repl         # ライブラリを REPL で対話的に試す
```

`cabal repl` の中では:

```haskell
ghci> import Algorithms.Sorting.InsertionSort
ghci> insertionSort [5,2,4,6,1,3]
[1,2,3,4,5,6]
```

## 新しいアルゴリズムを追加する手順

1. `src/Algorithms/<Topic>/<Name>.hs` に実装を書く。
2. `clrs.cabal` の `library` の `exposed-modules:` にモジュール名を追加する。
3. `test/Algorithms/<Topic>/<Name>Spec.hs` に `spec :: Spec` を書き、
   `clrs.cabal` の `test-suite` の `other-modules:` に追加する
   （`hspec-discover` がファイルを見つけて自動で実行してくれる）。
4. `cabal test` で確認する。

ソートなら「`Data.List.sort` と一致する」「出力は入力の並べ替えである」
といったプロパティを QuickCheck で書くと、実装の正しさを網羅的に検証できる。
