library(shiny)
library(bslib)
library(querychat)


# rsconnect::writeManifest(appDir = "test5_querychat_updated")

querychat_config <- querychat_init(mtcars, 
                                   create_chat_func = purrr::partial(
                                     ellmer::chat_anthropic, 
                                     model = "claude-3-5-sonnet-20241022"
                                   ),
                                   greeting = "hello you" )

ui <- page_sidebar(
  sidebar = querychat_sidebar("chat"),
  DT::DTOutput("dt")
)

server <- function(input, output, session) {
  
  querychat <- querychat_server("chat", querychat_config)
  
  output$dt <- DT::renderDT({
    DT::datatable(querychat$df())
  })
}

shinyApp(ui, server)