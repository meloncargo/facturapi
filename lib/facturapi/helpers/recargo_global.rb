module Facturapi
  module Helpers
    class RecargoGlobal < DscRcgGlobal
      def initialize(params = {})
        params[:tpo_mov] = 'R'
        super(params)
      end
    end
  end
end
