use juniper::{ graphql_object, GraphQLObject, ID, RootNode, EmptyMutation, EmptySubscription };
use chrono::prelude::*;
use sqlx::{ Postgres, Pool, FromRow };


/// GraphQL context type that houses the database pool among other things.
pub struct Context {    
    pub pool: Pool<Postgres>
}
impl Context {
    pub fn new(pool: Pool<Postgres>) -> Self {
        Self { pool }
    }
}
impl juniper::Context for Context {}




/// Main query type
pub struct Query;

#[graphql_object(context = Context)]
impl Query {

    pub async fn platform(context: &Context, id: ID) -> Option<Platform> {
        let id: i32 = id.parse().unwrap();
        sqlx::query_as("SELECT id, name, image_path FROM platform WHERE id = $1")
            .bind(id)
            .fetch_optional(&context.pool)
            .await
            .unwrap()
    }

    pub async fn title(context: &Context, id: ID) -> Option<Title> {
        let id: i32 = id.parse().unwrap();
        sqlx::query_as("SELECT id, name, image_path FROM title WHERE id = $1")
            .bind(id)
            .fetch_optional(&context.pool)
            .await
            .unwrap()
    }
}




/// Schema type alias
pub type Schema = RootNode<
    'static,
    Query,
    EmptyMutation<Context>,
    EmptySubscription<Context>
>;



#[derive(Clone, Debug, FromRow)]
pub struct Platform {
    pub id: i32,
    pub name: String,
    pub image_path: String
}

#[graphql_object(context = Context, description = "Platform that games / software can be released on. (NES, SNES, Genesis, PC, etc)")]
impl Platform {
    pub fn id(&self) -> i32 {
        self.id
    }
    pub fn name(&self) -> &str {
        &self.name
    }
    pub fn image_path(&self) -> &str {
        &self.image_path
    }
    pub async fn titles(&self, context: &Context) -> Vec<Title> {
        let query = "
        SELECT * FROM title_release tr INNER JOIN
        ";
        sqlx::query_as("SELECT id, name, image_path FROM title WHERE platform_id = $1")
            .bind(self.id)
            .fetch_all(&context.pool)
            .await
            .unwrap()
    }
}



#[derive(Debug, Clone, GraphQLObject, FromRow)]
#[graphql(description = "Game / software released for at least one platform.")]
pub struct Title {
    pub id: i32,
    pub name: String,
    pub image_path: String
}

pub struct TitleRelease {
    
}