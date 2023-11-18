# インターネットTV

好きな時間に好きな場所で話題の動画を無料で楽しめる「インターネットTVサービス」を新規に作成することになりました。データベース設計をした上で、データ取得する SQL を作成してください。

仕様は次の通りです。サービスのイメージとしては [ABEMA](https://abema.tv/) を頭に思い浮かべてください。

- ドラマ1、ドラマ2、アニメ1、アニメ2、スポーツ、ペットなど、複数のチャンネルがある
- 各チャンネルの下では時間帯ごとに番組枠が1つ設定されており、番組が放映される
- 番組はシリーズになっているものと単発ものがある。シリーズになっているものはシーズンが1つものと、シーズン1、シーズン2のように複数シーズンのものがある。各シーズンの下では各エピソードが設定されている  
- 再放送もあるため、ある番組が複数チャンネルの異なる番組枠で放映されることはある
- 番組の情報として、タイトル、番組詳細、ジャンルが画面上に表示される
- 各エピソードの情報として、シーズン数、エピソード数、タイトル、エピソード詳細、動画時間、公開日、視聴数が画面上に表示される。単発のエピソードの場合はシーズン数、エピソード数は表示されない
- ジャンルとしてアニメ、映画、ドラマ、ニュースなどがある。各番組は1つ以上のジャンルに属する
- KPIとして、チャンネルの番組枠のエピソードごとに視聴数を記録する。なお、一つのエピソードは複数の異なるチャンネル及び番組枠で放送されることがあるので、属するチャンネルの番組枠ごとに視聴数がどうだったかも追えるようにする

番組、シーズン、エピソードの関係について、以下のようなイメージです(シリーズになっているものの例)。

- 番組：鬼滅の刃
- シーズン：1
- エピソード：1話、2話、...、26話

## ステップ1

テーブル設計をしてください。

テーブルごとにテーブル名、カラム名、データ型、NULL(NULL OK の場合のみ YES と記載)、キー（キーが存在する場合、PRIMARY/INDEX のどちらかを記載）、初期値（ある場合のみ記載）、AUTO INCREMENT（ある場合のみ YES と記載）を記載してください。また、外部キー制約、ユニークキー制約に関しても記載してください。

その際に、少なくとも次のことは満たしてください。

- アプリケーションとして成立すること(プログラムを組んだ際に仕様を満たして動作すること)
- 正規化されていること

以下、アウトプット例です。

テーブル：users

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|bigint(20)||PRIMARY||YES|
|name|varchar(100)|||||
|email|varchar(100)||INDEX|||

- ユニークキー制約：email カラムに対して設定

テーブル：comments

|カラム名|データ型|NULL|キー|初期値|AUTO INCREMENT|
| ---- | ---- | ---- | ---- | ---- | ---- |
|id|bigint(20)||PRIMARY||YES|
|user_id|bigint(20)|YES|INDEX|0||
|content|text|||||

- 外部キー制約：user_id に対して、users テーブルの id カラムから設定


- ER図
https://www.figma.com/file/Qjz6w9RTM4sgjrOadYCvYX/Entity-Modeler-(%E3%82%B3%E3%83%9F%E3%83%A5%E3%83%8B%E3%83%86%E3%82%A3)?type=whiteboard&node-id=0-1&t=txSzgb96hjYW7dK6-0

## ステップ2

実際にテーブルを構築し、データを入れましょう。その手順をドキュメントとしてまとめてください（アウトプットは手順のドキュメントです）。

具体的には、以下のことを行う手順のドキュメントを作成してください。

1. データベースを構築します
```
mysql -u ユーザー名;
CREATE DATABASE internet_tv;
SHOW DATABASES;
USE internet_tv;
```
2. ステップ1で設計したテーブルを構築します
```
-- チャンネルテーブルの作成
CREATE TABLE Channels (
    channel_id INT PRIMARY KEY AUTO_INCREMENT,
    channel_name VARCHAR(255),
    channel_description TEXT
);

-- 番組テーブルの作成
CREATE TABLE Programs (
    program_id INT PRIMARY KEY AUTO_INCREMENT,
    program_name VARCHAR(255),
    program_description TEXT,
    genre_id INT,
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id)
);

-- ジャンルテーブルの作成
CREATE TABLE Genres (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(255)
);

-- シリーズテーブルの作成
CREATE TABLE Series (
    series_id INT PRIMARY KEY AUTO_INCREMENT,
    series_name VARCHAR(255),
    program_id INT,
    FOREIGN KEY (program_id) REFERENCES Programs(program_id)
);

-- エピソードテーブルの作成
CREATE TABLE Episodes (
    episode_id INT PRIMARY KEY AUTO_INCREMENT,
    season_number INT,
    episode_number INT,
    episode_title VARCHAR(255),
    episode_description TEXT,
    video_duration TIME,
    release_date DATE,
    view_count INT,
    program_id INT,
    FOREIGN KEY (program_id) REFERENCES Programs(program_id)
);

-- スケジュールテーブルの作成
CREATE TABLE Schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    channel_id INT,
    program_id INT,
    episode_id INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id),
    FOREIGN KEY (program_id) REFERENCES Programs(program_id),
    FOREIGN KEY (episode_id) REFERENCES Episodes(episode_id)
);

-- Channels テーブルへのサンプルデータの挿入
INSERT INTO Channels (channel_name, channel_description) VALUES
    ('ドラマ1', '人気ドラマチャンネル'),
    ('ドラマ2', '新作ドラマチャンネル'),
    ('アニメ1', 'アニメチャンネル1'),
    ('アニメ2', 'アニメチャンネル2'),
    ('スポーツ', 'スポーツ中継チャンネル'),
    ('ペット', 'ペット番組チャンネル');

-- Genres テーブルへのサンプルデータの挿入
INSERT INTO Genres (genre_name) VALUES
    ('アニメ'),
    ('映画'),
    ('ドラマ'),
    ('ニュース'),
    ('スポーツ'),
    ('ペット番組');

-- Programs テーブルへのサンプルデータの挿入
INSERT INTO Programs (program_name, program_description, genre_id) VALUES
    ('鬼滅の刃', '人気のアニメ「鬼滅の刃」', 1), -- ジャンルID 1 はアニメ
    ('ハリー・ポッターと賢者の石', '魔法の世界を描いたファンタジー映画', 2), -- ジャンルID 2 は映画
    ('プリズン・ブレイク', '脱獄をテーマにしたドラマシリーズ', 3), -- ジャンルID 3 はドラマ
    ('CNNニュース', '最新の国際ニュース', 4), -- ジャンルID 4 はニュース
    ('NBAライブ', 'NBAバスケットボールの生中継', 5), -- ジャンルID 5 はスポーツ
    ('ペットの世界', 'かわいいペットたちの日常', 6); -- ジャンルID 6 はペット番組

-- Series テーブルへのサンプルデータの挿入
INSERT INTO Series (series_name, program_id) VALUES
    ('鬼滅の刃', 1), -- シリーズ名「鬼滅の刃」に関連付けられた番組ID
    ('ハリー・ポッターシリーズ', 2), -- シリーズ名「ハリー・ポッターシリーズ」に関連付けられた番組ID
    ('プリズン・ブレイク', 3), -- シリーズ名「プリズン・ブレイク」に関連付けられた番組ID
    ('CNNニュース', 4), -- シリーズ名「CNNニュース」に関連付けられた番組ID
    ('NBAライブ', 5), -- シリーズ名「NBAライブ」に関連付けられた番組ID
    ('ペットの世界', 6); -- シリーズ名「ペットの世界」に関連付けられた番組ID

-- Episodes テーブルへのサンプルデータの挿入
INSERT INTO Episodes (season_number, episode_number, episode_title, episode_description, video_duration, release_date, view_count, program_id) VALUES
    (1, 1, '鬼の山', '鬼の襲撃から始まる物語', '00:25:00', '2023-01-15', 10000, 1), -- シーズン1、エピソード1
    (1, 2, '竈門炭治郎、隊士の訓練', '鬼殺隊の訓練生としての日々', '00:22:30', '2023-01-22', 9000, 1), -- シーズン1、エピソード2
    (1, 1, 'プラットフォーム9¾へようこそ', '魔法の学校への冒険', '00:30:45', '2023-02-10', 12000, 2), -- シーズン1、エピソード1
    (2, 3, '迷子の術', '脱獄計画が進行中', '00:28:15', '2023-02-15', 8500, 3), -- シーズン2、エピソード3
    (1, 1, '最新ニュース', '国際情勢のハイライト', '00:15:30', '2023-02-05', 5000, 4), -- シーズン1、エピソード1
    (1, 1, 'NBAプレーオフ', 'プレーオフの興奮が始まる', '00:35:20', '2023-03-01', 18000, 5), -- シーズン1、エピソード1
    (1, 1, 'ペットの日常', 'かわいいペットたちの日常', '00:20:00', '2023-02-20', 7500, 6); -- シーズン1、エピソード1

-- Schedule テーブルへのサンプルデータの挿入
INSERT INTO Schedule (channel_id, program_id, episode_id, start_time, end_time) VALUES
    (1, 1, 1, '2023-01-15 20:00:00', '2023-01-15 21:00:00'), -- チャンネル1、番組1、エピソード1
    (2, 2, 3, '2023-02-10 19:30:00', '2023-02-10 21:30:00'), -- チャンネル2、番組3、エピソード3
    (3, 3, 4, '2023-02-15 22:00:00', '2023-02-15 23:00:00'), -- チャンネル3、番組4、エピソード4
    (4, 4, 2, '2023-02-05 18:00:00', '2023-02-05 18:30:00'), -- チャンネル4、番組2、エピソード2
    (5, 5, 5, '2023-03-01 21:00:00', '2023-03-01 23:00:00'), -- チャンネル5、番組5、エピソード5
    (6, 6, 6, '2023-02-20 17:00:00', '2023-02-20 18:00:00'); -- チャンネル6、番組6、エピソード6


```

手順のドキュメントは、他の人が見た時にその手順通りに実施すればテーブル作成及びサンプルデータ格納が行えるように記載してください。

なお、ステップ2は以下のことを狙っています。

- データを実際に入れることでステップ3でデータ抽出クエリを試せるようにすること
- 手順をドキュメントにまとめることで、自身がやり直したい時にすぐやり直せること
- 手順を人が同じように行えるようにまとめることで、ドキュメントコミュニケーション力を上げること

## ステップ3

以下のデータを抽出するクエリを書いてください。

1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
```
SELECT episode_title, view_count
FROM Episodes
ORDER BY view_count DESC
LIMIT 3;
```
2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
```
SELECT
    P.program_name AS 番組タイトル,
    E.season_number AS シーズン数,
    E.episode_number AS エピソード数,
    E.episode_title AS エピソードタイトル,
    E.view_count AS 視聴数
FROM
    Episodes E
JOIN
    Programs P ON E.program_id = P.program_id
ORDER BY
    E.view_count DESC
LIMIT 3;

```
3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
```
SELECT
    C.channel_name AS チャンネル名,
    S.start_time AS 放送開始時刻,
    S.end_time AS 放送終了時刻,
    E.season_number AS シーズン数,
    E.episode_number AS エピソード数,
    E.episode_title AS エピソードタイトル,
    E.episode_description AS エピソード詳細
FROM
    Schedule S
JOIN
    Channels C ON S.channel_id = C.channel_id
JOIN
    Programs P ON S.program_id = P.program_id
JOIN
    Episodes E ON S.episode_id = E.episode_id
WHERE
    DATE(S.start_time) = CURDATE()
ORDER BY
    S.start_time;
```
4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください
```
SELECT
    C.channel_name AS チャンネル名,
    S.start_time AS 放送開始時刻,
    S.end_time AS 放送終了時刻,
    E.season_number AS シーズン数,
    E.episode_number AS エピソード数,
    E.episode_title AS エピソードタイトル,
    E.episode_description AS エピソード詳細
FROM
    Schedule S
JOIN
    Channels C ON S.channel_id = C.channel_id
JOIN
    Programs P ON S.program_id = P.program_id
JOIN
    Episodes E ON S.episode_id = E.episode_id
WHERE
    C.channel_name = 'ドラマ' AND
    DATE(S.start_time) BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY
    S.start_time;
```
5. (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください
6. (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。
