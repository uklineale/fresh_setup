import requests
from requests.auth import HTTPBasicAuth
import json
import sys
from datetime import datetime

JENKINS_URL = ""
TOKEN = ""
USERNAME = 'neelk'

PARAMETERS_CLASS = "hudson.model.ParametersAction"

# Options 
Job_Name = sys.argv[1]
Keyword = sys.argv[2]

def getJobUrl(job_name):
    url = JENKINS_URL + job_name + "/api/json"
    print("Searching " + url)
    return url

def getBuildUrl(job_name, build_num):
    url = JENKINS_URL + job_name + "/" + str(build_num) + "/api/json"
    return url

def getParametersFromJson(build):
    actions = build["actions"]
    parameters = []

    for i in actions:
        if "_class" in i.keys() and i["_class"] == PARAMETERS_CLASS:
            parameters = i["parameters"]
    
    if len(parameters) > 0:
        return [ p["value"] for p in parameters ]
    else:
        print(f"No parameters found in json: {build} \n")

def isMatch(keyword, params):
    for p in params:
        if keyword in str(p):
            return True
    return False

def searchParamsOfBuilds(job_name, keyword):
    target = getJobUrl(job_name)
    resp = requests.get(target, auth=HTTPBasicAuth(USERNAME, TOKEN))
    job = json.loads(resp.text)
    build_nums = [ b["number"] for b in job["builds"] ]
    print(build_nums)
    results = []

    for n in build_nums:
        target = getBuildUrl(job_name, n)
        resp = requests.get(target, auth=HTTPBasicAuth(USERNAME, TOKEN))
        build = json.loads(resp.text)
        params = getParametersFromJson(build)
        results.append((n, params))
        print(f"build {n} params: {params}")

    return [ r[0] for r in results if isMatch(keyword, r[1]) ]
        
start = datetime.now()   
matches = searchParamsOfBuilds(Job_Name, Keyword)
end = datetime.now()
length = end - start
print(matches)
print("Took % seconds" % (length.total_seconds()))
