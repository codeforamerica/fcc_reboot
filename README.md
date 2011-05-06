FCC Reboot
=======
A Ruby wrapper for the FCC Reboot APIs.

Does your project or organization use this gem?
------------------------------------------
Add it to the [apps](http://github.com/cfalabs/fcc_reboot/wiki/apps) wiki!

Installation
------------
    gem install fcc_reboot

Usage Examples
--------------
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

Contributing
------------
In the spirit of [free software](http://www.fsf.org/licensing/essays/free-sw.html), **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using alpha, beta, and prerelease versions
* by reporting bugs
* by suggesting new features
* by writing or editing documentation
* by writing specifications
* by writing code (**no patch is too small**: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues](http://github.com/cfalabs/fcc_reboot/issues)
* by reviewing patches

Submitting an Issue
-------------------
We use the [GitHub issue tracker](http://github.com/cfalabs/fcc_reboot/issues) to track bugs and
features. Before submitting a bug report or feature request, check to make sure it hasn't already
been submitted. You can indicate support for an existing issuse by voting it up. When submitting a
bug report, please include a [Gist](http://gist.github.com/) that includes a stack trace and any
details that may be necessary to reproduce the bug, including your gem version, Ruby version, and
operating system. Ideally, a bug report should include a pull request with failing specs.

Submitting a Pull Request
-------------------------
1. Fork the project.
2. Create a topic branch.
3. Implement your feature or bug fix.
4. Add documentation for your feature or bug fix.
5. Run <tt>bundle exec rake doc:yard</tt>. If your changes are not 100% documented, go back to step 4.
6. Add specs for your feature or bug fix.
7. Run <tt>bundle exec rake spec</tt>. If your changes are not 100% covered, go back to step 6.
8. Commit and push your changes.
9. Submit a pull request. Please do not include changes to the gemspec, version, or history file. (If you want to create your own version for some reason, please do so in a separate commit.)

Copyright
---------
Copyright (c) 2010 Code for America Laboratories
See [LICENSE](https://github.com/cfalabs/fcc_reboot/blob/master/LICENSE.md) for details.
