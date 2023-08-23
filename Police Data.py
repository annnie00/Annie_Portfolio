#!/usr/bin/env python
# coding: utf-8

# # Importing Data

# In[1]:


import pandas as pd


# In[3]:


file_path = "/Users/annievernaza/Downloads/3. Police Data.csv"
df = pd.read_csv(file_path)


# In[4]:


df


# # Finding null values
# - Dropped column that had all null values

# In[6]:


df.isnull()


# In[7]:


df.isnull().sum()


# In[9]:


df.drop(columns = 'country_name', inplace = True)


# In[10]:


df.head()


# # Basic analysis of police data
# - Violation counts and conducted searches by gender
# - Stop durations (range) total count and mean
# - Describing violations using statistical data on age

# In[11]:


df[df.violation == 'Speeding'].driver_gender.value_counts()


# In[12]:


df.groupby('driver_gender').search_conducted.sum()


# In[13]:


df.search_conducted.value_counts()


# In[14]:


df.stop_duration.value_counts()


# In[19]:


df['stop_duration'].mean()


# In[21]:


df.groupby('violation').driver_age.describe()

