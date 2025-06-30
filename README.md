# [haskell-in-depth](https://github.com/bravit/hid-examples)

# run

            stack build --fast --file-watch --exec haskell-in-depth-exe
			stack build --fast --file-watch --exec ch07
	        stack build --fast --file-watch --ghc-options -w  --exec tempphanto
	        stack ghci --ghc-options -w   (warning off)
            <!-- with data file  -->
            stack exec haskell-in-depth-exe -- -r data/turn.txt North
            <!-- test ghci -->
            stack ghci haskell-in-depth:typeclass-test

<!-- ghci executable person-derived -->

            stack repl :person-derived
            <!-- run suntimes  -->
            stack exec -- suntimes -c data/config.json -f data/cities.txt
