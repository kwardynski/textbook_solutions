# Programming Phoenix 1.4


[Chapter 2 - The Lay of the Land](Chapter%2002/)
- Web applications in Phoenix are a pipeline of "plugs".
- The basic flow of traditional applications is `endpoint |> router |> pipeline |> controller`.
- Routers distribute requests.
- Controllers call services and set up intermediate data for views.

[Chapter 3 - Controllers](Chapter%2003/)
- In Phoenix, a _context_ is a module that groups functions with a shared purpose. A context encapsulates all business logic for a common purpose. 
- In Phoenix, a _view_ is a module containing rendering functions that convert data into a format the end user will consume, like HTML or JSON.
- In Phoenix, a _template_ is a function on that module, compiled from a file containing a raw markup language and embedded Elixir code to process substitutions and loops.
- The sepapration of the view and template comcepts makes it easy to render data any way you want.