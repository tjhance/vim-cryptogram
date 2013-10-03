let g:current_mapping = {}

function Update()
    let lines = getline(1, "$")
    let i = 1
    let codestr = ""
    let decodestr = ""
    for key in keys(g:current_mapping)
        let codestr = codestr . key
        let decodestr = decodestr . g:current_mapping[key]
    endfor
    for key in ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        if !has_key(g:current_mapping, key)
            let codestr = codestr . key
            let decodestr = decodestr . "."
        endif
    endfor
    while i <= line("$")
        call setline(i+1, tr(getline(i), codestr, decodestr))
        let i = i + 2
    endwhile
endfunction

function SetMapping(z)
    let z = tolower(a:z)
    let cursorpos = getpos(".")
    let lnum = cursorpos[1]
    let column = cursorpos[2]
    let code_lnum = lnum % 2 == 0 ? lnum - 1 : lnum
    let code_line = getline(code_lnum)
    if column <= strlen(code_line)
        let y = tolower(strpart(code_line, column - 1, 1))
        let g:current_mapping[y] = z
        call Update()
    endif
endfunction

nnoremap \a :call SetMapping("a")<enter>
nnoremap \b :call SetMapping("b")<enter>
nnoremap \c :call SetMapping("c")<enter>
nnoremap \d :call SetMapping("d")<enter>
nnoremap \e :call SetMapping("e")<enter>
nnoremap \f :call SetMapping("f")<enter>
nnoremap \g :call SetMapping("g")<enter>
nnoremap \h :call SetMapping("h")<enter>
nnoremap \i :call SetMapping("i")<enter>
nnoremap \j :call SetMapping("j")<enter>
nnoremap \k :call SetMapping("k")<enter>
nnoremap \l :call SetMapping("l")<enter>
nnoremap \m :call SetMapping("m")<enter>
nnoremap \n :call SetMapping("n")<enter>
nnoremap \o :call SetMapping("o")<enter>
nnoremap \p :call SetMapping("p")<enter>
nnoremap \q :call SetMapping("q")<enter>
nnoremap \r :call SetMapping("r")<enter>
nnoremap \s :call SetMapping("s")<enter>
nnoremap \t :call SetMapping("t")<enter>
nnoremap \u :call SetMapping("u")<enter>
nnoremap \v :call SetMapping("v")<enter>
nnoremap \w :call SetMapping("w")<enter>
nnoremap \x :call SetMapping("x")<enter>
nnoremap \y :call SetMapping("y")<enter>
nnoremap \z :call SetMapping("z")<enter>
nnoremap \. :call SetMapping(".")<enter>
nnoremap \\ :call Update()<enter>
