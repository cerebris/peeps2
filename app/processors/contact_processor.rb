class ContactProcessor < JSONAPI::Processor
  define_jsonapi_resources_callbacks :publish

  def publish
    resource_id = params[:resource_id]
    include_directives = params[:include_directives]
    fields = params[:fields]
    serializer = params[:serializer]

    resource = resource_klass.find_by_key(resource_id, context: context)

    result = resource.publish

    find_options = {
      context: context,
      fields: fields,
      filters: { resource_klass._primary_key => resource.id },
      include_directives: include_directives
    }

    resource_set = find_resource_set(resource_klass,
                                     include_directives,
                                     find_options)

    resource_set.populate!(serializer, context, find_options)

    JSONAPI::ResourceSetOperationResult.new((result == :completed ? :ok : :accepted), resource_set, result_options)
  end
end