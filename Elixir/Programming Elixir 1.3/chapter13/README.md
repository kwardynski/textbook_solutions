# CHAPTER 13 - ORGANIZING A PROJECT

The vast majority of the "problems" is just replicating the code from the text, it's in the book and in the 
issues directory so I'm only going to list off the 'actual' problems. I've been sitting on this chapter for
quite awhile, so for the sake of getting moving again I'm not going to do any tests for the Problem 6
`WeatherGetter` module.


## Problems:

4. (Tricky) Before reading the next section, see if you can write the code to format the data into
   columns, like the sample output at the start of the chapter. This is probably the longest piece
   of Elixir code you'll have written. Try to do it without using `if` or `cond`

   My solution is in the `column_formatter.ex` module in. Basically I made a variable called
   `input_data` which is just the contents of the table from the beginning of the chapter and run it 
   through some formatting:
    - Return a map of longest string per column name
    - Print the header by spoofing a dataset with the column names as data values, padding with
      spaces until the longest string length is achieved
    - Print the table "border" - this is done in a bit of a smooth brain way just using `IO.puts` and
      `String.duplicate`  
    - Print out the actual data

6. In the United States, the National Oceanic and Atmospheric Administration provides hourly XML
   feeds of conditions at 1,8000 locations. For example, the feed for a small airport close to where
   I'm writing this is at https://w1.weather.gov/xml/current_obs/KDTO.xml.

   Write an application that fetches this data, parses it, and displays it in a nice format. (Hint: 
   You might not have to download a library to handle XML parsing.) 

   I'm going to hard-code this path into the config - I'm not exactly sure how the US airport
   accronyms work. Also this problem is more about parsing information and displaying it nicely
   than user config/customization (more of me just being lazy).
    - Needed to add the `follow_redirect: true` option to the `HTTPoison.get` call in order to get
      the actual body of the webpage back. Without that, I would get a status code of 301 which means
      the source has been moved so we need to follow the re-direct to get the actual data.
    - When researching how to parse XML documents, I came across [https://pspdfkit.com/blog/2018/how-to-parse-xml-documents-in-elixir/]
      which suggests using `SweetXML`, as it is a handy wrapper around `:xmerl` which reduces the boilerplate
      code required for converting an input charlist into xmerls records. I think I'm going to use this
      to greatly simplify the process (even though the hint says we might not have to download a
      library for XML parsing). According to the documentations, you can use the syntax: 
      `SweetXml.xpath(~x"//QUERY_FIELD/text()") |> List.to_string` (where `QUERY_FIELD` is the information
      you're after) in order to get the data. i.e. using `location` as `QUERY_FIELD` would return 
      `Denton Municipal Airport, TX`.
