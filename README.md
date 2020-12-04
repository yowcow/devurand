[![Build Status](https://travis-ci.com/yowcow/devurand.svg?branch=main)](https://travis-ci.com/yowcow/devurand)

devurand
========

`/dev/urandom` reader application

Build
-----

    $ rebar3 compile

How to Use
----------

### Configure

In `sys.config`, have path to `urandom` configured:

```erlang
[
 {devurand, [{path, "/dev/urandom"}]}
].
```

### Start application

In your `.app`, have `devurand` in the list of depending applications.

### Enjoy

Just call `devurand:read(hex, 4)` to generate 4 bytes of random binary in hex string.
