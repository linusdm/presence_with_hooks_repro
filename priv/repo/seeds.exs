# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Repro.Repo.insert!(%Repro.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Repro.AccountsFixtures.user_fixture(%{email: "user1@example.com", password: "hello world!"})
Repro.AccountsFixtures.user_fixture(%{email: "user2@example.com", password: "hello world!"})
