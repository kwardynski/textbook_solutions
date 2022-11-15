# Functional Web Development with Elixir, OTP, and Phoenix

## Part I - Define the Functional Core in Elixir

### [Chapter 2 - Model Data and Behavior](Chapter%2002/)
- Structs maintain all the qualities of maps, however they offer compile-time checks on the keys, and allow us to do run-time checks on the struct's type.
- the `@enforce_keys` attribute can be used to ensure that all listed keys are present when creating a new struct.

### [Chapter 3 - Manage State with a State Machine](Chapter%2003/)
- In this chapter, we build a state machine from scratch in `IslandsEngine.Rules` using multiple function heads to handle transitions from current to next allowable state. 
- We did this in a way that's completely decoupled from any other modules written so far and kept is separate from the application's "business logic". 

---

## Part II - Add OTP for Concurrency and Fault Tolerance

### [Chapter 4 - Wrap It Up in a GenServer](Chapter%2004/)
- The Erlang `:sys` module provides a `get_state/1` function which returns the state of a `:gen_server` process - **THIS IS NOT INTENDED FOR PRODUCTION CODE, USE FOR EXPLORING/DEBUGGING**
