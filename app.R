library(shiny)
library(bslib)
library(querychat)

querychat_config <- querychat_init(mtcars, greeting = "hello you" )

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