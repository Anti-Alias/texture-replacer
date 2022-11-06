use std::ops::Deref;

use juniper::{ graphql_object, GraphQLObject, ID, FieldResult, RootNode, EmptyMutation, EmptySubscription };
use chrono::prelude::*;
use sqlx::{ Postgres, Pool, FromRow };


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
    pub fn title(context: &Context, id: ID) -> FieldResult<Option<&Title>> {
        todo!()
    }
}


/// Schema type alias
pub type Schema = RootNode<
    'static,
    Query,
    EmptyMutation<Context>,
    EmptySubscription<Context>
>;


//#[graphql(description = "Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)")]
#[derive(Clone, Debug, FromRow)]
pub struct Platform {
    pub id: i32,
    pub name: String,
    pub image_path: String
}

#[graphql_object(context = Context)]
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
    pub fn titles(&self, context: &Context) -> Vec<Title> {
        todo!()
    }
}

#[derive(Debug, Clone, GraphQLObject)]
#[graphql(description = "Game / software released for at least one platform.")]
pub struct Title {
    pub id: String,
    pub name: String,
    pub image_path: String,
    pub released: DateTime<Utc>
}