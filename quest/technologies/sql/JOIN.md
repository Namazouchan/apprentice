# テーブルを結合できる

## 1. 内部結合

部署マネージャーテーブルに、従業員テーブルのデータを内部結合させた全データを取得してください。
```
SELECT
    *
FROM
    dept_manager AS DM INNER JOIN employees AS E
ON
    DM.emp_no = E.emp_no;
```
## 2. 列の選択

部署ごとに、部署番号、歴代のマネージャーの従業員番号、マネージャーのファーストネーム、マネージャーのラストネームを取得してください。
```
SELECT
    DM.dept_no, DM.emp_no, E.first_name, E.last_name
FROM
    dept_manager AS DM INNER JOIN employees AS E
ON
    DM.emp_no = E.emp_no;
```
## 3. 複数の内部結合

部署ごとに、部署番号、部署名、歴代のマネージャーの従業員番号、マネージャーのファーストネーム、マネージャーのラストネームを取得してください。
```
SELECT
    DE.dept_no, DE.dept_name, DM.emp_no, E.first_name, E.last_name
FROM
    dept_manager AS DM
INNER JOIN
    employees AS E
ON
    DM.emp_no = E.emp_no
INNER JOIN
    departments AS DE
 ON
    DM.dept_no = DE.dept_no;
```
## 4. 絞り込み

部署ごとに、部署番号、部署名、現在のマネージャーの従業員番号、マネージャーのファーストネーム、マネージャーのラストネームを取得してください。
```
SELECT
    DE.dept_no, DE.dept_name, DM.emp_no, E.first_name, E.last_name
FROM
    dept_manager AS DM
INNER JOIN
    employees AS E
ON
    DM.emp_no = E.emp_no
INNER JOIN
    departments AS DE
 ON
    DM.dept_no = DE.dept_no;
WHERE
    WHERE DM.to_date = '9999-01-01';
```
## 5. 給与

従業員番号10001から10010の従業員ごとに、ファーストネーム、ラストネーム、いつからいつまで給与がいくらだったかを取得してください。


## 6. 内部結合と外部結合の違い

INNER JOIN と OUTER JOIN の違いについて、SQL 初心者にわかるように説明してください。またどのように使い分けるのかも合わせて説明してください。
```
INNER JOIN と OUTER JOIN の違い
結合できなかった列を表示するのか表示しないのかの違い。
OUTER JOINで空白セルを表示する場合「NULL」となる。
行数固定の定型帳票などを作りたい場合に役にたつ
```
