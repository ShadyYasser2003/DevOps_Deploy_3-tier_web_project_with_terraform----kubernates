from flask import Flask, request, jsonify
import redis

app = Flask(__name__)
redis_client = redis.Redis(host="redis-service", port=6379, decode_responses=True)

@app.route('/api/vote', methods=['POST'])
def vote():
    animal = request.json.get("animal")
    if animal not in ["dog", "cat"]:
        return jsonify({"error": "Invalid choice"}), 400
    redis_client.incr(animal)
    return jsonify({"message": f"Voted for {animal}!"})

@app.route('/api/results', methods=['GET'])
def results():
    dog_votes = redis_client.get("dog") or 0
    cat_votes = redis_client.get("cat") or 0
    return jsonify({"dog": int(dog_votes), "cat": int(cat_votes)})

@app.route('/api/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy"})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8088)