defmodule Desafio2Web.ErrorView do
  use Desafio2Web, :view

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end

  def render("500.html", _assigns) do
   case Sentry.get_last_event_id_and_source() do
     {event_id, :plug} when is_binary(event_id) ->
       opts =
         # can do %{eventId: event_id, title: "My custom title"}
         %{eventId: event_id}
         |> Jason.encode!()

       ~E"""
         <script src="https://browser.sentry-cdn.com/5.9.1/bundle.min.js" integrity="sha384-/x1aHz0nKRd6zVUazsV6CbQvjJvr6zQL2CHbQZf3yoLkezyEtZUpqUNnOLW9Nt3v" crossorigin="anonymous"></script>
         <script>
           Sentry.init({ dsn: '<%= Sentry.Config.dsn() %>' });
           Sentry.showReportDialog(<%= raw opts %>)
         </script>
       """

     _ ->
       "Internal Server Error"
    end
   end
end
