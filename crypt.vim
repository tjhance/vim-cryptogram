highlight link CryptInval Error
function UpdateHighlighting()
	let s = []
	let t = []
	for key in keys(b:current_mapping)
		for otherkey in keys(b:current_mapping)
			if key != otherkey && b:current_mapping[key] == b:current_mapping[otherkey]
				let s += [key]
				let t += [b:current_mapping[key]]
				break
			endif
		endfor
	endfor

    syntax clear CryptInval

	let i = 1
    while i <= line("$")
    	let j = 1
		let l = getline(i)
    	while j <= len(l)
    		let c = strpart(l, j-1, 1)
			if (i % 2 == 1 && index(s, c) != -1) || (i % 2 == 0 && index(t, c) != -1)
				let reg = "\\%" . i . "l\\%" . j . "c."
				exec 'syntax match CryptInval "' . reg . '"'
			endif
			let j += 1
    	endwhile
    	let i += 1
    endwhile
endfunction

function Update()
    let lines = getline(1, "$")
    let i = 1
    let codestr = ""
    let decodestr = ""
    for key in keys(b:current_mapping)
        let codestr = codestr . key
        let decodestr = decodestr . b:current_mapping[key]
    endfor
    for key in ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        if !has_key(b:current_mapping, key)
            let codestr = codestr . key
            let decodestr = decodestr . "."
        endif
    endfor
    while i <= line("$")
        call setline(i+1, tr(getline(i), codestr, decodestr))
        let i = i + 2
    endwhile
    call UpdateHighlighting()
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
        let b:current_mapping[y] = z
        call Update()
    endif
endfunction

function InitCrypt()
	let b:current_mapping = {}

	nnoremap <buffer> \a :call SetMapping("a")<enter>
	nnoremap <buffer> \b :call SetMapping("b")<enter>
	nnoremap <buffer> \c :call SetMapping("c")<enter>
	nnoremap <buffer> \d :call SetMapping("d")<enter>
	nnoremap <buffer> \e :call SetMapping("e")<enter>
	nnoremap <buffer> \f :call SetMapping("f")<enter>
	nnoremap <buffer> \g :call SetMapping("g")<enter>
	nnoremap <buffer> \h :call SetMapping("h")<enter>
	nnoremap <buffer> \i :call SetMapping("i")<enter>
	nnoremap <buffer> \j :call SetMapping("j")<enter>
	nnoremap <buffer> \k :call SetMapping("k")<enter>
	nnoremap <buffer> \l :call SetMapping("l")<enter>
	nnoremap <buffer> \m :call SetMapping("m")<enter>
	nnoremap <buffer> \n :call SetMapping("n")<enter>
	nnoremap <buffer> \o :call SetMapping("o")<enter>
	nnoremap <buffer> \p :call SetMapping("p")<enter>
	nnoremap <buffer> \q :call SetMapping("q")<enter>
	nnoremap <buffer> \r :call SetMapping("r")<enter>
	nnoremap <buffer> \s :call SetMapping("s")<enter>
	nnoremap <buffer> \t :call SetMapping("t")<enter>
	nnoremap <buffer> \u :call SetMapping("u")<enter>
	nnoremap <buffer> \v :call SetMapping("v")<enter>
	nnoremap <buffer> \w :call SetMapping("w")<enter>
	nnoremap <buffer> \x :call SetMapping("x")<enter>
	nnoremap <buffer> \y :call SetMapping("y")<enter>
	nnoremap <buffer> \z :call SetMapping("z")<enter>
	nnoremap <buffer> \. :call SetMapping(".")<enter>
	nnoremap <buffer> \\ :call Update()<enter>
endfunction

command Crypt call InitCrypt()
