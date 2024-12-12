use core::panic;
use std::fs;

const XMAS: &'static str = "XMAS";
const SMAX: &'static str = "SMAX";

fn main() {
    let m = fs::read_to_string("../assets/input_1.txt");

    if m.is_err() {
        panic!("Error opening file!");
    }
    
    let content = m.as_ref().unwrap();
    let lns: Vec<&str> = content.lines().collect();

    lns.iter().for_each(|ln|{

    });
    println!("{} line size: {}", lns.len(), lns[0].len() );;

}
