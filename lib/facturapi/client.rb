require 'savon'

module Facturapi
  class Client
    class << self
      def call(method, params = {})
        params[:login] ||= login
        response = client.call(method, message: params)
        response.body[:procesar_response][:procesar_result]
      end

      def client
        @client ||= Savon.client(
          wsdl: 'http://ws1.facturacion.cl/WSDS/wsplano.asmx?wsdl'
        )
      end

      def operations
        client.operations
      end

      private

      def login
        @login ||= {
          'Usuario' => Facturapi.config.fact_user,
          'Rut' => Facturapi.config.fact_rut,
          'Clave' => Facturapi.config.fact_password,
          'Puerto' => Facturapi.config.fact_port
        }
      end
    end
  end
end
