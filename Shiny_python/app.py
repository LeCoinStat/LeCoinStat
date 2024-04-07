from shiny import App, render, ui

app_ui = ui.page_fluid(
    ui.input_date_range("daterange", "Date range", start="2020-01-01"),  
    ui.output_text("value"),
)

def server(input, output, session):
    @render.text
    def value():
        return f"{input.daterange()[0]} to {input.daterange()[1]}"

app = App(app_ui, server)