use std::{collections::HashMap, ops::Deref};

use juniper::{ graphql_object, GraphQLObject, ID, FieldResult, RootNode, EmptyMutation, EmptySubscription };
use chrono::prelude::*;


/// Mock database
pub struct Database {
    pub platforms: HashMap<String, Platform>,
    pub titles: HashMap<String, Title>
}

pub struct Context {
    pub database: Database
}
impl Context {
    pub fn new() -> Self {
        Self {
            database: Database {
                platforms: HashMap::new(),
                titles: HashMap::new()
            }
        }
    }
}

/// Main query type
pub struct Query;

#[graphql_object(context = Context)]
impl Query {
    pub fn platform(context: &Context, id: ID) -> FieldResult<Option<&Platform>> {
        let result = context.database.platforms.get(id.deref());
        Ok(result)
    }
    pub fn title(context: &Context, id: ID) -> FieldResult<Option<&Title>> {
        let result = context.database.titles.get(id.deref());
        Ok(result)
    }
}


/// Schema type alias
pub type Schema = RootNode<
    'static,
    Query,
    EmptyMutation<Context>,
    EmptySubscription<Context>
>;


#[derive(GraphQLObject)]
#[graphql(description = "Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)")]
pub struct Platform {
    pub id: String,
    pub name: String,
    pub image_path: String,
    pub released: DateTime<Utc>
}

#[derive(GraphQLObject)]
#[graphql(description = "Game / software released for at least one platform.")]
pub struct Title {
    pub id: String,
    pub name: String,
    pub image_path: String,
    pub released: DateTime<Utc>
}