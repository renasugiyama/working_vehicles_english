## ■ サービス概要
「働く車」と英語を組み合わせた教育アプリで、子供が楽しく英語を学べるサービス。
親子で楽しく英語で働く車の質問に挑戦し、正解すると働く車の画像や動画が表示されます。

## ■ このサービスへの思い・作りたい理由

私は1児の母です。子供に言語学習に対する苦手意識をなくしてあげたいと考えており、
早期から英語に触れさせ、楽しく遊びながら学んでほしいと思っています。

息子は働く車が大好きで、最近は働く車について質問して、それに答える遊びをよくしています。
その興味を英語学習に結びつけることで、
楽しみながら英語が学ぶことができるのではないかと、このアイデアを思いつきました。

また、親子での質問に挑戦することで、楽しい時間を共有しながら自然に英語力を向上させ、親子の絆を深めたいと思っています。

## ■ ユーザー層について

- **親子（特に2～6歳の子供を持つ親）**：子供の教育に関心が高く、楽しく学べる方法を探しているため。
- **英語教育に関心がある家庭**：子供に英語を話せるようになってほしいという親のニーズに応えるため。
- **働く車が好きな子供**：子供が興味を持つテーマで学習することで、効果的な学習を促進します。

## ■ サービスの利用イメージ

親子でアプリにアクセスし、働く車の画像を見て、英語で出題される質問に答えます。
正解すると、アニメーションや音声が流れ、正解したことを知らせます。間違った場合は再チャレンジが可能です。
10問続けて正しい回答ができると、短い動画が再生されます。

ユーザー登録時は、親御さんの情報でアカウントを作成します。
アカウント作成後、複数のプレイヤー（子供）を登録できるようにすることで、家族全体でのサービス利用を可能にします。
ユーザー登録した人がログインし、プレイヤーを設定すると、今までの正解と不正解の回数を記録できます。

## ■ サービスの差別化ポイント・推しポイント

- **親子で楽しめる学習体験**：働く車にフォーカスした英語学習を通じて、親子での特別な時間を提供します。
- **インタラクティブな学習**：質問に答える形式で、学習効果を高める工夫がされています。
- **ビジュアルコンテンツ**：画像や動画を使って、子供が視覚的に学びやすい環境を提供します。
- **親子のコミュニケーション**：単なる学習アプリではなく、親子で一緒に楽しむことを目的としています。学習だけでなく、親子での対話と絆を深める機会を提供します。

## ■ 機能候補

### **MVPリリース時に作りたい機能**

1. ユーザー登録とログイン機能
2. ユーザーやプレイヤーのプロフィール画像を保存する機能
3. 質問・回答機能（英語での働く車に関する質問）
4. 正解時の画像・動画表示機能
5. 得点管理機能
6. 正解数のランキング機能

### **本リリースまでに作りたい機能**

1. 英単語の発音機能（音声再生）
2. 正解数に応じたリワード（ポイントやバッジ）の付与。
3. クイズの履歴を保存して、進捗を確認できる機能
4. 不正解時のヒント表示機能

## ■ 機能の実装方針予定

### **MVPリリース時に作りたい機能**

1. **ユーザー登録とログイン機能**
    sorceryを使用してユーザー認証システムを構築。
2. **ユーザーやプレイヤーのプロフィール画像を保存する機能**
    CarrierWaveを使用して画像保存機能を実装。
3. **質問・回答機能**    
    質問モデルと回答モデルを作成し、質問をランダムに選び、回答を判定して結果を表示するロジックを実装。    
4. **正解時の画像・動画表示機能**    
    正解時に表示する画像や動画を静的ファイルとして用意し、JavaScriptで表示する。
    YouTube APIを利用して動画を埋め込むことも考えられます。    
5. **得点管理機能**    
    RailsのActiveRecordを使用して、ユーザーモデルに得点フィールドを追加。正解時に得点を更新し、ビューで表示する。    

### **本リリースまでに作りたい機能**
1. **英単語の発音機能**   
    Web Speech API    
    - 正解時に英単語の発音を再生するためにWeb Speech APIを使用。
    - JavaScriptを使ってAPIを呼び出し、音声再生を行う。
2. **正解数に応じたリワード（ポイントやバッジ）の付与**    
    ユーザーモデルにリワード管理用のフィールドを追加し、正解数に応じてリワードを付与するロジックを実装。   
3. **クイズの履歴を保存して、進捗を確認できる機能**   
    RailsのActiveRecordを使用して、ユーザーごとのクイズ履歴をデータベースに保存。    
4. **不正解時のヒント表示機能**   
    質問モデルにヒント属性を追加し、不正解時に表示するヒントを用意。
