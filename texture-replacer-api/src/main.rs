use chrono::Utc;
use juniper::{ EmptyMutation, EmptySubscription };
use juniper_rocket::{ GraphQLRequest, GraphQLResponse };
use rocket::{ routes, launch, post, State };
use texture_replacer_api::schema::{ Schema, Context, Platform, Query };

#[post("/graphql", data="<request>")]
fn post_graphql_handler(
    context: &State<Context>,
    schema: &State<Schema>,
    request: GraphQLRequest
) -> GraphQLResponse {
    request.execute_sync(&schema, &context)
}

#[launch]
fn rocket() -> _ {

    // Configures GraphQL context
    let mut context = Context::new();
    context.database.platforms.insert(
        "0".into(),
        Platform {
            id: "0".into(),
            name: "NES".into(),
            image_path: "/path/to/NES.png".into(),
            released: Utc::now()
        }
    );

    // Creates GraphQL schema
    let schema = Schema::new(Query, EmptyMutation::new(), EmptySubscription::new());

    // Starts server
    rocket::build()
        .manage(schema)
        .manage(context)
        .mount("/", routes![post_graphql_handler])
}
