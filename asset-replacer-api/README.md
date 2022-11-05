# Software Dependencies
* [Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)
* [Postgres 15](https://www.postgresql.org/download/windows/)

## Compiling / Running on Windows
1. Install the necessary software dependencies above.
2.
    The **Diesel** ORM will fail to compile without referencing some PG libraries.
    Create or open the following file:
    ```
    %HOMEPATH%/.cargo/config.toml
    ```
    And append the following lines:
    ```
    [target.x86_64-pc-windows-msvc.pq]
    rustc-link-search = ["C:\\Program Files\\PostgreSQL\\15\\lib"]
    rustc-link-lib = ["libpq"]  
    ```
    Issue was first reported [here](https://github.com/diesel-rs/diesel/issues/2519).
    Note that if you use a different version of PostgreSQL, or you installed it under a different directory, you'll need to modify the path accordingly.
3.
    Install the **Diesel** ORM globally with the following command:
    ```bash
    cargo install diesel_cli --no-default-features --features postgres
    ```
4.
    Add the following values to your PATH variable:
    ```
    C:\\Program Files\\PostgreSQL\\15\\lib
    C:\\Program Files\\PostgreSQL\\15\\bin
    ```
    Without this, the ```diesel setup``` command will likely fail.
    Like before, modify these paths as needed.
    Kudos to [this person](https://dev.to/ssivakumar/rust-diesel-fixing-issues-with-setup-3k56) for figuring this out.
5.
    Run the following command to create our database. Ensure that PostgreSQL is running beforehand.
    ```bash
    diesel setup
    ```
6.
    Compile / run the application with the following command:
    ```rust
    cargo run
    ```
