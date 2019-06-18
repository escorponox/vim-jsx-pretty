# vim-jsx-pretty-for-me

Fork of [MaxMEllon/vim-jsx-pretty](https://github.com/MaxMEllon/vim-jsx-pretty) tailored to my beloved Gruvbox setup

## Features

jsxCloseString works the way I like


## Syntax group list

|name|place|
|---|---|
|jsxElement| `<tag id="sample">text</tag>`<br />`~~~~~~~~~~~~~~~~~~~~~~~~~~~`|
|jsxTag| `<tag id="sample">`<br />`~~~~~~~~~~~~~~~~~`|
|jsxAttrib| `<tag id="sample">`<br />`_____~~__________`|
|jsxEqual| `<tag id="sample">`<br />`_______~_________`|
|jsxString| `<tag id="sample">`<br />`________~~~~~~~~_`|
|jsxCloseTag| `</tag>`<br />`~~~~~~` |
|jsxCloseString| `<tag />`<br />`_____~~` |
|jsxDot| `<Parent.Child>`<br />`_______~______` |
|jsxNamespace| `<foo:bar>`<br />`____~____` |
|jsxPunct| `<tag></tag>`<br />`~___~~~___~` |


## Configuration

|name|default|description|
|---|---|---|
|`g:vim_jsx_pretty_colorful_config`|0|colorful config flag|

Colorful style (**vim-javascript only**)

```vim
let g:vim_jsx_pretty_colorful_config = 1 " default 0
```

## LICENSE

[MIT](./LICENSE.txt)
