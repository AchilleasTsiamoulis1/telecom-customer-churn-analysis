import pandas as pd

#df = pd.read_excel("c:/Users/Achilleas/Desktop/Maven Telecom Project/Telecom+Customer+Churn/Excel/telecom_customer_churn_copy_XLSX.xlsx")
df = pd.read_excel("c:/Users/Achilleas/Desktop/Maven Telecom Project/Telecom+Customer+Churn/Excel/telecom_customer_churn_copy_XLSX.xlsx", sheet_name="telecom_customer_churn_copy")

#Rows and columns
#print(df.shape) #It loaded something wrong

#5 first rows
#print(df.head()) #Noticed that loaded the pivot table

#print(pd.ExcelFile("c:/Users/Achilleas/Desktop/Maven Telecom Project/Telecom+Customer+Churn/telecom_customer_churn_copy_XLSX.xlsx").sheet_names) #Found the names of the excel sheets and then changed the read_excel

#print(df.columns) #Names of the columns 
#print(df.info()) #Info about the columns. Some are not 7043. Probably the blank ones

#print(df.isnull().sum()) #Sum of null values that coincide with the numbers before

#print(df.describe()) #Basic descriptive statistics

#Customer Status Distribution
#print(df["Customer Status"].value_counts())

#Churn Rate
churned_count = (df["Customer Status"] == "Churned").sum()
churn_rate = round((churned_count/len(df) * 100), 2)
#print("Churned rate:",  churn_rate)

#Churn Rate per Contract
df["Is_Churned"] = df["Customer Status"] == "Churned"
churned_by_contract = df.groupby("Contract")["Is_Churned"].sum()
total_by_contract = df.groupby("Contract").size()
churn_rate_by_contract = churned_by_contract / total_by_contract * 100
#print(churn_rate_by_contract.round(2))

#Churn per Tenure
#df["Is_Churned"] = df["Customer Status"] == "Churned"
churned_by_tenure = df.groupby("Tenure in Groups")["Is_Churned"].sum()
total_by_tenure = df.groupby("Tenure in Groups").size()
churn_rate_by_tenure = churned_by_tenure / total_by_tenure * 100
#print(churn_rate_by_tenure.round(2))

#Churn per Internet Type
#df["Is_Churned"] = df["Customer Status"] == "Churned"
churned_by_internet_type = df.groupby("Internet Type")["Is_Churned"].sum()
total_by_internet_type = df.groupby("Internet Type").size()
churn_rate_by_internet_type = churned_by_internet_type / total_by_internet_type * 100
#print(churn_rate_by_internet_type.round(2))

#Churn per Offer
#df["Is_Churned"] = df["Customer Status"] == "Churned"
churned_by_offer = df.groupby("Offer", dropna=False)["Is_Churned"].sum() #Usage of dropna in order to appear the "None" type
total_by_offer = df.groupby("Offer", dropna=False).size()
churn_rate_by_offer = churned_by_offer / total_by_offer * 100
churn_rate_by_offer.index = churn_rate_by_offer.index.astype("string").fillna("None") #Rename the NaN with None
#rint(churn_rate_by_offer.round(2))

#Churn per Payment Method
#df["Is_Churned"] = df["Customer Status"] == "Churned"
churned_by_payment_method = df.groupby("Payment Method")["Is_Churned"].sum()
total_by_payment_method = df.groupby("Payment Method").size()
churn_rate_by_payment_method = churned_by_payment_method / total_by_payment_method * 100
#print(churn_rate_by_payment_method.round(2))

#Churn per Age Group
#df["Is_Churned"] = df["Customer Status"] == "Churned"
churned_by_age_group = df.groupby("Age Group")["Is_Churned"].sum()
total_by_age_group = df.groupby("Age Group").size()
churn_rate_by_age_group = churned_by_age_group / total_by_age_group * 100
#print(churn_rate_by_age_group.round(2))

#Average Monthly Charge per Customer Status
average_monthly_charge_per_customer_status = df.groupby("Customer Status")["Monthly Charge"].mean().round(2)
#print(average_monthly_charge_per_customer_status) #Barely same values with MYSQL. I might check it later.

#Average Total Revenue per Customer Status
average_total_revenue_per_customer_status = df.groupby("Customer Status")["Total Revenue"].mean().round(2)
#print(average_total_revenue_per_customer_status)

#Average Tenure per Customer Status
average_tenure_per_customer_status = df.groupby("Customer Status")["Tenure in Months"].mean().round(2)
#print(average_tenure_per_customer_status)

#Average Monthly Long Distance Charges
average_monthly_long_distance_charges = df.groupby("Customer Status")["Avg Monthly Long Distance Charges"].mean().round(2)
#print(average_monthly_long_distance_charges)

#Average Monthly Charge per Contract and Customer Status
average_monthly_charge_per_contract_and_customer_status = df.groupby(["Customer Status", "Contract"])["Monthly Charge"].mean().round(2)
#print(average_monthly_charge_per_contract_and_customer_status) #Barely same values with MYSQL, but now we have to find the issue.

#print(df.groupby(["Contract", "Customer Status"]).size()) #Same as MYSQL, so the customer groups are the same. We have to check if MYSQL and Python use the same column and values.
#print(df["Monthly Charge"].describe()) #There are 120 less values (7043 total). 120 were the negative values in Excel where I changed them to blank. Now we move to MYSQL
#print(df.nlargest(10, "Monthly Charge")[["Customer ID", "Monthly Charge"]]) #Top 10 largest Monthly Charges. Again move to MYSQL

#Average Total Revenue per Customer Status and Contract
average_total_revenue_per_customer_status_contract = df.groupby(["Customer Status", "Contract"])["Total Revenue"].mean().round(2)
#print(average_total_revenue_per_customer_status_contract)

#Average Tenure in Months per Customer Status and Contract
average_tenure_per_customer_status_and_contract = df.groupby(["Customer Status", "Contract"])["Tenure in Months"].mean().round(2)
#print(average_tenure_per_customer_status_and_contract)

#Average Total Charges per Customer Status and Contract
average_total_charges_per_customer_status_and_contract = df.groupby(["Customer Status", "Contract"])["Total Charges"].mean().round(2)
#print(average_total_charges_per_customer_status_and_contract)

#Analyzing the Churn Category and Churn Reason columns
#How many customers left for each category-reason
#print(df["Churn Category"].value_counts(dropna=False))
#print(df["Churn Reason"].value_counts(dropna=False))

#Percentage of these values
churn_reasons = df["Churn Reason"].value_counts()

churn_reason_percentages = (
    churn_reasons / churn_reasons.sum() * 100
)

#print(churn_reason_percentages.round(2))

#I want to ensure that the Churn Reason column contains the reasons of all the 1869 churned customers. 
#print("Customer Status:")
#print(df["Customer Status"].value_counts(dropna=False))

#print("\nChurn Reason - non-null values:")
#print(df["Churn Reason"].notna().sum())

#print("\nChurn Category:")
#print(df["Churn Category"].value_counts(dropna=False))

#The first basic analysis
churned_df = df[df["Customer Status"] == "Churned"]

reason_analysis = (
    churned_df.groupby(["Churn Category", "Churn Reason"])
    .size()
    .reset_index(name="Customers")
    .sort_values(
        ["Churn Category", "Customers"],
        ascending=[True, False]
    )
)

#print(reason_analysis)

#The final analysis
reason_analysis["Category Total"] = (
    reason_analysis.groupby("Churn Category")["Customers"]
    .transform("sum")
)

reason_analysis["Within Category (%)"] = (
    reason_analysis["Customers"]
    / reason_analysis["Category Total"]
    * 100
)

print(
    reason_analysis[
        ["Churn Category", "Churn Reason", "Customers", "Within Category (%)"]
    ].round(2)
)

#####################################################################
################ VISUALIZATIONS ########################
#Here we are reusing the previous findings to perform visualizations
import matplotlib.pyplot as plt

#Churn per contract
'''
bars = plt.bar(churn_rate_by_contract.index, churn_rate_by_contract.values) #Create the bar 

plt.title("Churn Rate by Contract") #The name of the title
plt.xlabel("Contract Type") #The name of the x axis
plt.ylabel("Churn Rate (%)") #The name of the y axis

plt.ylim(0, 60) #Defines the scale of the vertical axis.
plt.bar_label(bars, fmt="%.2f%%", padding=3) #Displays the values above the bars, formats the values to two decimal places and leaves a small gap between the top of each bar and its label.

plt.grid(axis="y", linestyle="--", alpha=0.4) #It adds horizontal lines so that we can compare the percentages more easily, makes the lines dashed and makes them more discreet.
plt.gca().set_axisbelow(True) #Positions the mesh behind the bars.
plt.tight_layout() #Adjusts the margins so that titles and labels are not crowded.

plt.show() #Shows the visualization
'''

#Churn per Tenure Group
'''
tenure_order = [
  "0-6",
  "7-12",
  "13-24",
  "25-36",
  "37-48",
  "49-60",
  "61+"
]

churn_rate_by_tenure = churn_rate_by_tenure.reindex(tenure_order) #Changing the order to be in ascending order

bars = plt.bar(churn_rate_by_tenure.index, churn_rate_by_tenure.values)

plt.title("Churn Rate by Tenure")
plt.xlabel("Tenure in Group")
plt.ylabel("Churn Rate (%)")

plt.bar_label(bars, fmt="%.2f%%", padding=3) 

plt.grid(axis="y", linestyle="--", alpha=0.4)
plt.gca().set_axisbelow(True)
plt.tight_layout()

plt.show()
'''

#Churn per Internet Type
'''
bars = plt.bar(churn_rate_by_internet_type.index, churn_rate_by_internet_type.values)

plt.title("Churn Rate by Internet Type")
plt.xlabel("Internet Type")
plt.ylabel("Churn Rate (%)")

plt.bar_label(bars, fmt="%.2f%%", padding=3) 

plt.grid(axis="y", linestyle="--", alpha=0.4)
plt.gca().set_axisbelow(True)
plt.tight_layout()

plt.show()
'''

#Churn per Offer
'''
bars = plt.bar(churn_rate_by_offer.index, churn_rate_by_offer.values)

plt.title("Churn Rate by Offer")
plt.xlabel("Offer")
plt.ylabel("Churn Rate (%)")

plt.bar_label(bars, fmt="%.2f%%", padding=3) 

plt.grid(axis="y", linestyle="--", alpha=0.4)
plt.gca().set_axisbelow(True)
plt.tight_layout()

plt.show()
'''

#Churn per Payment Method
'''
bars = plt.bar(churn_rate_by_payment_method.index, churn_rate_by_payment_method.values)

plt.title("Churn Rate by Payment Method")
plt.xlabel("Payment Method")
plt.ylabel("Churn Rate (%)")

plt.bar_label(bars, fmt="%.2f%%", padding=3) 

plt.grid(axis="y", linestyle="--", alpha=0.4)
plt.gca().set_axisbelow(True)
plt.tight_layout()

plt.show()
'''

#Churn per Age Group
'''
age_group = [
  "Under 30",
  "30-44",
  "45-59",
  "60+"
]
churn_rate_by_age_group = churn_rate_by_age_group.reindex(age_group)

bars = plt.bar(churn_rate_by_age_group.index, churn_rate_by_age_group.values)

plt.title("Churn Rate by Age Group")
plt.xlabel("Age Group")
plt.ylabel("Churn Rate (%)")

plt.bar_label(bars, fmt="%.2f%%", padding=3) 

plt.grid(axis="y", linestyle="--", alpha=0.4)
plt.gca().set_axisbelow(True)
plt.tight_layout()

plt.show()
'''

#Average Monthly Charge by Customer Status
'''
bars = plt.bar(average_monthly_charge_per_customer_status.index, average_monthly_charge_per_customer_status.values)

plt.title("Average Monthly Charge by Customer Status")
plt.xlabel("Customer Status")
plt.ylabel("Churn Rate (%)")

plt.bar_label(bars, fmt="%.2f%%", padding=3) 

plt.grid(axis="y", linestyle="--", alpha=0.4)
plt.gca().set_axisbelow(True)
plt.tight_layout()

plt.show()
'''

#Average Monthly Charge per Contract and Customer Status
'''
average_monthly_charge_per_contract_and_customer_status = average_monthly_charge_per_contract_and_customer_status.unstack() 
It is easier to use plot because the variable contains a dataframe 
ax = average_monthly_charge_per_contract_and_customer_status.plot(
    kind="bar",
    figsize=(9, 5)
)

ax.set_title("Average Monthly Charge by Customer Status and Contract")
ax.set_xlabel("Customer Status")
ax.set_ylabel("Average Monthly Charge")

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
    ax.bar_label(container, fmt="%.2f", padding=3)

plt.tight_layout()
plt.show()
'''

#Average Total Revenue by Customer Status
'''
ax = average_total_revenue_per_customer_status.plot(
  kind="bar",
  figsize=(9, 6)
)

ax.set_title("Average Total Revenue by Customer Status")
ax.set_xlabel("Customer Status")
ax.set_ylabel("Average Total Revenue")

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
  ax.bar_label(container, fmt="%.2f", padding=3)


plt.tight_layout()
plt.show()
'''

#Average Tenure by Customer Status
'''
ax = average_tenure_per_customer_status.plot(
  kind="bar",
  figsize=(9, 6)
)

ax.set_title("Average Tenure by Customer Status")
ax.set_xlabel("Customer Status")
ax.set_ylabel("Average Tenure")

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
  ax.bar_label(container, fmt="%.2f", padding=3)


plt.tight_layout()
plt.show()

Average Tenure by Customer Status and Contract
ax = average_tenure_per_customer_status.plot(
  kind="bar",
  figsize=(9, 6)
)

ax.set_title("Average Tenure by Customer Status")
ax.set_xlabel("Customer Status")
ax.set_ylabel("Average Tenure")

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
  ax.bar_label(container, fmt="%.2f", padding=3)


plt.tight_layout()
plt.show()
'''

#Average Tenure in Months per Customer Status and Contract
'''
average_tenure_per_customer_status_and_contract = average_tenure_per_customer_status_and_contract.unstack()
ax = average_tenure_per_customer_status_and_contract.plot(
  kind="bar",
  figsize=(9, 6)
)

ax.set_title("Average Tenure by Customer Status")
ax.set_xlabel("Customer Status")
ax.set_ylabel("Average Tenure")

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
  ax.bar_label(container, fmt="%.2f", padding=3)


plt.tight_layout()
plt.show()
'''

#Average Total Charges per Customer Status and Contract
'''
average_total_charges_per_customer_status_and_contract = average_total_charges_per_customer_status_and_contract.unstack()
ax = average_total_charges_per_customer_status_and_contract.plot(
  kind="bar",
  figsize=(9, 6)
)

ax.set_title("Average Total Charges by Customer Status and Contract")
ax.set_xlabel("Customer Status")
ax.set_ylabel("Average Total Charges")

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
  ax.bar_label(container, fmt="%.2f", padding=3)


plt.tight_layout()
plt.show()
'''

#Churn per Contract and Internet Type
'''
churned_by_contract_internet_type = df.groupby(["Contract", "Internet Type"])["Is_Churned"].sum()
total_by_contract_internet_type = df.groupby(["Contract", "Internet Type"]).size()
churn_rate_by_contract_internet_type = churned_by_contract_internet_type / total_by_contract_internet_type * 100

churn_rate_by_contract_internet_type = churn_rate_by_contract_internet_type.unstack()
ax = churn_rate_by_contract_internet_type.plot(
  kind="bar",
  figsize=(9, 6)
)

ax.set_title("Churn per Contract and Internet Type")
ax.set_xlabel("Contract")
ax.set_ylabel("Churn Rate")

x.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

for container in ax.containers:
  ax.bar_label(container, fmt="%.2f", padding=3)

plt.tight_layout()
plt.show()
'''

#Churn per Contract, Internet Type and Offer
'''
churned_by_contract_internet_type_offer = df.groupby(["Contract", "Internet Type", "Offer"], dropna=False)["Is_Churned"].sum()
total_by_contract_internet_type_offer = df.groupby(["Contract", "Internet Type", "Offer"], dropna=False).size()
churn_rate_by_contract_internet_type_offer = churned_by_contract_internet_type_offer / total_by_contract_internet_type_offer * 100
#print(churn_rate_by_contract_internet_type_offer.sort_values(ascending=False).head(10))
#print(total_by_contract_internet_type_offer.sort_values(ascending=False).head(10))

segments = pd.concat([
  total_by_contract_internet_type_offer.rename("Total Customers"),
  churn_rate_by_contract_internet_type_offer.rename("Churn Rate (%)")
],
  axis=1)

segments = segments[segments["Total Customers"] >= 100]
segments = segments.sort_values(
    by="Churn Rate (%)",
    ascending=False
)

#print(segments.head(5))

top_segments = segments.head(5).reset_index()

top_segments["Offer"] = top_segments["Offer"].fillna("No Offer")
top_segments["Internet Type"] = top_segments["Internet Type"].fillna("No Internet")

top_segments["Segment"] = (
    top_segments["Contract"] + " | " +
    top_segments["Internet Type"] + " | " +
    top_segments["Offer"]
)

top_segments = top_segments.sort_values(
    by="Churn Rate (%)",
    ascending=True
)

ax = top_segments.plot(
    kind="barh",
    x="Segment",
    y="Churn Rate (%)",
    legend=False,
    figsize=(12, 6)
)

ax.set_title("Top 5 High-Risk Customer Segments")
ax.set_xlabel("Churn Rate (%)")
ax.set_ylabel("")

ax.bar_label(ax.containers[0], fmt="%.2f%%", padding=3)

ax.grid(axis="x", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

plt.tight_layout()
plt.show()
'''

#Churned Customers by Contract and Internet Type
'''
churned_customers = df[df["Customer Status"] == "Churned"]
churned_by_contract_internet = churned_customers.groupby(
    ["Contract", "Internet Type"],
    dropna=False
).size()

#print(churned_by_contract_internet)
#print("\nTotal churned customers:", churned_by_contract_internet.sum())

churned_by_contract_internet = churned_by_contract_internet.unstack()

churned_by_contract_internet.columns = (
    churned_by_contract_internet.columns.fillna("None")
)

ax = churned_by_contract_internet.plot(
    kind="bar",
    figsize=(10, 6)
)

ax.set_title("Churned Customers by Contract and Internet Type")
ax.set_xlabel("Contract")
ax.set_ylabel("Number of Churned Customers")
ax.legend(title="Internet Type")

for container in ax.containers:
    ax.bar_label(container, fmt="%d", padding=3)

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

plt.tight_layout()
plt.show()
'''

#Churn Rate by Tenure and Contract
'''
churned_by_tenure_contract = df.groupby(["Tenure in Groups", "Contract"])["Is_Churned"].sum()
total_by_tenure_contract = df.groupby(["Tenure in Groups", "Contract"]).size()
churn_rate_by_tenure_contract = (
    churned_by_tenure_contract / total_by_tenure_contract * 100
)

#print(churn_rate_by_tenure_contract)


churn_rate_by_tenure_contract = (
    churn_rate_by_tenure_contract
    .unstack()
    .reindex(["0-6", "7-12", "13-24", "25-36", "37-48", "49-60", "61+"])
)

ax = churn_rate_by_tenure_contract.plot(
    kind="bar",
    figsize=(12, 6)
)

ax.set_title("Churn Rate by Tenure and Contract")
ax.set_xlabel("Tenure (Months)")
ax.set_ylabel("Churn Rate (%)")
ax.legend(title="Contract")

for container in ax.containers:
    ax.bar_label(container, fmt="%.1f%%", padding=3)

ax.grid(axis="y", linestyle="--", alpha=0.4)
ax.set_axisbelow(True)

plt.tight_layout()
plt.show()
'''