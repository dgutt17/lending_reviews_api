module Error
    module ErrorHandler
        def self.included(clazz)
            clazz.class_eval do 
                rescue_from Errno::ENOENT do |e|
                    respond(:enoent, e.message)
                end

                rescue_from ActiveRecord::RecordNotFound do |e|
                    respond(:no_record, e.message)
                end

                rescue_from StandardError do |e|
                    respond(:standard, e.message)
                end
            end
        end

        private
         def respond(error_type, error_message)
            if error_type == :enoent || error_type == :no_record
                render json: {error_message: error_message}, status: 404
            else
                render json: {error_message: error_message}, status: 500
            end
         end
    end
end