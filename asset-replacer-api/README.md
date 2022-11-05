# Software Dependencies
* [Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)
* [Postgres 15](https://www.postgresql.org/download/windows/)

## Compiling / Running on Windows
1. Install the necessary software dependencies above.
2.
    Set the following PATH variables
    ```
    C:\\Program Files\\PostgreSQL\\15\\lib
    C:\\Program Files\\PostgreSQL\\15\\bin
    ```
    This is necessary both for compiling/installing **Diesel**, as well as running it. Make sure to change the the PostgreSQL path if you installed a different version, or have a custom installation path.
3.
    Set the following environment variables:
    ```
    PG_USER_PASSWORD=<your_postgres_user_password>
    MIGRATION_DIRECTORY=\path\to\asset-replacer-api\migrations
    ```
    PG_USER_PASSWORD is optional if you set your password to **password** during PostgreSQL installation.
    
    MIGRATION_DIRECTORY must be set to \<path-to-asset-replacer-api-dir>\migrations. This is a nasty workaround, unfortunately. I suspect **Diesel** wasn't thorougly tested on Windows.
    
4.
    Append the following lines...
    ```
    [target.x86_64-pc-windows-msvc.pq]
    rustc-link-search = ["C:\\Program Files\\PostgreSQL\\15\\lib"]
    rustc-link-lib = ["libpq"]  
    ```
    To the following file:
    ```
    %HOMEPATH%/.cargo/config.toml
    ```
    If the file does not exist, create it.
    Make sure to change the the PostgreSQL path if you installed a different version, or have a custom installation path.
5.
    Install the **Diesel** ORM globally with the following command:
    ```bash
    cargo install diesel_cli --no-default-features --features postgres
    ```
6.
    Run the following command to create your database and run migrations.
    Ensure that PostgreSQL is running beforehand.
    ```bash
    diesel setup
    ```
7.
    Compile / run the application with the following command:
    ```rust
    cargo run
    ```
