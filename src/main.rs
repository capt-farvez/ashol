use askama::Template;
use axum::{
    body::{boxed, Body, BoxBody},
    http::{Request, Response, StatusCode, Uri},
    response::Html,
    routing::get,
    Extension, Router,
};
use sqlx::{query_as, MySqlPool};
use tower::ServiceExt;
use tower_http::services::ServeDir;

#[derive(Template)]
#[template(path = "index.html")]
struct IndexPage {
    brands: Vec<(Option<Brand>, Option<Brand>, Option<Brand>)>,
}

#[derive(Debug, Clone)]
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

async fn get_assets(uri: Uri) -> Result<Response<BoxBody>, (StatusCode, String)> {
    let req = Request::builder().uri(uri).body(Body::empty()).unwrap();

    // `ServeDir` implements `tower::Service` so we can call it with `tower::ServiceExt::oneshot`
    match ServeDir::new("./assets").oneshot(req).await {
        Ok(res) => Ok(res.map(boxed)),
        Err(err) => Err((
            StatusCode::INTERNAL_SERVER_ERROR,
            format!("Something went wrong: {}", err),
        )),
    }
}

async fn get_index(Extension(pool): Extension<MySqlPool>) -> Html<String> {
    let brands: Vec<Brand> = query_as!(Brand, "SELECT id, name, logo FROM brand")
        .fetch_all(&pool)
        .await
        .unwrap();
    let brands = brands
        .chunks(3)
        .map(|arr| {
            (
                arr.get(0).cloned(),
                arr.get(1).cloned(),
                arr.get(2).cloned(),
            )
        })
        .collect();
    Html(IndexPage { brands }.render().unwrap())
}

#[tokio::main]
async fn main() {
    let db = MySqlPool::connect("mysql://root@localhost/ashol")
        .await
        .unwrap();

    let app = Router::new()
        .route("/", get(get_index))
        .route("/brands", get(brands))
        .layer(Extension(db))
        .nest("/assets", get(get_assets));

    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:5000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
