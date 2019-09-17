module Error
    module ErrorHandler
        def self.included(clazz)
            clazz.class_eval do 
                rescue_from StandardError do |e|
                    respond(:standard, e.message)
                end

                rescue_from OpenURI::HTTPError do |e|
                    respond(:http_error, e.message)
                end

                rescue_from Errno::ENOENT do |e|
                    respond(:enoent, e.message)
                end
            end
        end

        private
         def respond(error_type, error_message)
            if error_type == :http_error || error_type == :enoent
                render json: {error_message: error_message}, status: 404
            else
                render json: {error_message: error_message}, status: 500
            end
         end
    end
end