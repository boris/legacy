from flask import Flask, render_template, url_for, request
import random

app = Flask(__name__)

@app.route('/')
def search():
    return render_template('index.html')

@app.route('/results', methods = ['GET', 'POST'])
def results():
    if request.method == 'GET':
        return redirect(url_for('/'))
    else:
        values = request.form.getlist('input_text[]')
        rojo = random.sample(values, int(len(values)/2))
        negro = [jugador for jugador in values if jugador not in rojo]
        return render_template('results.html',
                               team_0 = rojo,
                               team_1 = negro,
                               )

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

