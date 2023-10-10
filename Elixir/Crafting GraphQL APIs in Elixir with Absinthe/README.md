# Crafting GraphQL APIs in Elixir with Absinthe 

- [Chapter 1 - Meet GraphQL](#chapter-1---meet-graphql) 

## [Chapter 1 - Meet GraphQL](Chapter01/)
GraphQL is a query language that gives the users of an API the ability to describe the data that they want, and lets creators of the API focus on data relationships and business rules instead of worrying about the various data payloads the API needs to return.

The benefits of GraphQL mean a simpler API interface, since "controllers" do not need to worry about validating the parameters of a request:

- GraphQL servers will verify that requests are well formed
- GraphQL servers will validate that requests meet the requirements defined by the schema
- Requests that fail validation will not be executed, resulting in faster error responses and less bugs to track down (but more obscure error messages IMO...)

The GraphQL server's knowledge of the schema also helps it determine what data is available to be returned to the caller.

GraphQL draws terminology from Graph Theory, such that the relationships between nodes (objects) are referred to as edges.