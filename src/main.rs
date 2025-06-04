const N: i32 = 10000000;

// external C and CUDA function called
extern "C" {
    pub fn run_vector_add(a: *mut f32, b: *mut f32, out: *mut f32, size: ::std::os::raw::c_int);
}

fn main() {
    // prepare data for simple vector add
    let mut a: Vec<f32> = vec![1.0; N as usize];
    let mut b: Vec<f32> = vec![4.0; N as usize];
    
    // prepare output vector
    let mut out: Vec<f32> = vec![0.0; N as usize];
    
    // call vector add function with Rust Foreign Function Interface
    // memory transfers and allocations on GPU are included in this C++/CUDA file
    unsafe {
        run_vector_add(a.as_mut_ptr().cast::<f32>(), b.as_mut_ptr().cast::<f32>(), out.as_mut_ptr().cast::<f32>(), N);
    }
    
    // show data passed back to Rust
    // print one element to verify solution
    println!("{:?}", out[100]);
}


