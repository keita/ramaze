module Ramaze

  # RedirectHelper actually takes advantage of LinkHelper.link_raw to build the links
  # it redirects to.
  # It doesn't do much else than this:
  #     setting a status-code of 303 and a head['Location'] = link
  # returning some nice text for visitors who insist on ignoring those hints :P
  #
  # example of usage:
  #   redirect MainController
  #   redirect MainController, :foo
  #   redirect 'foo/bar'
  #
  # TODO:
  #   - setting custom status-code, it ignores any preset ones at the moment
  #   - maybe some more options, like a delay
  #

  module RedirectHelper

    # Usage:
    #   redirect MainController
    #   redirect MainController, :foo
    #   redirect 'foo/bar'

    def redirect *target
      target = target.join('/')
      response.head['Location'] = target
      response.code = 303
      %{Please follow <a href="#{target}">#{target}</a>!}
    end
  end
end