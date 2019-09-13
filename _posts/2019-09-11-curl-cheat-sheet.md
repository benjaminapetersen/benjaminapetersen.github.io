---
layout: post
date:   2019-09-11
title:  "A Short curl Cheat Sheet"
tags: "today i learned" bash curl terminal
---

### tl;dr

I'm terrible at blogging, so I'm attempting a new series of posts 
with the popular "today I learned" strategy (similar to what you might 
see [here](https://til.hashrocket.com/)).  I'm kicking this off with curl.

# A Short curl Cheat Sheet

Lots of developers love curl. I must confess, I rarely use it.  When I have, its been for simple enough tasks that I never bothered to learn it 
well.  Having a decent amount of JavaScript single-page application 
development experience, I'm comfortable testing requests in the browser
using all of the tools provided with the developer console.  Occasionally 
I have hopped over to use [Postman](https://www.getpostman.com/) instread.

Today I am posting about curl.  Curl is a tool for transferring data to and from a server, as well as the manipulation of URLs. There are a number of fantastic resources on Some further details [here](https://curl.haxx.se/docs/httpscripting.html).

As I consume a resource, I often generate a cheat sheet to later use as a 
refresher of what I have learned. This is particularly important when the 
tool is one I infrequently use.  For `curl`, this is my list:


```bash
# make a GET request for a URL
curl http://example.com
# make a GET request and be explicit about response details
# significant more information returned about the request 
curl http://example.com --verbose 
# far more intersting when done with https to watch the TLS handshake
curl https://example.com --verbose 
# don't check the certs. helpful for self signed certs in dev environments
curl https://example.com --insecure
# how long it takes?
curl http://example.com --trace-time
# redirect the response body (only, even if --verbose flag used) to a file
curl http://example.com -o foobar.txt
# override DNS or /etc/hosts by providing a different IP address for a named host
curl --resolve www.example.com:80:127.0.0.1 http://www.example.com
# specify a proxy, such as for an alternative port 
curl --proxy http://example.com:1234 http://example.com
# Basic auth. provide user / pass to HTTP authentication. no longer common, most websites use cookies
curl http://user:pass@example.com 
curl -u user:pass http://example.com 
# basic auth for a proxy user to make request through proxy
curl --proxy-user proxuser:proxpass http://example.com 
# headers only 
curl --head http://example.com 
# several urls
curl http://example.com http://other-example.com 
# series of several urls with different methods such as HEAD,GET and POST,GET
curl -head http://example.com --next http://example.com 
curl --data age=37 http://example.com/how-old --next http://example.com/your-profile
# GET form post
curl "http://example/.com/profile?age=37&name=bob&submit=go"
# POST form post, note that curl will not properly encode the data for you! 
curl --data "age=37&name=bob&submit=go" http://example.com/profile 
# follow lcoation redirect header
curl --location http://example.com 
# add a cookie
curl --cookie "name=bob" http://www.example.com
# dump headers (there better options)
curl --dump-header headers_and_cookies http://www.example.com
# a slightly more complex example to check an oauth token endpoint and write output to file 
curl https://example.com/oauth/token --insecure --verbose -o foobar_baz.txt --dump-header headers_and_cookies
# use cookies from a file, useful to reconnect with cookies from previous connection 
curl --cookie cookie-jar.txt http://www.example.com 
# share cookies between scripts with cookie-jar flag
curl --cookie cookies.txt --cookie-jar newcookies.txt http://www.example.com 
# with certificate
curl --cert cert.pem https://www.example.com 
# or with a cert store
curl --cacert ca-bundle.pem https://www.example.com
# truncate a header by providing empty value to manipulate a request
curl --header "Host:" http://www.example.com
# add additional headers
curl --header "Destination:http://example2.com" http://www.example.com
# dump a trace as ascii to a file
curl http://www.example.com --trace-ascii trace.ascii.txt
```

I'll try to follow with a practical use case for `curl` in a future post.