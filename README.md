# self-signed-certificate-generator
self-signed certificate generator (ruby on rails application)
# SSL Certificate Management in Ruby on Rails

This project includes scripts for managing SSL certificates in a Ruby on Rails environment. The provided scripts cover tasks such as generating self-signed certificates, creating a basic web server with SSL certificates, and testing certificate expiration dates.

## Contents

1. [Getting Started](#getting-started)
2. [Usage](#usage)
3. [Dependencies](#dependencies)

## Getting Started

Follow these steps to integrate SSL certificate management into your Ruby on Rails project:

1. **Create a new directory for SSL management:**

    ```bash
    mkdir ssl_management
    ```

2. **Add the provided Ruby scripts:**

    - Move or copy `certificate_generator.rb`, `web_server.rb`, `test_connection_program.rb`, and `Rakefile` into the `ssl_management` directory.

3. **Modify `Rakefile` for Rails environment:**

    - Update the `Rakefile` to load the Rails environment. Add the following lines at the beginning of the `Rakefile`:

        ```ruby
        require File.expand_path('../config/application', __dir__)
        Rails.application.load_tasks
        ```

4. **Update file paths in scripts:**

    - Adjust file paths in the scripts to match the new directory structure. Update paths like `'ca_key.pem'` to `'ssl_management/ca_key.pem'` in `certificate_generator.rb`.

5. **Run the Rake task:**

    - In your Rails project root, run the Rake task:

        ```bash
        rake test
        ```

## Usage

1. **Generate SSL Certificates:**

    Run the certificate generator script to create a CA and a certificate signed by that CA.

    ```bash
    ruby ssl_management/certificate_generator.rb
    ```

2. **Start the Web Server:**

    Run the web server script to expose a REST API responding with the certificate expiration date to every request.

    ```bash
    ruby ssl_management/web_server.rb
    ```

3. **Test Certificate Expiration Date:**

    Run the test connection program to check the expiration date of the server certificate using the generated CA certificate.

    ```bash
    rake test
    ```

## Dependencies

- Ruby
- OpenSSL
- Rake
- WEBrick

Make sure to have these dependencies installed in your Rails environment before running the scripts.


