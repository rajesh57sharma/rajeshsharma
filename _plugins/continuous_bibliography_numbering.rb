
module Jekyll
  class Scholar
    class BibliographyTag

      module ContinuousIndex

        def render(context)
          @publication_index = 0
          super
        end

        def render_items(items)
          bibliography = items.compact.map do |entry|
            @publication_index += 1

            reference = bibliography_tag(entry, @publication_index)

            if generate_details? && generate_details_link?
              reference << link_to(
                details_link_for(entry),
                config['details_link'],
                :class => config['details_link_class']
              )
            end

            content_tag(
              config['bibliography_item_tag'],
              reference,
              config['bibliography_item_attributes']
            )
          end.join("\n")

          content_tag(
            bibliography_list_tag,
            bibliography,
            { :class => config['bibliography_class'] }
              .merge(config['bibliography_list_attributes'])
          )
        end

      end

      prepend ContinuousIndex

    end
  end
end
