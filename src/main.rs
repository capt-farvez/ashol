use askama::Template;
use axum::{
    body::{boxed, Body, BoxBody},
    http::{Request, Response, StatusCode, Uri},
    response::Html,
    routing::{get, post},
    Extension, Router, extract::Path, Form,
};
use sqlx::{query_as, MySqlPool};
use tower::ServiceExt;
use tower_http::services::ServeDir;
use serde::Deserialize;

#[derive(Deserialize, Debug)]
struct Search {
    area: String,
    city: String,
    region: String,
}

#[derive(Template)]
#[template(path = "search.html")]
struct SearchPage {
    items: Vec<SearchItems>
}

#[derive(Debug)]
struct SearchItems {
    //brand_id: i32,
    name: String,
    location: String,
    area_name: String,
    city_name: String,
    region_name: String,
    phone: String,
    opening_hours: String,
}

#[derive(Template)]
#[template(path = "index.html")]
struct IndexPage {
    brands: Vec<(Option<Brand>, Option<Brand>, Option<Brand>)>,
}

#[derive(Template)]
#[template(path = "brand.html")]
struct BrandPage {
    brand: Brand,
    branches: Vec<Branch>
}

#[derive(Debug, Clone)]
struct Brand {
    id: i32,
    name: String,
    logo: String,
}

#[derive(Debug)]
struct Branch {
    id: i32,
    brand_id: i32,
    location: String,
    area_name: String,
    city_name: String,
    region_name: String,
    phone: String,
    opening_hours: String,
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

async fn get_brand(Path(id): Path<u32>, Extension(pool): Extension<MySqlPool>) -> Html<String> {
    let brand: Brand = query_as!(Brand, "SELECT id, name, logo FROM brand WHERE id = ?", id)
        .fetch_one(&pool)
        .await
        .unwrap();
    let branches: Vec<Branch> = query_as!(Branch, "SELECT id, brand_id, location, area_name, region_name, city_name, phone, opening_hours FROM branch WHERE brand_id = ?", id)
        .fetch_all(&pool)
        .await
        .unwrap();
    
    let page = BrandPage { brand, branches };

    Html(page.render().unwrap())
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

async fn post_search(Form(form): Form<Search>, Extension(pool): Extension<MySqlPool>) -> Html<String> {
    let items: Vec<SearchItems> = query_as!(SearchItems, "SELECT  name, location, area_name, region_name, city_name, phone, opening_hours FROM brand JOIN branch ON brand.id = branch.brand_id WHERE branch.area_name = ? AND branch.city_name = ? AND branch.region_name = ?", form.area, form.city, form.region).fetch_all(&pool).await.unwrap();
    let page = SearchPage { items };
    Html(page.render().unwrap())
}

#[tokio::main]
async fn main() {
    let db = MySqlPool::connect("mysql://root@localhost/ashol")
        .await
        .unwrap();

    let app = Router::new()
        .route("/", get(get_index))
        .route("/brand/:id", get(get_brand))
        .route("/", post(post_search))
        .layer(Extension(db))
        .nest("/assets", get(get_assets));

    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:8000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}
