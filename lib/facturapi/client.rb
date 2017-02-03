require 'savon'

module Facturapi
  class Client
    attr_accessor :client
    attr_reader :login

    def initialize
      @login = {
        'Usuario' => Facturapi.config.fact_user,
        'Rut' => Facturapi.config.fact_rut,
        'Clave' => Facturapi.config.fact_password,
        'Puerto' => Facturapi.config.fact_port
      }
      @client = Savon.client(
        wsdl: 'http://ws1.facturacion.cl/WSDS/wsplano.asmx?wsdl'
      )
    end

    def call(method, params = {})
      params[:login] ||= login
      puts params
      response = @client.call(method, message: params)
      response.body[:procesar_response][:procesar_result]
    end
  end
end
