use juniper::{ EmptyMutation, EmptySubscription };
use juniper_rocket::{ GraphQLRequest, GraphQLResponse };
use rocket::{ routes, launch, post, State };
use asset_replacer_api::schema::{ Schema, Context, Query };
use sqlx::postgres::PgPoolOptions;
    
#[post("/graphql", data="<request>")]
async fn post_graphql_handler(
    context: &State<Context>,
    schema: &State<Schema>,
    request: GraphQLRequest
) -> GraphQLResponse {
    request.execute(&schema, &context).await
}

#[launch]
async fn rocket() -> _ {

    // Configures GraphQL context with a mock database
    let context = {
        let connection_str = dotenvy::var("DATABASE_URL").expect("Environment variable DATABASE_URL not set");
        let pool = PgPoolOptions::new()
            .max_connections(32)
            .connect(&connection_str)
            .await
            .unwrap_or_else(|e| panic!("{}", e));
        Context::new(pool)
    };

    // Creates GraphQL schema
    let schema = Schema::new(
        Query,
        EmptyMutation::new(),
        EmptySubscription::new()
    );

    // Starts server
    rocket::build()
        .manage(schema)
        .manage(context)
        .mount("/", routes![post_graphql_handler])
}
