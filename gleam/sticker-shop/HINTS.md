# Hints

## 1. `Usd`、`Eur`、`Jpy`型を定義する

- `Usd`、`Eur`、`Jpy`型は、`pub type TypeName`という構文を使えば、コンストラクターなしで定義できます。

## 2. `Money`型を定義する

- `Money`型には、通貨のファントム型パラメーターを持たせます。

## 3. `dollar`、`euro`、`yen`関数を定義する

- `dollar`、`euro`、`yen`関数の戻り値の型注釈は、`Money(currency)`とします。ここで`currency`は、`Money`型の適切な型パラメーターです。

## 4. `total`関数を定義する

- `total`関数の戻り値の型注釈には、引数と同じ型パラメーターを使います。