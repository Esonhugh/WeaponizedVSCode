export PROJECT_WEB_DELIVERY=$PROJECT_FOLDER/.web-delivery

mkdir -p $PROJECT_WEB_DELIVERY

cd $PROJECT_WEB_DELIVERY

python3 -m http.server 

# open http://localhost:8000