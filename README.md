# install elm

install by asdf

```
asdf plugin add elm
asdf list all elm
asdf install elm <version>
asdf local ghq <version>
```

# init project

```
elm init
```

# build

下記コマンドでindex.htmlが生成される

```
elm make src/Main.elm
```

ただしindex.htmlを生成した場合は独自のCSSを追加することができないため`--output`オプションを指定してjsファイルを生成することで自前のHTMLを利用することができる。

```
elm make src/Main.elm --output main.js
```

# start dev server

```
elm reactor
```
