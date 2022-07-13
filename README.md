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
| image              | text      | null: false                   |
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

- belongs_to :User
- has_one :logs
- belongs_to_active_hash :condition_id
- belongs_to_active_hash :preparation_day_id
- belongs_to_active_hash :prefecture_id
- belongs_to_active_hash :postage_type_id
- belongs_to_active_hash :category_id

## Logs テーブル

| Column             | Type       | Options                      |
| ------------------ | ---------- | ---------------------------- |
| user               | references | null:false/foreign_key: true |
| item_id            | references | null:false/foreign_key: true |


### Association

- belongs_to :User
- belongs_to :Item
- has_one :Destinations

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