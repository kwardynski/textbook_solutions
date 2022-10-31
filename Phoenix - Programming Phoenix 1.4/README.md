# Programming Phoenix 1.4


## [Chapter 2 - The Lay of the Land](Chapter%2002/)
- Web applications in Phoenix are a pipeline of "plugs".
- The basic flow of traditional applications is `endpoint |> router |> pipeline |> controller`.
- Routers distribute requests.
- Controllers call services and set up intermediate data for views.

## [Chapter 3 - Controllers](Chapter%2003/)
- In Phoenix, a _context_ is a module that groups functions with a shared purpose. A context encapsulates all business logic for a common purpose. 
- In Phoenix, a _view_ is a module containing rendering functions that convert data into a format the end user will consume, like HTML or JSON.
- In Phoenix, a _template_ is a function on that module, compiled from a file containing a raw markup language and embedded Elixir code to process substitutions and loops.
- The sepapration of the view and template comcepts makes it easy to render data any way you want.
- Views render templates. 
- Templates generate HTML for our users.
- Laoyts are HTML templates that embed an action's HTML.

## [Chapter 4 - Ecto and Changesets](Chapter%2004/)
- Ecto is the Elixir framework for persisting data.
- Ecto has a feature called _changesets_, which hold all the changes you want to perform on the database. They encapsulate the entire process of receiving external data, casing, and validating it before writing it to the database.
- `Ecto.changeset.cast/2` converts a raw map (arg1) to a changeset, accepting only the key specified in the arg2 list. 

## [Chapter 5 - Authenticating Users](Chapter%2005/)
- There are two types of plugs: _module_ plugs and _function_ plugs. 
    - A module plug is a module that provides two functions with some configuration details, you specify the plug by providing the module name. (`Plug.RequestId`)
        - To satisfy plug specifications, a module plug must contain an `init` and a `call` function.
        - Module plugs use the result of `init` as the second argument to `call`. - In dev mode, Phoenix calls `init` at runtime, but in prod, `init` is only called **once at compile time**.
    - A function plug is a single function, you specify the plug with the name of the function as an atom. (`:protect_from_forgery`)
- The `Plug.Conn` structure used by phoenix hold the fields that web applications use for web requests and responses.
- Controllers also have their own plug pipeline (like endpoints and routers). Each plug in the controller pipeline is executed in order, before an action is invoked. The controller pipeline lets us explicitly choose which actions fire for any given plug!
- **Controllers are not meant to handle business logic - all they do is translate whatever the business logic returns into something meaningful for the user.**

## [Chapter 6 - Generators and Relationships](Chapter%2006/)
- Phoenix includes to Mix tasks (code generators) to bootstrap web interfaces:
    - `phx.gen.html` creates a simple HHTP scaffold with HTML pages
    - `phx.get.json` does the same for a RESTFUL API using JSON.
- Contexts should be used to generate easy to maintain API layers.

## [Chapter 7 - Ecto Queries and Constraints](Chapter%2007/)
- Put query functions into the appropriate schema layers
- Complex interactions between entities go in contexts
- This allows us to keep controllers as thin as possble (a very good thing!)
- Ecto queries can be built with two types of APIs, "keyword" and "pipe" syntax
    - Keyword Syntax expresses different parts of a query by using a keyword list
    - Pipe Syntax queries are built by piping queryables _into_ further expressions which add new conditions to the query
- Query _fragments_ allow us to construct a fragment of SQL for the query
- Ecto also has a SQL adapter which allows you to execute raw SQL

### Constraints
Constraints allow us to user underlying relational database features to help maintain database integrity. Some terminology:
1. Constraint - An explicit database constraint. This might be a uniqueness constraint on an index, or an integrity constraint between primary and foreign keys.
2. Constraint Error (`Ecto.ConstraintError`) - This happens when Ecto identifies a constraint problem, such as trying to insert a record without specifying a required key.
3. Changeset Constraint - A constraint annotation added to the changeset that allows Ecto to convert constraint errors into changeset error messages.
4. Changeset Error Messages - Human readable error messages.\

Using changeset constraints is only useful if the error messages are something the user can take action on - otherwise it's best to "let it crash".
