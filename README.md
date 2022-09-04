# simple-log-parser

## Getting started
```ruby
bundle install
```

This app expects ruby 2.7.6 installed on your machine

Example log file and parsing results can be found in `sample/`

## Commands
For detailed explanation with examples run

```
./bin/parser --help
```

Basic usage
```
./bin/parser parse PATH_TO_LOGS
```
```
./bin/parser replay PATH_TO_STORE_FILE
```

## Misc commands
IRB sandbox with loaded app classes
```
./bin/console
```
Clear store files
```
./bin/clear_tmp
```

## Test and Lint
```
rspec
```
```
rubocop
```



