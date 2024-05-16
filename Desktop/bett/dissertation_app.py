import streamlit as st
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
import numpy as np

# Load and clean data
@st.cache
def load_data():
    data = pd.read_csv(r'C:\Users\USER\Music\data_set1.csv', encoding='ISO-8859-1')
    data.columns = [col.strip().lower().replace(' ', '_') for col in data.columns]
    data['year'] = data['ï»¿year']
    data['carbon_emission'] = data['carbon_emission_(tons)']
    data = data.drop('ï»¿year', axis=1)
    data['carbon_emission_(tons)'] = data['carbon_emission_(tons)'].replace('[^0-9.]', '', regex=True).astype(float)
    data['carbon_emission_(tons)'].ffill(inplace=True)
    return data

data = load_data()

# Sidebar for user input
analysis_type = st.sidebar.selectbox("Select Analysis Type", [
    "Carbon Emission", "Waste Management", "Revenue Trends", "EBITDA Trends", 
    "Carbon Intensity Ratio", "Employee Efficiency Ratio", "Year-over-Year Growth", 
    "Regression Analysis for EBITDA Projection", "Correlation Analysis of ESG Factors", 
    "Future Scenarios Simulation", "Correlation Analysis Financial and ESG Factors"])

# Main panel
st.title(f"{analysis_type} Analysis")

if analysis_type == "Carbon Emission":
    plt.figure(figsize=(12, 6))
    sns.lineplot(x='year', y='carbon_emission_(tons)', data=data, marker='o')
    plt.title('Trend of Carbon Emissions Over the Years')
    plt.xlabel('Year')
    plt.ylabel('Carbon Emissions (tons)')
    plt.grid(True)
    st.pyplot(plt)

elif analysis_type == "Carbon Intensity Ratio":
    data['carbon_intensity_ratio'] = data['carbon_emission_(tons)'] / data['revenue_(billions)']
    plt.figure(figsize=(12, 6))
    sns.lineplot(x='year', y='carbon_intensity_ratio', data=data, marker='o')
    plt.title('Trend of Carbon Intensity Ratio Over the Years')
    plt.xlabel('Year')
    plt.ylabel('Carbon Intensity Ratio (tons per billion $)')
    plt.grid(True)
    st.pyplot(plt)

elif analysis_type == "Employee Efficiency Ratio":
    data['employee_efficiency_ratio'] = data['ebitda_(billions)'] * 1000 / data['number_of_employees']
    plt.figure(figsize=(12, 6))
    sns.lineplot(x='year', y='employee_efficiency_ratio', data=data, marker='o')
    plt.title('Trend of Employee Efficiency Ratio Over the Years')
    plt.xlabel('Year')
    plt.ylabel('Employee Efficiency Ratio (millions $ per employee)')
    plt.grid(True)
    st.pyplot(plt)

elif analysis_type == "Year-over-Year Growth":
    data['revenue_yoy_growth'] = data['revenue_(billions)'].pct_change() * 100
    data['carbon_emission_yoy_growth'] = data['carbon_emission_(tons)'].pct_change() * 100
    plt.figure(figsize=(12, 6))
    sns.lineplot(x='year', y='revenue_yoy_growth', data=data, marker='o', label='Revenue Growth')
    sns.lineplot(x='year', y='carbon_emission_yoy_growth', data=data, marker='o', label='Carbon Emission Growth')
    plt.title('Year-over-Year Growth for Revenue and Carbon Emissions')
    plt.xlabel('Year')
    plt.ylabel('Growth (%)')
    plt.legend()
    plt.grid(True)
    st.pyplot(plt)

elif analysis_type == "Regression Analysis for EBITDA Projection":
    # Assuming additional steps for model training and prediction are defined
    pass

elif analysis_type == "Correlation Analysis of ESG Factors":
    correlation_matrix = data[['ebitda_(billions)', 'revenue_(billions)', 'carbon_emission_(tons)', 'waste_management_(tons)']].corr()
    plt.figure(figsize=(10, 8))
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt=".2f")
    plt.title('Correlation Matrix of ESG Factors and Financial Performance')
    st.pyplot(plt)

elif analysis_type == "Future Scenarios Simulation":
    # Assuming code for simulation and plotting is defined
    pass

elif analysis_type == "Correlation Analysis Financial and ESG Factors":
    correlation_matrix = data[['ebitda_(billions)', 'revenue_(billions)', 'carbon_emission_(tons)', 'waste_management_(tons)', 'gross_margin_(%)']].corr()
    plt.figure(figsize=(10, 8))
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt=".2f")
    plt.title('Correlation Matrix of Financial Metrics and ESG Factors')
    st.pyplot(plt)

# Optional: Additional visualization or analysis options
if st.checkbox('Show Additional Analysis'):
    # Additional analysis code here
    st.write("Additional analysis details can go here.")

st.write("Data used in this analysis:")
st.dataframe(data.head())
