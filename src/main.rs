use axum::{
    body::{boxed, Body, BoxBody},
    http::{Request, Response, StatusCode, Uri},
    routing::get,
    Extension, Router,
};
use sqlx::{query_as, MySqlPool};
use tower::ServiceExt;
use tower_http::services::ServeDir;

#[derive(Debug)]
struct Brand {
    id: i32,
    name: String,
    logo: String,
}

async fn brands(Extension(pool): Extension<MySqlPool>) -> String {
    let res: Vec<Brand> = query_as!(Brand, "SELECT id, name, logo FROM brand")
        .fetch_all(&pool)
        .await
        .unwrap();
    format!("{res:?}")
}

async fn get_logo(uri: Uri) -> Result<Response<BoxBody>, (StatusCode, String)> {
    let req = Request::builder().uri(uri).body(Body::empty()).unwrap();

    // `ServeDir` implements `tower::Service` so we can call it with `tower::ServiceExt::oneshot`
    match ServeDir::new("./logos").oneshot(req).await {
        Ok(res) => Ok(res.map(boxed)),
        Err(err) => Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Something went wrong: {}", err),
        )),
    }
}

#[tokio::main]
async fn main() {
    let db = MySqlPool::connect("mysql://root@localhost/ashol")
        .await
        .unwrap();

    let app = Router::new()
        .route("/", get(|| async { "Hello, World!" }))
        .route("/brands", get(brands))
        .layer(Extension(db))
        .nest("/logo", get(get_logo));

    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
