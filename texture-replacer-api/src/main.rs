use rocket::{routes, launch, get, post};


#[get("/health")]
fn health() -> String {
    String::from("RUNNING")
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![health])
}
