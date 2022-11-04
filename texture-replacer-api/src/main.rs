use rocket::{routes, launch, get};


#[get("/health")]
fn health() -> &'static str {
    "RUNNING"
}

#[launch]
fn rocket() -> _ {
    rocket::build().mount("/", routes![health])
}
