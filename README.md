vim-cryptogram
==============

plugin to help solving cryptograms manually, in vim

How to use
==============

- Put in .vim/plugin/
- In a vim buffer, type :Crypt to begin a session.
- Ciphertext goes on the odd-numbered lines and decoded text on the even ones. The first line will always be "abcdefghijklmnopqrstuvwxyz" so you can look at the second line to see the current mapping. Type your ciphertext that you want to decode on, for example, the third line. Cursor-over a character (e.g., d) and type a backslash followed by a character (e.g., \\c) to map d to c.
- Type \\. to unmap a ciphertext character.
- Cursor-over a word and type \\, to find matches for that word. This uses the cryptgrep.py script included in this repo. Also, to use this feature you will need to set the "dict\_path" variable to point to whatever dictionary you want to use, at the top of crypt.vim.
