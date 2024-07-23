#import "@preview/touying:0.4.2": *

#let s = themes.university.register(aspect-ratio: "16-9")
#let s = (s.methods.numbering)(self: s, section: "1.", "1.1")

// Global information configuration
#let s = (s.methods.info)(
  self: s,
  title: [Typst で論文を書く],
  // subtitle: [Subtitle],
  author: [Shunsuke Kimura],
  // date: datetime(year: 2024, month: 8, day: 3),
  date: datetime.today(),
  // institution: [Institution],
)

// Extract methods
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show table: set text(size: 18pt)
#show figure.where(kind: table): set figure.caption(position: top)
#show strong: alert

// Extract slide functions
#let (slide, empty-slide) = utils.slides(s)
#show: slides

== 背景

#columns(2)[
  #image("figs/post_x.png")
  #image("figs/post_discord.png")
]

制御工学の論文執筆には LaTeX を使用する人が多い．\
数式や図を多用することから好まれる傾向がある？\
一方，習得コストが高め（研究室配属時に訓練される）

== Typst

LaTeX の代替として海外で Typst が流行り始めている\

Typst の特徴
- テキストファイルをコンパイルして PDF を作成（LaTeX に近い）
- 環境構築が簡単
- 文法やエラー文がわかりやすい
- 公式ドキュメントが整備されている #footnote[https://typst.app/docs/]
- 公式 Discord があり活発
- テンプレートやパッケージの管理がされている #footnote[https://typst.app/universe]


== Word, LaTeX, Typst の比較

// #set text(5pt)
// #show table: set text(size: 9pt)
#figure(
  placement: top,
  // caption: [Word, LaTeX, Typst の比較],
  table(
    columns: 5,
    stroke: none,
    table.header(
      [],
      [],
      [Word],
      [LaTeX],
      [Typst],
    ),
    table.hline(),
    [1],[Word が LaTeX より優れている部分], [], [], [],
    [],[知名度，テンプレートの多さ], [⊚], [○], [△],
    [],[インストールの簡単さ], [○], [△], [⊚],
    [],[習得の容易さ], [○], [△], [⊚],
    table.hline(),
    [2],[LaTeX が Word より優れている部分], [], [], [],
    [],[マルチプラットフォーム対応], [△], [○], [⊚],
    [],[ソフトウェア使用料], [有料], [無料], [無料],
    [],[ファイル形式], [.docx (バイナリ)], [.tex (テキスト)], [.typ (テキスト)],
    [],[体裁の整えやすさ], [△], [⊚], [⊚],
    table.hline(),
    [3],[Typst が LaTeX より優れている部分], [], [], [],
    [],[文法のシンプルさ], [‐], [○], [⊚],
    [],[エラー文のわかりやすさ], [‐], [△], [⊚],
    [],[コンパイルの速さ], [‐], [△], [⊚],
  )
) <tab:comparison>

∗#text(12pt)[作成時現在の状況です．書き手の独断と偏見を含みます．]

== Typst の使い方

=== 環境構築
+ #link("https://code.visualstudio.com/")[VS Code] をインストール
+ 拡張機能 #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[Tinymist Typst] をインストール#footnote[Tinymist は VS Code 以外にも Helix や Neovim プラグインもあるようです． https://github.com/Myriad-Dreamin/tinymist]

=== 執筆方法
+ main.typ などの typ ファイルを作成
+ ファイルを開いたエディターの 0 行目にある `preview` で表示#footnote[エディター右上のアイコンやショートカットキーは`Ctrl + K, V` でも実行可能です．]
+ 0 行目にある `Export PDF` でファイル保存#footnote[保存したときにPDF出力する設定もあります．]

== 学会の Typst テンプレートサンプルを作ってみた

#columns(2)[
  #image("figs/github.png")
  https://github.com/kimushun1101/typst-jp-conf-template \ \
  以下の国内学会論文に似せた\ テンプレートを作成
  - 日本ロボット学会学術講演会#footnote[公式で Typst フォーマットが提供されました．\ #h(10mm) https://ac.rsj-web.org/2024/manuscript.html]
  - 自動制御連合講演会
  - 制御部門マルチシンポジウム
]

== 個人的なこだわりポイント

=== Abstruct や Keywords の体裁
学会によってここらへんも微妙に変化するため細かく対応

=== 本文に Typst のコード例
文法をコピペするために，コード例 #footnote[図，表，数式，定理など] をたくさん書きました．\
追加リクエストなどあればください．


=== 参考文献の体裁
自動で引用順になります．
CSL ファイルで体裁も整えています．
引用の表記も [1] だったり，上付き 1) だったり．
