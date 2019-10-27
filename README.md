# CONE: HTTP Content Negotiation

[![Build Status](https://travis-ci.org/bartfeenstra/cone.svg?branch=master)](https://travis-ci.org/bartfeenstra/cone)

CONE provides HTTP content negotiation tools.

## Usage

### API
The main API function is `cone.negotiate`, which takes a content negotiation header (`Accept`, `Accept-Charset`,
`Accept-Encoding`, or `Accept-Language`) value, and an array table of available values to negotiate between, with the
first available value considered the default.
```lua
local cone = require('cone')
local http_accept_header = 'apples,oranges;q=0.7,bananas;q=0.5'
local available_values = {'bananas','oranges'}
local negotiated_value = cone.negotiate(http_accept_header, available_values)
print(negotiated_value)
-- Outputs "oranges".
```

### nginx
Use CONE to add content negotiation to [nginx](https://nginx.org/). This is extremely powerful when serving static
sites. Put `cone.lua` in nginx's Lua package path, or define your own package path with `lua_package_path`. Then
negotiate `Accept*` header values with a Lua snippet. Example: 
```
lua_package_path '/cone/?.lua;;';

server {
	listen 80;
    location / {
        set_by_lua_block $locale {
            return require('cone').negotiate(ngx.req.get_headers()['Accept-Language'], {'nl', 'de', 'en'})
        }
        add_header Content-Language $locale;
        return 200;
    }
}
```
