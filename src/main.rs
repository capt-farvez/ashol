use axum::{routing::get, Extension, Router};
use sqlx::{MySqlPool, query_as};

#[derive(Debug)]
struct Brand {
    id: i32,
    name: String,
    logo: String
}

async fn brands(Extension(pool): Extension<MySqlPool>) -> String {
    let res: Vec<Brand> = query_as!(Brand, "SELECT id, name, logo FROM brand").fetch_all(&pool).await.unwrap();
    format!("{res:?}")
}

#[tokio::main]
async fn main() {
    let db = MySqlPool::connect("mysql://root@localhost/ashol")
        .await
        .unwrap();
    
    let app = Router::new().route("/", get(|| async { "Hello, World!" }))
                                   .route("/brands", get(brands)).layer(Extension(db));

    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
