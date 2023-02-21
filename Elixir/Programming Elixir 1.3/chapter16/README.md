# CHAPTER 16 -  NODES: THE KEY TO DISTRIBUTING SERVICESIES

## Problems:


1. Set up two terminal windows, and go to a different directory in each. Then 
   start up a named node in each. In one window, write a function that lists the
   contents of the current directory\
   `fun = fn -> IO.puts(Enum.join(File.ls!, ", ")) end`\
   Run it twice, once on each node
    - There's two folders in the `Nodes` directory for this, each with empty
      text files to display, the command line calls are shown below:

    Terminal 2:
    ```
    cd Nodes\node2
    iex --sname node2
    iex(node2@LAPTOP)>
    ```

    Terminal 1:
    ```
    cd Nodes\node1
    iex --sname node1
    iex(node1@LAPTOP)> fun = fn -> IO.puts(Enum.join(File.ls!, ", ")) end
    #Function<45.40011524/0 in :erl_eval.expr/5>
    iex(node1@LAPTOP)> Node.spawn(:"node1@LAPTOP", fun)
    node1_file1.txt, node1_file2.txt, node1_file3.txt, node1_file4.txt
    iex(node1@LAPTOP)> Node.connect :"node2@LAPTOP"
    true
    iex(node1@LAPTOP)> Node.spawn(:"node2@LAPTOP", fun)
    node2_file1.txt, node2_file2.txt, node2_file3.txt
    ```
   

2. When I introduced the internal server, I said it sent a tick "about every 2 
   seconds." But in the receive loop, it has an explicit timeout of 2,000 ms.
   Why did i say "about" when it looks as if the time should be pretty accurate?

   ```
   Every time a new client registers, the 2s timer will restart. Also I'm assuming
   that the messaging between clients isn't instantaneous, therefore there will be
   a little latency between the cycles of the function.
   ```

3. Alter the code so that successive ticks are sent to each registered client (so 
   the first goes to the first client, the second to the next client, and so on). 
   Once the last client receives a tick, the process starts back at the first. 
   The solution should deal with new clients being added at any time.

   ```
   What I've done here is slightly modify how PIDs are stored in the clients variable, which is now a map.
   Every time a PID is registered, it's added to the map with it's key being it's "position" in line,
   i.e. the first PID's key is 1, second is 2, etc.

   The reason I've done it this way is so that we can keep track of which client receives the message from 
   Ticker, so that when we register a new client, we don't start from the beginning or lose the order in 
   which the clients receive the tick.

   Ticker.send_tick/2 sends out a tick to the next client in line, then Ticker.get_next_call/2 determines
   which client is next. Once we reach the "end" of the map (i.e. the last registered client), we start from 
   the beginning. This way adding a new client does not interrupt the cadence or order of passing ticks from 
   Ticker to the client list.
   ```

4. The ticker process in this chapter is a central server that sends events to
   registered clients. Reimplement this as a ring of clients. A client sends a 
   tick to the next client in the ring. After 2 seconds, _that_ client sends a tick
   to _its_ next client.
   When thinking about how to add clients to the ring, remember to deal with the 
   case where a client's receive loop times out just as you're adding a new 
   process. What does this say about who has to be responsible for updating
   the links?

   ```
   Solution in ringer.ex.
   I think the way I set up the clients variable in ticker.ex is going to lend 
   itself well to this problem. 
   ```
