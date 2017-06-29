# EPGRemote-for-iOS
iOS 用の EPGRemote クライアントアプリ

## これはなに？
iOS 用の EPGRemote のクライアントアプリです。WebView で表示しているだけの手抜きアプリです。

* 左右のスワイプで戻る, 進む
*  Pull to Refresh

設定で指定された URL を表示しているだけなので、EPGRemote 以外でも普通に表示されます。

## ビルド方法
EPGRemote.xcodeproj を Xcode で開いてビルドしてください。

実機に転送する方法は自分で調べてください。

## 設定
初回起動時に設定 -> EPGRemote に飛ばされるので以下のように URL を入力してください。

```
http://192.168.0.2:8888
```

## 環境
* Xcode 8.3.3
* Swift 3.1
* iOS 10 以降

## その他
なにかバグがあればお知らせください。

## Licence
MIT Licence

