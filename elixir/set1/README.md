# Cryptopals Set 1 solved with Elixir

## Run all the tests from the top directory

```bash
$ find . -type d -d 1 | xargs -I '{}' -P 10 bash -c "cd '{}' && mix test"
```

Why not use `-execdir`? Because that would run each set of tests sequentially.
`xargs -P` runs them in parallel.
