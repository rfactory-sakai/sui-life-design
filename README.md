# SUI フロントエンド引き継ぎ

Claude Codeでこのフォルダーを開いて作業を続けられます。外部ライブラリー・ビルド・npm install は不要です。Node.js 18以降を使用してください。

## 起動

```sh
npm start
```

- 比較一覧: http://localhost:4173/board.html
- トップ実寸: http://localhost:4173/index.html
- 停止: Ctrl+C
- 4173番が使用中の場合は PORT 環境変数を変更してください。

```sh
npm run check
```

JavaScript構文とローカルファイルへのリンクを確認します。ブラウザーのレイアウト・操作確認は別途必要です。

## 構成

- public/index.html: トップ
- public/service.html: サービス
- public/works.html: 実績・事例（架空のモデルケース）
- public/company.html: 会社概要（仮設定）
- public/contact.html: お問い合わせ（送信しないデモ）
- public/style.css: 全ページ共通のデザイン・レスポンシブ・アニメーション
- public/app.js: メニュー・スクロールフェード・事例絞り込み・フォーム確認
- public/board.html: 5ページ × PC 1440px / モバイル 390pxの比較一覧
- server.cjs: ローカル確認用の簡易静的サーバー
- scripts/check.cjs: 軽量チェック
- CLAUDE.md: 作業時の前提と引き継ぎ事項
- HANDOFF_PROMPT.md: Claude Codeへ渡す開始プロンプト

比較一覧は iframe で同じHTMLを各幅で表示し、縮小して並べています。「ページ全体」「ファーストビュー」を切り替え可能です。比較用iframe内ではフェード要素を表示し、ヒーローアニメーションを止め、ヒーロー高を固定しています。実寸ページでは元の動きが有効です。

## デザイン要件

目的: 個人向けサービス・生活関連の問い合わせ・相談の獲得。
テイスト: スタイリッシュ・クール、シンプル、信頼感。
配色: 白、ネイビー #102c3e、青 #226b9b。
ヒーロー: 住空間写真の緩やかなズーム。動画ファイルは使用していません。
レスポンシブ: 主なブレークポイント900px・640px。比較一覧は700px以下で縦並び。
スクロール時フェード、各セクションの問い合わせ導線、動きを減らすOS設定への対応あり。
最新のユーザー意図: サイト機能全体を拡張するより、PC・モバイルの画面デザインを一度に確認・比較できることを優先。

## 未実装・確認事項

- SUIは架空ブランド。社名、会社情報、サービス、事例は正式情報へ差し替えが必要です。
- フォームは必須入力・形式チェックと確認表示のみ。送信API、保存、メール通知はありません。
- 認証、CMS、予約、決済などのバックエンドはありません。
- 写真は Unsplash から取得して public/images に同梱しています。正式運用時は画像選定・利用条件を確認してください。
- 公開済みですが、前環境ではブラウザー表示・操作のQAが完了していません。
- 本パッケージのチェックは構文とリンクの確認です。PC幅1440px、モバイル幅390px・375pxで目視・操作確認してください。

## 参照

- 現在の比較一覧: https://sui-life-design-1029.nobleacorn65.chatgpt.site/board.html
- 参考指定: https://sankoudesign.com/web/kon/
- 参考指定: https://sankoudesign.com/web/eskkumamoto/

Sitesの認証情報・Git管理情報・ホスティングIDは同梱していません。任意の静的ホスティングで public/ を配信できます。server.cjs はローカル確認用です。

## 公開（Render）

- URL: https://sui-life-design.onrender.com
- main ブランチへの push で自動デプロイ（公開ディレクトリ: public）
