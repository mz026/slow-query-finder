# SlowQueryFinder

A small script to find slow queries from Postgresql log.

## Usage

- Build it: `$ mix escript.build`
- Parse the log file: `$ ./slow_query_finder <log_file>`

ex: `$ ./slow_query_finder postgresql.log.2016-06-16-02`

## How it works:

Postgres logs slow query by a `duration` keyword with a process id, such as:

```
2016-06-16 02:18:27 xxxxxxx:[10422]:LOG:  execute xxxxx: SELECT * FROM users

... a lot of lines between the lines

2016-06-16 02:18:27 xxxxxxx:[10422]:LOG:  duration: 1043.358 ms
```

`SlowQueryFinder` find slow queries by:

1. Find the process id of log with `duration` keyword
2. Find the query with the same process id which is nearest and before the `duration` line.

## Test

- Run test by: `$ mix espec`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## LICENCT

MIT
