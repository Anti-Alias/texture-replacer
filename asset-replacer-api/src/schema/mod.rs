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

    pub async fn platforms(context: &Context) -> Vec<Platform> {
        sqlx::query_as("SELECT id, name, image_path FROM platform")
            .fetch_all(&context.pool)
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

    pub async fn titles(context: &Context) -> Vec<Title> {
        sqlx::query_as("SELECT id, platform_id, name, version, released, image_path FROM title")
            .fetch_all(&context.pool)
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
        sqlx::query_as("SELECT id, platform_id, name, version, released, image_path FROM title WHERE platform_id = $1")
            .bind(self.id)
            .fetch_all(&context.pool)
            .await
            .unwrap()
    }
}



#[derive(Debug, Clone, FromRow)]
pub struct Title {
    pub id: i32,
    pub platform_id: i32,
    pub name: String,
    pub version: String,
    pub released: Option<DateTime<Utc>>,
    pub image_path: Option<String>
}

#[graphql_object(context = Context, description = "Game / software released for at least one platform.")]
impl Title {
    pub fn id(&self) -> i32 {
        self.id
    }
    pub fn name(&self) -> &str {
        &self.name
    }
    pub fn version(&self) -> &str {
        &self.version
    }
    pub fn released(&self) -> &Option<DateTime<Utc>> {
        &self.released
    }
    pub fn image_path(&self) -> Option<&str> {
        self.image_path.as_deref()
    }
    pub async fn platform(&self, context: &Context) -> Platform {
        sqlx::query_as("SELECT id, name, image_path FROM platform WHERE id = $1")
            .bind(self.platform_id)
            .fetch_one(&context.pool)
            .await
            .unwrap_or_else(|e| panic!("{}", e))
    }
}