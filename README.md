# CONE: HTTP Content Negotiation

[![Build Status](https://travis-ci.org/bartfeenstra/cone.svg?branch=master)](https://travis-ci.org/bartfeenstra/cone)

CONE provides HTTP content negotiation tools.

## Usage

```lua
local cone = require('cone')
local http_accept_header = 'apples,oranges;q=0.7,bananas;q=0.5'
local available_values = {'bananas','oranges'}
local negotiated_value = cone.negotiate(http_accept_header, available_values)
print(negotiated_value)
-- Outputs "oranges".
```