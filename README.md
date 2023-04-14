# Repro

This is a minimal reproduction of a hook that tracks presence. It seems to have an issue with how the `handle_info` hook is attached. When logging in (even with just one user), the logs contain this debug warning:

```
[debug] warning: undefined handle_info in ReproWeb.HomeLive. Unhandled message: %Phoenix.Socket.Broadcast{topic: "some_topic", event: "presence_diff", payload: %{joins: %{"1" => %{metas: [...]}}, leaves: %{}}}
```

Two users are seeded for quick testing:
- `user1@example.com` (pass: "hello world!")
- `user2@example.com` (pass: "hello world!")

## Start

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
