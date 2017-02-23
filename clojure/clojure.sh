#!/bin/bash

wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod u+x lein
sudo mv lein /usr/local/bin/
lein version
