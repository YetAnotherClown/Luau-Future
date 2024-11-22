---
title: Installation
description: How to install Luau Futures
sidebar_position: 2
---

Luau Futures has support for any Luau environment, relying only
on the coroutine library.

We support installing the library from either wally or pesde, with wally
being used internally for development.

## Wally

```toml
[dependencies]
LuauFutures = "yetanotherclown/luau-futures@^2.0.0"
```

:::note
Wally does not export types automatically and will display a type-error in one of the Dependencies.

To fix this, see https://github.com/JohnnyMorganz/wally-package-types.
:::

## Pesde

```toml
[dependencies]
LuauFutures = { name = "yetanotherclown/luau_futures", version = "^2.0.0" }
```

## GitHub Releases

You can also find .rbxm files for use within Studio directly
within GitHub Releases.

Get the [Latest Release](https://github.com/YetAnotherClown/luau-futures/releases/latest).