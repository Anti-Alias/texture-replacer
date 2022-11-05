# Software Dependencies
* [Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html)
* [Postgres 15](https://www.postgresql.org/download/windows/)

## Compiling / Running on Windows
1. Install the necessary software dependencies above.
2.
    The **Diesel** ORM will fail to compile on its own. Create or open the following file:
    ```
    %HOMEPATH%/.cargo/config.toml
    ```
    And append the following line:
    ```
    [target.x86_64-pc-windows-msvc.pq]
    rustc-link-search = ["C:\\Program Files\\PostgreSQL\\15\\lib"]
    rustc-link-lib = ["libpq"]  
    ```
    Issue was first reported [here](https://github.com/diesel-rs/diesel/issues/2519).
    Note that if you use a different version of PostgreSQL, or you installed it under a different directory, you'll need to modify the path.
3.
    Compile / run the application via:
    ```rust
    cargo run
    ```
