# テーブル設計

## Users テーブル

| Column             | Type    | Options                   |
| ------------------ | --------| ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false               |
| password           | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_day          | date    | null: false               |

### Association

- has_many :items
- has_many :logs

## Items テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| name               | string  | null: false               |
| introduction       | text    | null: false               |
| price              | integer | null: false               |
| condition          | integer | null: false               |
| preparation_day    | integer | null: false               |
| postage_type       | integer | null: false               |
| category           | integer | null: false               |
| image              | text    | null: false               |

### Association

- belongs_to :Users
- has_one :logs

## Logd テーブル

| Column             | Type       | Options                      |
| ------------------ | ---------- | ---------------------------- |
| user_id            | references | null:false/foreign_key: true |
| items_id           | references | null:false/foreign_key: true |


### Association

- belongs_to :Users
- has_one :Items

## Destinations テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| post_code          | string  | null: false               |
| prefecture         | string  | null: false               |
| city               | string  | null: false               |
| address            | string  | null: false               |
| building_name      | integer |                           |
| phone_number       | integer | null: false               |


### Association

- has_one :logs