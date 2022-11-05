use std::{collections::HashMap, ops::Deref};

use juniper::{ graphql_object, GraphQLObject, ID, FieldResult, RootNode, EmptyMutation, EmptySubscription };
use chrono::prelude::*;


/// Mock database
pub struct Database {
    pub platforms: HashMap<String, Platform>,
    pub titles: HashMap<String, Title>,
    pub title_platforms: Vec<(String, String)>
}

pub struct Context {
    pub database: Database
}
impl Context {
    pub fn new() -> Self {
        Self {
            database: Database {
                platforms: HashMap::new(),
                titles: HashMap::new(),
                title_platforms: Vec::new()
            }
        }
    }
}
impl juniper::Context for Context {}

/// Main query type
pub struct Query;

#[graphql_object(context = Context)]
impl Query {
    pub fn platform(context: &Context, id: ID) -> FieldResult<Option<Platform>> {
        let result = context.database.platforms
            .get(id.deref())
            .map(|data| data.clone())
            .clone();
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


//#[graphql(description = "Computer hardware + software that games are designed to run on (PC, macOS NES, PSX, etc)")]
#[derive(Clone, Debug)]
pub struct Platform {
    pub id: String,
    pub name: String,
    pub image_path: String,
    pub released: DateTime<Utc>
}

#[graphql_object(context = Context)]
impl Platform {
    pub fn id(&self) -> &str {
        &self.id
    }
    pub fn name(&self) -> &str {
        &self.name
    }
    pub fn image_path(&self) -> &str {
        &self.image_path
    }
    pub fn released(&self) -> &DateTime<Utc> {
        &self.released
    }
    pub fn titles(&self, context: &Context) -> Vec<Title> {
        let db = &context.database;
        let results: Vec<Title> = db.title_platforms.iter()
            .filter(|(_, pid)| pid == &self.id)
            .map(|(tid, _)| db.titles.get(tid).unwrap().clone())
            .collect();
        results
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