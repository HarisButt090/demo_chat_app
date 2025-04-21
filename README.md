Demo Chat App 
ntroduction
This repository contains the source code for a robust backend application built with Ruby on Rails as the framework and GraphQL as the query language. This setup provides a powerful and flexible foundation for building scalable and efficient APIs.

Tech Stack
Ruby on Rails: This project utilizes the Ruby on Rails framework, a robust and developer-friendly web application framework written in Ruby. Rails follows the convention over configuration (CoC) and don't repeat yourself (DRY) principles, making it an excellent choice for building APIs.

GraphQL: GraphQL is a query language for APIs that provides a more efficient, powerful, and flexible alternative to traditional REST APIs. It allows clients to request only the data they need, reducing over-fetching and under-fetching of data.

Getting Started
Follow these steps to set up and run the Rails API with GraphQL:

Installation
Clone the repository:

git clone https://github.com/Staunchglobal/sparrowell-backend.git
Navigate to the project directory:

cd sparrowell-backend
Install dependencies:

bundle install
yarn install
Set up the database:

rails db:create
rails db:migrate
Start the Rails server:

rails server
Your app will be running at http://localhost:3000.

GraphQL Endpoint
The GraphQL endpoint is located at http://localhost:3000/graphql. You can use tools like GraphiQL or Insomnia to interact with the GraphQL API.
