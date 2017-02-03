require 'base64'

module Facturapi
  class Config
    # Set and gets the default facturacion user
    def fact_user(user = nil)
      @user = user if user
      Base64.strict_encode64(@user || ENV['FACTURACION_USER'])
    end

    # Set and gets the default facturacion rut
    def fact_rut(rut = nil)
      @rut = rut if rut
      Base64.strict_encode64(@rut || ENV['FACTURACION_RUT'])
    end

    # Set and gets the default facturacion password
    def fact_password(password = nil)
      @password = password if password
      Base64.strict_encode64(@password || ENV['FACTURACION_PASSWORD'])
    end

    # Set and gets the default facturacion port
    def fact_port(port = nil)
      @port = port if port
      Base64.strict_encode64((@port || ENV['FACTURACION_PORT']).to_s)
    end
  end

  # Returns the configuration object
  # @return [Facturapi::Config] the configuration object
  def self.config
    @config ||= Config.new
  end

  # Configure the app defaults simply by doing
  #
  #     Facturapi.configure do |config|
  #       config.fact_rut '1-9'
  #       config.fact_user 'juan'
  #       config.fact_password 'perez'
  #       config.fact_port 9350
  #     end
  #
  # @yield [Facturapi::Config] The config object
  def self.configure
    yield(config)
    nil
  end
end
