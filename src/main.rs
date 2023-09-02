use os_info;

fn main() {
    let info = os_info::get();
    println!("Type: {}", info.os_type());
    println!("Version: {}", info.version());
    println!("Edition: {:?}", info.edition());
    println!("Codename: {}", info.codename().unwrap_or_default());
    println!("Bitness: {}", info.bitness());
    println!("Architecture: {}", info.architecture().unwrap_or_default());
}
