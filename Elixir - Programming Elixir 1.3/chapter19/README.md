# CHAPTER 19 - OTP: Applications

In OTP terms, an _application_ refers to a bundle of code that comes with a descriptor, **not** a program like in the more common use of the term./
The descriptor tells the runtime what dependencies the code has, what global names it registers, and so on - it's more like a dynamic link libary or shared object than a conventional "application". Think of it like a _component_ or a _service_.

A lot of the release procedures (and running a release) have changed between Elixir 1.3 and 1.13, so I'm basically going to skip from "A Toy Deployment Environment" to the end of the chapter.

## Problems:

1. Turn your stack server into an OTP application.
```
- Added initial list to the module call in the mix.exs file
- Added Stack.Server to the registered list
- Modified Stack.Application.start to ingest an initial_list, passes it to Stack.Supervisor.start_link
```

2. So far, we haven't written any tests for teh application. Is there anything you can test? See what you can do.
```
There's plenty that can be tested, i.e. the pop and push functions, but I 
spent the last two weeks at work beefing up unit tests. Between that and 
having covid I'm honestly not in the mood to do this right now... I'm also
well aware that this is a cheap cop-out.
```