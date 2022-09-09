# PHP-FPM Docker image built with OpenSSL 1.1.0, cURL, GOST-engine

This image contains PHP that supports GOST-algorithms:
```
php -r "echo openssl_digest('Hello', 'GOST R 34.11-2012 with 256 bit hash');"
3c10d2ffe0787bc8bd6eacd337d59c314ce689c847a422f6c34b4b75f45751bc

```

Full list of `php -r 'print_r(openssl_get_md_methods());'`:
```
Array
(
    [0] => BLAKE2b512
    [1] => BLAKE2s256
    [2] => GOST 28147-89 MAC
    [3] => GOST R 34.11-2012 with 256 bit hash
    [4] => GOST R 34.11-2012 with 512 bit hash
    [5] => GOST R 34.11-94
    [6] => MD4
    [7] => MD5
    [8] => MD5-SHA1
    [9] => MDC2
    [10] => RIPEMD160
    [11] => SHA1
    [12] => SHA224
    [13] => SHA256
    [14] => SHA384
    [15] => SHA512
    [16] => blake2b512
    [17] => blake2s256
    [18] => gost-mac
    [19] => gost-mac-12
    [20] => md4
    [21] => md5
    [22] => md5-sha1
    [23] => md_gost12_256
    [24] => md_gost12_512
    [25] => md_gost94
    [26] => mdc2
    [27] => ripemd160
    [28] => sha1
    [29] => sha224
    [30] => sha256
    [31] => sha384
    [32] => sha512
    [33] => whirlpool
)
```

https://hub.docker.com/r/rnix/php-fpm-gost/

`docker run rnix/php-fpm-gost php -i`

## How image was built

Compiled versions of OpenSSL, cURL with GOST-engine were taken from image `rnix/openssl-gost`
using multi-stage building. Then PHP was compiled with them.

Script `make_dockerfile.sh` does some changes to official image.
The result of it is included in this folder.

## Limitations

If use https://github.com/docker-library/php/tree/master/7.1/jessie/fpm (7.1.16) as main image, then 
`curl_*` function inside php does not work with GOST-ciphers.
The workaround is calling curl from system, for example `exec('curl https://gost.example.com')`.

With https://github.com/docker-library/php/tree/master/7.2/stretch/fpm there are no these limitations.
There was a bug with message "GOST engine already loaded" in stdout for every php-command, 
to fix it I changed one line in GOST-engine. I suppose it is bug in OpenSSL.
