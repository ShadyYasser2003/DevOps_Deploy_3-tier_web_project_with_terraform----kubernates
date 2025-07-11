from flask import Flask, render_template, request, redirect, url_for
import requests
import os

app = Flask(__name__)

# استخدام ALB URL أو localhost للتطوير
ALB_HOST = os.getenv('ALB_HOST', 'voting-app-alb-1733340554.us-east-1.elb.amazonaws.com')
BACKEND_URL = f"http://{ALB_HOST}/api"

@app.route('/')
def index():
    try:
        response = requests.get(f"{BACKEND_URL}/results")
        if response.status_code == 200:
            results = response.json()
        else:
            results = {"dog": 0, "cat": 0}
    except requests.exceptions.RequestException:
        results = {"dog": 0, "cat": 0}
    
    return render_template("index.html", results=results)

@app.route('/vote', methods=['POST'])
def vote():
    animal = request.form.get('animal')
    if animal:
        try:
            requests.post(f"{BACKEND_URL}/vote", 
                         json={"animal": animal},
                         headers={'Content-Type': 'application/json'})
        except requests.exceptions.RequestException:
            pass  # Handle error silently for now
    
    return redirect(url_for('index'))

@app.route('/health', methods=['GET'])
def health():
    return {"status": "healthy"}

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8080)