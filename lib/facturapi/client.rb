require 'savon'

module Facturapi
  class Client
    class << self
      def call(method, params = {})
        params[:login] ||= login
        client.call(method, message: params)
      end

      def xml(method, params = {})
        ops = client.operation(method)
        params[:login] ||= login
        Nokogiri::XML(ops.build(message: params).to_s).to_s
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
