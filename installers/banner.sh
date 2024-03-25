#! /bin/bash

set -euo pipefail

# Banner
function print_ascii_banner() {
    echo -e "${BLUE}
                    /-
                   ooo:
                  yoooo/
                 yooooooo
                yooooooooo
               yooooooooooo
             .yooooooooooooo
            .oooooooooooooooo          Welcome to my dotfiles!
           .oooooooarcoooooooo         author: github.com/containerscrew
          .ooooooooo-oooooooooo
         .ooooooooo-  oooooooooo
        :ooooooooo.    :ooooooooo
       :ooooooooo.      :ooooooooo
      :oooarcooo         .oooarcooo
     :ooooooooy           .ooooooooo
    :ooooooooo   /ooooooooooooooooooo
   :ooooooooo      .-ooooooooooooooooo.
  ooooooooo-             -ooooooooooooo.
 ooooooooo-                 .-oooooooooo.
ooooooooo.                     -ooooooooo
${NC}"
}