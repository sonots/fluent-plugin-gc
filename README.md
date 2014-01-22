# fluent-plugin-gc [![Build Status](https://secure.travis-ci.org/sonots/fluent-plugin-gc.png?branch=master)](http://travis-ci.org/sonots/fluent-plugin-gc)

Fluentd plugin to disable GC and start GC at arbitrary interval. This plugin is for testing only. 

## Configuration

Example: 

    <source>
      type gc
      interval 5
      disable yes
    </match>

## Parameters

- interval

    The interval to start GC in seconds. Default is 5s. 

- diable

    Disable GC. Default is `no`.

- debug

    Print out GC.stat on the fluentd log. Default is `no`.

## ChangeLog

See [CHANGELOG.md](CHANGELOG.md) for details.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new [Pull Request](../../pull/new/master)

## Copyright

Copyright (c) 2013 Naotoshi Seo. See [LICENSE](LICENSE) for details.

