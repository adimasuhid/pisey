Pisey
=====
Ruby port of the RESTful API of the PSE. Hosted at: http://pisey.herokuapp.com/. Inspired by https://code.google.com/p/phisix/.

Format
=====
All values are in json format in this form:
```
{volume:"", percent_change:"", last_trade_price: "", name: "", symbol: ""}
```

API
=====
```
GET /stocks #=> get all stocks
GET /stocks/:id #=> get specific stock
```

To do
====
- Historical data

License
====
MIT
