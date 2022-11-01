use rocket::{routes, launch, get, Config};


#[get("/health")]
fn health() -> String {
    String::from("RUNNING")
}

#[launch]
fn rocket() -> _ {
    let config = Config {
        port: 8000,
        ..Default::default()
    };
    rocket::custom(config)
        .mount("/", routes![health])
}
