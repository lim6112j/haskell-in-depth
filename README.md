# [haskell-in-depth](https://github.com/bravit/hid-examples)

# run
            stack build --fast --file-watch --exec haskell-in-depth-exe
            stack ghci --ghc-options -w   (warning off)
            <!-- with data file  -->
            stack exec haskell-in-depth-exe -- -r data/turn.txt North
            <!-- test ghci -->
            stack ghci haskell-in-depth:typeclass-test
