# テーブル設計

## Users テーブル

| Column             | Type    | Options                   |
| ------------------ | --------| ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many :items
- has_many :logs

## Items テーブル

| Column             | Type      | Options                       |
| ------------------ | --------- | ----------------------------- |
| name               | string    | null: false                   |
| introduction       | text      | null: false                   |
| price              | integer   | null: false                   |
| condition_id       | integer   | null: false                   |
| preparation_day_id | integer   | null: false                   |
| prefecture_id      | integer   | null: false                   |
| postage_type_id    | integer   | null: false                   |
| category_id        | integer   | null: false                   |
| user               | reference | null: false/foreign_key: true |

### Association

- has_one :user
- has_one :log


## Logs テーブル

| Column             | Type       | Options                      |
| ------------------ | ---------- | ---------------------------- |
| user               | references | null:false/foreign_key: true |
| item               | references | null:false/foreign_key: true |


### Association

- belongs_to :user
- has_one :item
- has_one :destination

## Destinations テーブル

| Column             | Type       | Options                      |
| ------------------ | ---------- | ---------------------------- |
| post_code          | string     | null: false                  |
| prefecture         | integer    | null: false                  |
| city               | string     | null: false                  |
| address            | string     | null: false                  |
| building_name      | integer    |                              |
| phone_number       | integer    | null: false                  |
| logs               | references | null:false/foreign_key: true |

### Association

- belongs_to :log