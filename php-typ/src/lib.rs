#![cfg_attr(windows, feature(abi_vectorcall))]
use ext_php_rs::prelude::*;

use std::fs;
use typst::layout::Abs;
use typst_as_library::TypstWrapperWorld;
use typst_pdf::PdfOptions;

#[php_function]
pub fn typst_compile_code(content: String, root: String, out_pdf_file: String, out_svg_file: Option<String>) -> () {
    // Create world with content.
    let world = TypstWrapperWorld::new(root, content);

    // Render document
    let document = typst::compile(&world)
        .output
        .expect("Error compiling typst");

    // Output to pdf and svg
    let pdf = typst_pdf::pdf(&document, &PdfOptions::default()).expect("Error exporting PDF");
    fs::write(out_pdf_file, pdf).expect("Error writing PDF.");
    println!("Created pdf: `./output.pdf`");

    if let Some(svg_file) = out_svg_file {
        let svg = typst_svg::svg_merged(&document, Abs::pt(2.0));
        fs::write(svg_file, svg).expect("Error writing SVG.");
        println!("Created svg: `./output.svg`");
    }
}

#[php_module]
pub fn get_module(module: ModuleBuilder) -> ModuleBuilder {
    module
}
