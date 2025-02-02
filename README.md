# php-typst

PHP extension for compiling Typst documents

## Development

### Install dev version of PHP

```sh
sudo apt install php-dev
```

OR

### Build PHP from source at `$HOME/build/php`

```sh
sudo apt install bison re2c llvm clang libclang-dev
git clone https://github.com/php/php-src.git
cd php-src
git checkout PHP-8.3
./buildconf
PREFIX="${HOME}/build/php"
./configure --prefix="${PREFIX}" --enable-debug --disable-all --disable-cgi
make -j "$(nproc)"
make install
```

### Build extension via Cargo

```sh
# Specify paths to PHP and PHP_CONFIG
PHP=$PREFIX/bin/php PHP_CONFIG=$PREFIX/bin/php-config cargo build
${PHP} -d extension=./php-typ/target/debug/libtyp_php.so ./test.php
```

## Built on

- [Ext PHP RS](https://github.com/davidcole1340/ext-php-rs)
- [Typst](https://github.com/typst/typst)
