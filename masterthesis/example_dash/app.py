import dash
import pandas as pd
import dash_core_components as dcc
import dash_html_components as html
import plotly.express as px



# loading css stylesheet
external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']


# Initialize a dash object
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)


# Reading a dataframe
df = px.data.iris()
# Creating a figure 
fig = px.scatter(df, x="sepal_width", y="sepal_length", color="species")



# make some layout
app.layout = html.Div(children=[
    html.H2(children='Library Dashboard'),
    
    html.H3(children='Ausgaben für den Printbestand'),
    
    dcc.Graph(
        id='example-graph',
        figure=fig
    )
])


# create a  database

# create a database connection


# load from database into pandas dataframe

# make some analysis of the data

# show some diagramms


# filter the data using callbacks and update the graph





# run app
if __name__ == "__main__":
    app.run_server()