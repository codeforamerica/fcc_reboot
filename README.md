# FCC Reboot [![Build Status](https://secure.travis-ci.org/codeforamerica/fcc_reboot.png)][travis]
A Ruby wrapper for the FCC Reboot APIs.

[travis]: http://travis-ci.org/codeforamerica/fcc_reboot

## Does your project or organization use this gem?
Add it to the [apps](https://github.com/codeforamerica/fcc_reboot/wiki/apps) wiki!

## Installation
    gem install fcc_reboot

## Read the FCC API Docs
1. [Spectrum Dashboard](http://www.fcc.gov/developer/spectrum-dashboard-api)
2. [License View](http://www.fcc.gov/developer/license-view-api)
3. [Census Block](http://www.fcc.gov/developer/census-block-conversions-api)
4. [FCC Registration Number Conversions](http://www.fcc.gov/developer/frn-conversions-api)

## Usage Examples
    require 'fcc_reboot'

    # Provide speed test statistics for a US County given the passed Latitude and Longitude
    FccReboot.broadband_test(:latitude => '38.0', :longitude => '-77.5')

    # Returns a list of the frequency bands
    FccReboot.get_spectrum_bands(:frequencyFrom=>'226', :frequencyTo => '900')

    # Provide high level overview of who owns spectrum across the country within the 225 MHz to 3700 MHz frequency
    FccReboot.get_spectrum_licenses(:name=> 'AT', :radioservice=>'Cellular')

    # Provide census block info for the given latitude and longitude
    FccReboot.find_census_block(:latitude => '38.0', :longitude => '-77.5')

    # Provide FRN list for the state of Illinois
    FccReboot.frn_getlist(:stateCode => 'IL', :multi => 'No')

    # Provide FRN info for Cygnus Telecommunications Corporation (FRN number 0017855545)
    FccReboot.find_census_block(:frn => '0017855545')

    # Returns the number of licenses up for renewal in a given month for Sprint Nextel.
    FccReboot.get_issued(:commonName=> 'Sprint Nextel')

    # Returns the counts and percent distribution of active licenses by entity type
    FccReboot.get_renewals()

    # Provide number of licenses that were issued by the Commission on a yearly basis
    FccReboot.get_licenses(:searchValue => 'Verizon Wireless')

    # Returns the license counts and percent distribution by status.
    FccReboot.get_statuses(:commonName => 'Sprint Nextel')

## Contributing
In the spirit of [free software][free-sw], **everyone** is encouraged to help improve
this project.

[free-sw]: http://www.fsf.org/licensing/essays/free-sw.html

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up
  inconsistent whitespace)
* by refactoring code
* by fixing [issues][]
* by reviewing patches
* [financially][]

[issues]: https://github.com/codeforamerica/fcc_reboot/issues
[financially]: https://secure.codeforamerica.org/page/contribute

## Submitting an Issue
We use the [GitHub issue tracker][issues] to track bugs and features. Before
submitting a bug report or feature request, check to make sure it hasn't
already been submitted. When submitting a bug report, please include a [Gist][]
that includes a stack trace and any details that may be necessary to reproduce
the bug, including your gem version, Ruby version, and operating system.
Ideally, a bug report should include a pull request with failing specs.

[gist]: https://gist.github.com/

## Submitting a Pull Request
1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Add specs for your unimplemented feature or bug fix.
4. Run `bundle exec rake spec`. If your specs pass, return to step 3.
5. Implement your feature or bug fix.
6. Run `bundle exec rake spec`. If your specs fail, return to step 5.
7. Run `open coverage/index.html`. If your changes are not completely covered
   by your tests, return to step 3.
8. Add documentation for your feature or bug fix.
9. Run `bundle exec rake yard`. If your changes are not 100% documented, go
   back to step 8.
10. Add, commit, and push your changes.
11. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## Supported Rubies
This library aims to support and is [tested against][travis] the following Ruby
implementations:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* [Rubinius](http://rubini.us/)

If something doesn't work on one of these interpreters, it should be considered
a bug.

This library may inadvertently work (or seem to work) on other Ruby
implementations, however support will only be provided for the versions listed
above.

If you would like this library to support another Ruby version, you may
volunteer to be a maintainer. Being a maintainer entails making sure all tests
run and pass on that implementation. When something breaks on your
implementation, you will be personally responsible for providing patches in a
timely fashion. If critical issues for a particular implementation exist at the
time of a major release, support for that Ruby version may be dropped.

## Copyright
Copyright (c) 2010 Code for America. See [LICENSE][license] for details.

[license]: https://github.com/codeforamerica/fcc_reboot/blob/master/LICENSE.md

[![Code for America Tracker](http://stats.codeforamerica.org/codeforamerica/fcc_reboot.png)](http://stats.codeforamerica.org/projects/fcc_reboot)
