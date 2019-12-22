# 修士論文テンプレート #

修士論文 LaTeX テンプレート｜名古屋大学宇宙地球環境研究所の理学系修士学生用
[Webサイト](https://github.com/akira-okumura/MasterThesisTemplate)


## PDFファイル作成手順 ##
# コマンドプロンプトで1つずつ実行する方法
BibTeXを使っているので，

1. 文献データベース（bibファイル）を用意する．
2. `uplatex` を実行し，参照情報をauxファイルに書き出す．
3. `pbibtex` を実行し，bblファイルを作る．
4. `uplatex` を実行し，bblファイルを取り込む．
5. `uplatex` を実行し，相互参照の解決をする．
6. `dvipdfmx` を実行し，pdfファイルを作る．

といった流れでコンパイルを行い，pdfファイルを作成します．
拡張子はなくても実行できる．
以下，具体的に説明します．

まず，文献データベース `thesis.bib` に文献を列挙していきます．論文や書
籍のBibTeX情報は，たいていWebからダウンロードできます．コピペしていきま
しょう．

`thesis.bib` を書き終わったら，auxファイルを作ります．以下のように
`uplatex` を実行します．

	$ uplatex main.tex

つぎに， `upbibtex` を実行してbblファイルを作ります．

	$ upbibtex main.aux

そして， `uplatex` を *2回* 実行してdviファイルを作ります．

	$ uplatex main.tex
	$ uplatex main.tex

最後に，pdfファイルを作成するには `dvipdfmx` コマンドを使います．

	$ dvipdfmx main.dvi

参考文献を更新する必要がなければ，以降は，

	$ uplatex main.tex
	$ dvipdfmx main.dvi

のようにすればpdfファイルが作成できます．

# Makefileを作成して実行する方法

[Webサイト]https://texwiki.texjp.org/?Make#b022f4c0

上記のサイトで各自OSに合わせてMakefileを実行できる環境を作る。
あとはコマンドで
	$ make

## ライセンス ##

二条項BSDライセンス（BSD 2-clause License）です．

## jsonファイルにエンコード内容をまとめる ##
{
	"latex-workshop.latex.tools": [
		{
			"name":"ptex2pdf (uplatex)",
			"command": "ptex2pdf",
			"args": [
				"-l",
				"-u",
				"-ot",
				"-kanji=utf8 -synctex=1",
				"%DOC%"
			]
		},
		{
			"command": "pbibtex",
            "args": [
                "-kanji=utf8",
                "%DOCFILE%"
            ],
            "name": "pbibtex"
		},
		{
			"command": "dvipdfmx",
			"args": [
				"%DOCFILE%.dvi"
			],
			"name": "dvipdfmx"
		}
	],
	"latex-workshop.latex.recipes": [
		{
			"name": "upLaTeX & pBibTeX",
			"tools": [
				"ptex2pdf (uplatex)",
				"pbibtex",
				"ptex2pdf (uplatex)",
				"ptex2pdf (uplatex)"
			]
		},
	]
}

## その他よび追記 ##
PROBLEMSのWarningにおいて、１つだけ削除できなかったので記述しておく。
`caption.sty`において、下記の注意が表示されるが無視していい。

Unsupported document class (or package) detected,
(caption)	usage of the caption package is not recommended.
See the caption package documentation for explanation.