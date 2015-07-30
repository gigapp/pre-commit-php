# Hootsuite - PHP Pre-commit Hooks

Pre-commit scripts appropiate for *any* PHP project. These hooks are made as custom plugins under the [pre-commit](http://pre-commit.com/#new-hooks) git hook framework.

# Setup

Just add to your `.pre-commit-config.yaml` file with the following

```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-lint
  - id: php-unit
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1 -p]
```

# Supported Hooks

## php-lint

```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-lint
```

A bash script that runs `php -l` against stage files that are php. Assumes `php` is a global executable command. Will exit when it hits the first syntax error.

## php-lint-all

```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-lint-all
```

A systems hook that just runs `php -l` against stage files that have the `.php` extension. Add the `args: [-s first]` in your `.pre-commit-config.yaml` to enable it to exit on the first error found.

## php-unit


```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-unit
```

A bash script that will run the appropriate phpunit executable. It will assume
  - Find the executable to run at either `vendor/bin/phpunit`, `phpunit` or `php phpunit.phar` (in that exact order).
  - There is already a `phpunit.xml` in the root of the repo

Note in its current state, it will run the whole PHPUnit test as along as `.php` file was committed.

## php-cs

```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1 -p]
```

Similar pattern as the php-unit hook. A bash script that will run the appropriate [PHP Code Sniffer](https://github.com/squizlabs/PHP_CodeSniffer) executable.

It will assume that there is a valid PHP Code Sniffer executable at these locations, `vendor/bin/phpcs`, `phpcs` or `php phpcs.phar` (in that exact order).

The `args` property in your hook declaration can be used for pass any valid PHP Code Sniffer arguments. In the example above, it will run PHP Code Sniffer against only the staged php files with the `PSR-1` and progress enabled.

If you have multiple standards or a comma in your `args` property, escape the comma character like so

```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1/,path/to/ruleset.xml -p]
```

To install PHP Codesniffer, follow the [recommended steps here](https://github.com/squizlabs/PHP_CodeSniffer#installation).
