extern crate cbindgen;

use std::env;

fn main() {
    let crate_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let target_dir = env::var("OUT_DIR").unwrap();
    cbindgen::generate(crate_dir)
        .unwrap()
        .write_to_file(target_dir + "/platform.h");
}
