# データベース設計の流れを説明できる

これからデータベース設計について学習していきます。

システム開発は基本の流れとして①要件定義②設計③開発/実装④テスト⑤リリース、という流れで進んでいきます。データベース設計はその中の「②設計」で行われます。

データベース設計の基本の流れは次の通りです。

①論理設計

1. エンティティの定義
2. 正規化
3. ER 図作成

②物理設計

1. テーブル定義
2. インデックス設計

その前提の上で、以下を解いてください。

## 1. 論理設計

論理設計とは何か、プログラミング初心者にわかるように説明してください。
```
データベースサーバーののメモリやCPU、データ型やインデックスなどの、物理的な制約にとらわれずに机上でデータベース設計を考えること
```

## 2. 物理設計

物理設計とは何か、プログラミング初心者にわかるように説明してください。
```
理設計で決まったデータを格納するための物理的な領域の格納方法を決める
テーブル定義
インデックス定義
ハードウェアのサイジング
ストレージの冗長構成
ファイルの物理的配置
```

## 3. エンティティ

データベース設計におけるエンティティとは何か、プログラミング初心者にわかるように説明してください。
```
テーブル作成の基盤を決める
・エンティティの抽出
  エンティティとは実体を表します。
  具体的にECサイトにおけるエンティティは「店舗」「商品」「顧客」「注文」「決済」などがあります。
  実際に開発するシステムにおいて必要なエンティティを抽出するのがエンティティの抽出のステップになります。
・エンティティの定義
  抽出エンティティがどのようなデータを保持するかを決定していきます。
  エンティティが持つデータを属性(attribute)と呼びます。
  テーブルでいう列の部分が属性に当たります。
```

## 4. 正規化

正規化とは何か、プログラミング初心者にわかるように説明してください。
```
テーブルがデータを扱いやすいようにするための設計
正規化をすることでデータの冗長性や不整合が発生する機会を減らすことができます
```

## 5. ER 図

ER 図とは何か、プログラミング初心者にわかるように説明してください。
```
エンティティ（テーブル）同士の関係を表した図
```

## 6. テーブル定義

テーブル定義とは何か、プログラミング初心者にわかるように説明してください。
```
論理設計で定義された概念スキーマを元に、格納する為にテーブルの単位に変換する
このフェーズで作成されるモデルは物理モデルと呼ばれる
```
## 7. インデックス

インデックスとは何か、プログラミング初心者にわかるように説明してください。
```
インデックス(索引)を付与することで非機能部分であるパフォーマンスを向上させることができます。
インデックスを参照することで目的のデータが格納されている位置に直接アクセスすることができ、検索を高速化することができます。
```
