<?php

var_dump(
    typst_compile_code(<<<TYP
= Hello World
Great to see ur
== Heading 2
TYP,
    "./", 
    "./outputs/out.pdf",
    "./outputs/out.svg",
    )
);