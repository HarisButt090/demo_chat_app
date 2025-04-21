# Demo Chat App

## Introduction

This repository contains the source code for a robust backend application built with Ruby on Rails as the framework and GraphQL as the query language. This setup provides a powerful and flexible foundation for building scalable and efficient APIs.

## Tech Stack

- **Ruby on Rails:** This project utilizes the Ruby on Rails framework, a robust and developer-friendly web application framework written in Ruby. Rails follows the convention over configuration (CoC) and don't repeat yourself (DRY) principles, making it an excellent choice for building APIs.

- **GraphQL:** GraphQL is a query language for APIs that provides a more efficient, powerful, and flexible alternative to traditional REST APIs. It allows clients to request only the data they need, reducing over-fetching and under-fetching of data.

## Getting Started

Follow these steps to set up and run the Rails API with GraphQL:

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/HarisButt090/demo_chat_app.git
   ```

2. Navigate to the project directory:

   ```bash
   cd demo_chat_app
   ```

3. Install dependencies:

   ```bash
   bundle install
   ```

   ```bash
   yarn install
   ```

4. Set up the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

5. Start the Rails server:

   ```bash
   rails server
   ```

   Your app will be running at [http://localhost:3000](http://localhost:3000).

## GraphQL Endpoint

The GraphQL endpoint is located at [http://localhost:3000/graphql](http://localhost:3000/graphql). You can use tools like [GraphiQL](https://github.com/graphql/graphiql) or [Insomnia](https://insomnia.rest/) to interact with the GraphQL API.
