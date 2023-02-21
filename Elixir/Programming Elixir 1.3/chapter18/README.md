# CHAPTER 18 - OTP: Supervisors

The Elixir way is not to worry much about code that crashes; instead, make sure the overall application keeps running./


## Problems:

1. Add a supervisor to your stack application. Use iex to make sure it starts the server correctly. Use the server normally, and then crash it (try popping from an empty stack). Did it restart? What were the stack contents after the restart? 

```
Running successive Stack.Server.pop calls until we reach an empty list will force a crash.
Looks like the process is re-started, and the stack contents are once again the default specified by the application: ["list", "of", "strings"]
```

2. Rework your stack server to use a supervision tree with a separate stash process to hold the state. Verify that it works and that when you crash the server the state is retained across a restart.

```
OK
```