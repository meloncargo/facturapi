module Facturapi
  module Helpers
    class DescuentoGlobal < DscRcgGlobal
      def initialize(params = {})
        params[:tpo_mov] = 'D'
        super(params)
      end
    end
  end
end
