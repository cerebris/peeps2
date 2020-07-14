module JSONAPI
  class RequestParser
    def setup_publish_action(params, resource_klass)
      resolve_singleton_id(params, resource_klass)
      fields = parse_fields(resource_klass, params[:fields])
      include_directives = parse_include_directives(resource_klass, params[:include])
      id = params[:id]

      JSONAPI::Operation.new(
        :publish,
        resource_klass,
        context: @context,
        id: id,
        include_directives: include_directives,
        fields: fields,
        allowed_resources: params[:allowed_resources]
      )
    end
  end
end