npm init -y

npm i -D prettier
npm i -D nodemon
npm i mongoose express dotenv
mkdir public src
touch .env .gitignore .prettierignore .prettierrc readme.md
cd src
mkdir controllers db middlewares models routes utils
touch index.js app.js constants.js
cd ..
cd public
mkdir temp
cd temp
touch .gitkeep
cd ../..
