# Dynamic53

Simple ruby executable that will allow you to setup 'dynamic dns' to a local network like dyndns or any other dynamic dns service using Route 53 and Ruby

## Installation

Add this line to your application's Gemfile:

    gem 'dynamic53'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynamic53

Now setup a `~/.dynamic53` file in your home directory with the AWS access key and secret comma delimited like

    echo "xxxx,xxxx" > ~/.dynamic53

## Usage

Now that the gem is installed you can run

    $ dynamic53 {{user}} {{zonename}} {{somesubdomain}}    

Or if you'd like it to use a stringified version of the bonjour name use

    $ dynamic53 {{user}} {{zonename}}

This will update the route 53 record with the machines current ip.

## Simple Easy and Effective :)

If it doesn't work for you well I'm sorry maybe I'll fix it later.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
