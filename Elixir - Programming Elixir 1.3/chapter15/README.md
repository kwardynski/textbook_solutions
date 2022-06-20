# CHAPTER 15 - WORKING WITH MULTIPLE PROCESSES

## Problems:

1. Run this code on your machine. See if you get comparable results.

    "This code" being the code found in 'chain.exs'.
    - {4896,    "Result is 10"}
    - {5282,    "Result is 100"}
    - {7711,    "Result is 1000"}
    - {42936,   "Result is 10000"}
    - {1584623, "Result is 400000"}
    - {5844306, "Result is 1000000"}

2. Write a program that spawns to processes and then passes each a unique
   token (for example, "fred" and "betty"). Have them send the tokens back.
    - Is the order in which the replies are received deterministic in 
      theory? In practice?
    - If either answer is no, how could you make it so?

    Solution to this is in the `token_return.exs` script. I'm going to hard-code the two tokens
    and the callbacks since I don't think we're quite ready to be making these dynamic./
    The order in which the replies are received should be deterministic in theory, however it all 
    depends on which process finishes evaluation first - running this script several times, "betty"
    was received first twice./
    To make it deterministic, you could set the second process to listen to the first, and only respond
    once it receives a reply from the first message to ensure "proper" order.

3. Use `spawn_link` to start a process, and have that process send a message to the parent and
   then exit immediately. Meanwhile, sleep for 500 ms in the parent, then receive as many 
   messages are are waiting. Trace what you receive. Does it matter that you weren't waiting for
   the notification from the child when it exited?

   Solution to this is in the `sleepy_parent.exs` script

4. Do the same, but have the child raise an exception. What difference do you see in the tracing?
    - I've added an `active_child_exception` function to the `SleepyParent` module, which throws an error
      instead of sending a message, and the sleepy_parent function accepts arguments for which child
      process to run, "active_child" or "active_child_exception".
    - Looks like the child process dies and took the parent with it as elixir hangs

```
iex(1)> c("sleepy_parent.ex")
iex(2)> SleepyParent.sleepy_parent("active_child_exception", "link")

17:49:53.330 [error] Process #PID<0.117.0> raised an exception
** (RuntimeError) I'm throwing an error here
    sleepy_parent.ex:28: SleepyParent.active_child_exception/1
```

5. Repeat the two, changing spawn_link to spawn_monitor
    - `spawn_monitor` and `active_child` runs like before
    - `spawn_monitor` and `active_child_exception` provides a more thorough callstack 
       as the parent receives the error message (but can't display it properly...)


```
iex(1)> c("sleepy_parent.ex")
iex(2)> SleepyParent.sleepy_parent("active_child", "monitor")
AAAAAH!
:ok

iex(3)
17:49:53.330 [error] Process #PID<0.117.0> raised an exception
17:54:34.401 [error] Process #PID<0.123.0> raised an exception
** (RuntimeError) I'm throwing an error here
    sleepy_parent.ex:28: SleepyParent.active_child_exception/1
** (Protocol.UndefinedError) protocol String.Chars not implemented for {:DOWN, #Reference<0.2756469564.2242904065.32491>, :process, #PID<0.121.0>, :normal} of type Tuple
    (elixir 1.12.2) lib/string/chars.ex:3: String.Chars.impl_for!/1
    (elixir 1.12.2) lib/string/chars.ex:22: String.Chars.to_string/1
    sleepy_parent.ex:34: SleepyParent.receive_message/0
```

6.  In the `pmap` code, I assigned the value of `self` to the variable `me` at the top of the
    method and then used `me` as the target of the message returned by the spawned process.
    Why use a separate variable here?
    - The first transformation calls both me and self. We need the parent's PID (self) in order
      to receive the result of the child process (self)


7. Change the `^pid` in `pmap` to `_pid`. This means the receive block will take responses in the
   order the processes send them. Now run the code again. Do you see any difference in the output?
   If you're like me, you don't, but the program clearly contains a bug. Are you scared by this?
   an you find a way to reveal the problem (perhaps by passing ina  different function, by sleeping, 
   or by increasing the number of processes)? Change it back to ^pid and make sure the order is now 
   correct.
    - Increasing the input list length from `1..10` to `1..1000` reveals an issue - we don't get the results
      back in order. This is because we get the results back as they finish, not in the order "sent". I would
      think this is the bug Dave is talking about, and I guess it has the potential to be scary - if you're
      expecting results to be in the same order as the input list, you'll run into issues if it comes back
      jumbled.

8. Run the Fibonacci code on your machine. Do you get comparable timings? If your machine has multiple
   cores and/or processors, do you see improvements in the timing as we increase the application's
   concurrency
    - My times range from 5.25s at 1 process, to 0.96s running 10 processes/

9. Take this scheduler code and update it to let you run a function that finds the number of times the
   word "cat" appears in each file in a given directory. Run one server process per file. The function
   `File.ls!` returns the names of files in a directory, and `File.read!` reads the contents of a file
   as a binary. Can you write it as a more generalized scheduler?

   Run your code on a directory with a reasonable number of files (maybe around 100) so you can 
   experiment with the effects of concurrency.
    - It's been awhile since I've picked this book up, and I'm not sure exactly how far I got on
      the cat counter module, but I'm just going to start the next chapter now...
