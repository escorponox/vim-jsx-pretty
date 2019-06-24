function! jsx_pretty#syntax#highlight()

  " <tag id="sample">
  " ~~~~~~~~~~~~~~~~~
  " and self close tag
  " <tag id="sample"   />
  " ~~~~~~~~~~~~~~~~~~~
  syntax region jsxTag
        \ start=+<+
        \ matchgroup=jsxOpenPunct
        \ end=+>+
        \ matchgroup=NONE
        \ end=+\(/\_s*>\)\@=+
        \ contained
        \ contains=jsxOpenTag,jsxEscapeJs,jsxAttrib,jsComment,@javascriptComments,javaScriptLineComment,javaScriptComment,typescriptLineComment,typescriptComment,jsxSpreadOperator
        \ keepend
        \ extend

  " <tag></tag>
  " ~~~~~~~~~~~
  " and fragment
  " <></>
  " ~~~~~
  " and self close tag
  " <tag />
  " ~~~~~~~
  syntax region jsxElement
        \ start=+<\_s*\(>\|\${\|\z(\<[-:_\.\$0-9A-Za-z]\+\>\)\)+
        \ end=+/\_s*>+
        \ end=+<\_s*/\_s*\z1\_s*>+
        \ contains=jsxElement,jsxEscapeJs,jsxTag,jsxComment,jsxCloseString,jsxCloseTag,@Spell
        \ keepend
        \ extend
        \ contained
        \ fold

  " detect jsx region
  syntax region jsxRegion
        \ start=+\(\(\_[([,?:=+\-*/<>{}]\|&&\|||\|=>\|\<return\|\<default\|\<await\|\<yield\)\_s*\)\@<=<\_s*\(>\|\z(\(script\)\@!\<[_\$A-Za-z][-:_\.\$0-9A-Za-z]*\>\)\(\_s*\([-+*)\]}&|?]\|/\([/*]\|\_s*>\)\@!\)\)\@!\)+
        \ end=++
        \ contains=jsxElement

  " <tag key={this.props.key}>
  "          ~~~~~~~~~~~~~~~~
  syntax region jsxEscapeJs
        \ start=+{+
        \ end=++
        \ extend
        \ contained
        \ contains=jsBlock,javascriptBlock,javaScriptBlockBuildIn,typescriptBlock

  " <tag key={this.props.key}>
  " ~~~~
  " and fragment start tag
  " <>
  " ~~
  exe 'syntax region jsxOpenTag
        \ matchgroup=jsxOpenPunct
        \ start=+<+
        \ end=+>+
        \ matchgroup=NONE
        \ end=+\>+
        \ contained
        \ contains=jsxTagName
        \ nextgroup=jsxAttrib
        \ skipwhite
        \ skipempty '
 
  " <foo.bar>
  "     ~
  syntax match jsxDot +\.+ contained display

  " <foo:bar>
  "     ~
  syntax match jsxNamespace +:+ contained display

  " <tag id="sample">
  "        ~
  syntax match jsxEqual +=+ contained display nextgroup=jsxString,jsxEscapeJs,jsxRegion skipwhite

  " <tag />
  "      ~~
  syntax match jsxCloseString +/\_s*>+ contained 

  " </tag>
  " ~~~~~~
  " and fragment close tag
  " </>
  " ~~~
  syntax region jsxCloseTag
        \ matchgroup=jsxClosePunct
        \ start=+<\_s*/+
        \ end=+>+
        \ contained
        \ contains=jsxTagName

  " <tag key={this.props.key}>
  "      ~~~
  syntax match jsxAttrib
        \ +\<[-A-Za-z_][-:_\$0-9A-Za-z]*\>+
        \ contained
        \ nextgroup=jsxEqual
        \ skipwhite
        \ skipempty
        \ contains=jsxAttribKeyword
        \ display

  " <tag id="sample">
  "         ~~~~~~~~
  " and 
  " <tag id='sample'>
  "         ~~~~~~~~
  syntax region jsxString start=+\z(["']\)+  skip=+\\\%(\z1\|$\)+  end=+\z1+ contained contains=@Spell display

  " Highlight the tag name
  highlight def link jsxTag Function

  highlight def link jsxAttrib GruvboxYellow
  highlight def link jsxAttribKeyword jsxAttrib
  highlight def link jsxEqual GruvboxOrange
  highlight def link jsxString String
  highlight def link jsxDot Operator
  highlight def link jsxNamespace Operator

  " Highlight the jsxCloseString (i.e. />), jsxPunct (i.e. <,>) and jsxCloseTag (i.e. <//>)
  highlight def link jsxCloseString GruvboxRed
  highlight def link jsxPunct jsxCloseString
  highlight def link jsxOpenPunct GruvboxBlue
  highlight def link jsxOpenTag GruvboxBlue
  highlight def link jsxClosePunct jsxPunct
  highlight def link jsxCloseTag jsxCloseString

  highlight def link jsxComment Comment
  highlight def link jsxSpreadOperator Operator

  let s:vim_jsx_pretty_colorful_config = get(g:, 'vim_jsx_pretty_colorful_config', 0)

  if s:vim_jsx_pretty_colorful_config == 1
    highlight def link jsObjectKey GruvboxBlue
    highlight def link jsArrowFuncArgs GruvboxYellow
    highlight def link jsFuncArgs GruvboxOrange
  endif

endfunction
