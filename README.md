# Hootsuite - PHP Pre-commit Hooks

Pre-commit scripts appropiate for *any* PHP project. These hooks are made as custom plugins under the [pre-commit](http://pre-commit.com/#new-hooks) git hook framework.

# Setup

Just add to your `.pre-commit-config.yaml` file with the following

```yaml
- repo: git@github.com/hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-lint
  - id: php-unit
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1 -p]
  - id: php-md
    files: \.(php)$
    args: ["cleancode,codesize,controversial,design,naming,unusedcode"]
```

# Supported Hooks

## php-lint

```yaml
- repo: git@github.com/hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-lint
```

A bash script that runs `php -l` against stage files that are php. Assumes `php` is a global executable command. Will exit when it hits the first syntax error.

## php-lint-all

```yaml
- repo: git@github.com/hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-lint-all
```

A systems hook that just runs `php -l` against stage files that have the `.php` extension. Add the `args: [-s first]` in your `.pre-commit-config.yaml` to enable it to exit on the first error found.

## php-unit


```yaml
- repo: git@github.com/hootsuite/pre-commit-php.git
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
- repo: git@github.com/hootsuite/pre-commit-php.git
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
- repo: git@github.com/hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-cs
    files: \.(php)$
    args: [--standard=PSR1/,path/to/ruleset.xml -p]
```

To install PHP Codesniffer, follow the [recommended steps here](https://github.com/squizlabs/PHP_CodeSniffer#installation).

## php-md

```yaml
- repo: git@github.com:hootsuite/pre-commit-php.git
  sha: 1.0.0
  hooks:
  - id: php-md
    files: \.(php)$
    args: ["cleancode,codesize,controversial,design,naming,unusedcode"]
```

A bash script that will run the appropriate [PHP Mess Detector](https://github.com/phpmd/phpmd) executable.

It will assume that there is a valid PHP Mess Detector executable at these locations, `vendor/bin/phpmd`, `phpmd` or `php phpmd.phar` (in that exact order).

### args

The `args` property in your hook declaration contains a quoted comma-separated list of [rule sets](http://phpmd.org/documentation/index.html#using-multiple-rule-sets) to use. These can be a combination of the [built-in rule sets](https://github.com/phpmd/phpmd/tree/master/src/main/resources/rulesets) and [custom rule sets](http://phpmd.org/documentation/creating-a-ruleset.html).

For example, if you want to use the [`unusedcode`](https://github.com/phpmd/phpmd/blob/master/src/main/resources/rulesets/unusedcode.xml) built-in rule set, together with a custom rule set file called `.phpmd_ruleset.xml` in the root directory of your repo, then `args` should be:

```yaml
    args: ["unusedcode,.phpmd_ruleset.xml"]
```
