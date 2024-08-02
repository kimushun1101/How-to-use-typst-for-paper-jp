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

#let gothic = ("MS PGothic", "Hiragino Kaku Gothic Pro", "IPAexGothic", "Noto Sans CJK JP")
#let mincho = ("MS PMincho", "Hiragino Mincho Pro", "IPAexMincho", "Noto Serif CJK JP")
#set text(size: 24pt, font: mincho)
#import "@preview/sourcerer:0.2.1": code

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

LaTeX の代替として海外で Typst が流行り始めている

Typst の特徴
- テキストファイルをコンパイルして PDF を作成
- 環境構築が簡単
- 文法やエラー文がわかりやすい
- 公式ドキュメントが整備されている #footnote[https://typst.app/docs/]
- 公式がテンプレートやパッケージを管理している #footnote[https://typst.app/universe]
- 公式のクラウド環境もある
- 公式 Discord があり活発

== Word, LaTeX, Typst の比較

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

= 文法紹介

== マークアップ

マークアップ言語のように記述可能\

/* 表示がそれっぽく見えるようにズルしています */
#figure(
  // caption: [フォントの設定],
  table(
    columns: 3,
    stroke: none,
    table.header(
      [名称],
      [コード例],
      [レンダリング例],
    ),
    table.hline(),
    [見出し1], [`= Heading 1`], [#text(20pt, [*Heading 1*])],
    [見出し2], [`== Heading 2`], [#text(16pt, [Heading 2])],
    [段落区切り], [空行を挟む], [ ],
    [改行], [`\`], [ ],
    [raw テキスト], [$prime.rev$`text`$prime.rev$], [`text`],
    [箇条書きリスト], [`- item`], [ #sym.bullet item ],
    [番号つきリスト], [`+ item`], [ 1. item ],
    [強調（太文字）], [`*strong*`], [*strong*],
    [強調（斜体）], [`_emphasis_`], [#text(font: "Times New Roman", [_emphasis_])],
    [クオーテーション], [`'single'` or `"double"`], ['single' or "double"],
    [コメントアウト], [`/* block */` or `// line`], [ ],
  )
)

https://typst-jp.github.io/docs/reference/syntax/ を参考

== 数式のコード

数式番号をつけるような中央揃えの数式は，最初の`$` の後ろと閉じの`$` の前にスペースを挟み
#code(
  ```typ
    $ dot(x) &= A x + B u \
    y &= C x $ <eq:system>
  ```
)
のように書き，文中に書く数式は，`$` の前後にスペースを挟まず
#code(
  ```typ
    $x in RR^n$
  ```
)
というように書きます．

== 数式のレンダリング

以下のシステムを考える．
$ dot(x) &= A x + B u \
 y &= C x $ <eq:system>
ここで $x in RR^n$ は状態，$u in RR^m$ は入力，$y in RR^l$ は出力，$A in RR^(n times n)$，$B in RR^(n times m)$，および $C in RR^(l times n)$ は定数行列である．

== 図のコード

Typst 0.11.0 では PNG, JPEG, GIF, SVG の形式を挿入可能
#code(
  ```typ
    #figure(
      placement: bottom,
      image("figs/quadratic.svg", width: 90%),
      caption: [$x^2$ のグラフ],
    ) <fig:quadratic>

    #figure(
      placement: bottom,
      image("figs/sqrt-and-sin.png", width: 90%),
      caption: [$sqrt(x)$ と $sin x$ のグラフ],
    ) <fig:sqrt-sin>
  ```
)

== 図のレンダリング

#columns(2)[
#figure(
  placement: bottom,
  image("figs/quadratic.svg", width: 90%),
  caption: [$x^2$ のグラフ],
) <fig:quadratic>

#figure(
  placement: bottom,
  image("figs/sqrt-and-sin.png", width: 90%),
  caption: [$sqrt(x)$ と $sin x$ のグラフ],
) <fig:sqrt-sin>
]

== 表のコード

#code(
  ```typ
    #figure(
      placement: top,
      caption: [フォントの設定],
      table(
        columns: 3,
        stroke: none,
        table.header(
          [項目],
          [サイズ (pt)],
          [フォント],
        ),
        table.hline(),
        [タイトル], [18], [ゴシック体],
        [著者名], [12], [ゴシック体],
        [章タイトル], [12], [ゴシック体],
        [節，小節，本文], [10], [明朝体],
        [参考文献], [9], [明朝体],
      )
    ) <tab:fonts>
  ```
)

== 表のレンダリング
#figure(
  placement: top,
  caption: [フォントの設定],
  table(
    columns: 3,
    stroke: none,
    table.header(
      [項目],
      [サイズ (pt)],
      [フォント],
    ),
    table.hline(),
    [タイトル], [18], [ゴシック体],
    [著者名], [12], [ゴシック体],
    [章タイトル], [12], [ゴシック体],
    [節，小節，本文], [10], [明朝体],
    [参考文献], [9], [明朝体],
  )
) <tab:fonts>

== 引用

引用は "\@label" と記述する．

図のラベルとして `@fig:quadratic` とすれば@fig:quadratic，\
表のラベルとして `@tab:fonts` とすれば @tab:fonts となる．

数式や参考文献も同様．