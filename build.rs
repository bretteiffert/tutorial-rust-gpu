extern crate cmake;
use cmake::Config;

fn main()
{
    let dst = Config::new("libva").build();       

    println!("cargo:rustc-link-search=native={}", dst.display());
    println!("cargo:rustc-link-lib=static=va");

    println!("cargo:rustc-link-search=native={}", "/opt/nvidia/hpc_sdk/Linux_x86_64/24.5/cuda/lib64");
    println!("cargo:rustc-link-lib=cudart");

    println!("cargo:rustc-link-search=native={}", "/auto/software/swtree/ubuntu22.04/x86_64/gcc/13.2.0/lib64");
    println!("cargo:rustc-link-lib=dylib=stdc++");

    println!("cargo:rerun-if-changed={}", "./src");
}






