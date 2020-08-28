# 制作メンバー
## MItsusawa-5
### 実装内容
スクラムマスター
デプロイ担当AWS EC2〜S3導入
クレジットカード登録（Payjp)
クレジットカード情報表示(Payjp)
商品購入機能実装（Payjp)
商品出品機能_サーバーサイド＆マークアップ
商品詳細ページ_マークアップ

## MatsunamiDaiki
### 実装内容
商品カテゴリ機能_マークアップ&サーバーサイド
商品出品機能
商品詳細表示
README編集

## issa133
### 実装内容
商品詳細表示
マイページ作成
商品削除機能
マイページ_本人情報の実装
ユーザー新規登録/ログインページ_マークアップ＆サーバーサイド

## key390
### 実装内容
商品編集機能
商品一覧ページ
TOPページ_マークアップ
ER図作成
README編集

## kyo11
### 実装内容
コメント機能
商品購入画面_マークアップ
TOPページ_マークアップ
CSSコーディング修正


## users table
|Column|Type|Options|
|------|----|-------|
|nickname|string|null false|
|firstname|string|null false|
|lastname|string|null false|
|first_hurigana|string|null false|
|last_hurigana|string|null false|
|birthday|date|null false|
|email|string|null false, unique true|
|password|string|null false, unique true, length:minimum:7|

### Association
- has_one :address
- has_many :cards
- has_many :items

## cards table
|Column|Type|Options|
|------|----|-------|
|customer_id|string|null false|
|card_id|string|null false|
|user_id|integer|null false, foreign_key true|

### Association
- belongs_to :user

## addresses table

|Column|Type|Options|
|------|----|-------|
|post|integer|null false|
|prefectures|string|null false|
|city|string|null false|
|number|string|null false|
|building|string|null false|
|phone|string|unique true|
|user_id|integer|null false, foreign_key true|

### Association
- belongs_to :user

## items table
|Column|Type|Options|
|------|----|-------|
|name|string|null false|
|explain|text|null false|
|delivery_cost_id|integer|null false|
|area_id|integer|null false|
|limit_id|integer|null false|
|status_id|integer|null false|
|price|integer|null false|
|user_id|integer|null false,foreign_key true|
|category_id|integer|null false, foreign_key true|
|brand|string|
|buyer_id|integer||

### Association
- belongs_to :user
- belongs_to :category
- has_many :images

## categories table
|Column|Type|Options|
|------|----|-------|
|name|string|null false|

### Association
- has_many :items

## images table
|Column|Type|Options|
|------|----|-------|
|name|text|null false|
|item_id|integer|null false, foreign_key true


### Association
- belongs_to :item