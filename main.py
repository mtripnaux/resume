from flask import Flask, send_file
import subprocess
from pathlib import Path
from datetime import *

app = Flask(__name__)

OUTPUT_DIR = Path("output")
YAML_FILE = Path("resume.yaml")
PDF_NAME = f"Matheo_Tripnaux_CV.pdf"
PDF_FILE = OUTPUT_DIR / PDF_NAME

def generate_cv():
    try:
        OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
        subprocess.run([
            "rendercv", 
            "render", 
            str(YAML_FILE),
            "-nomd",
            "-nohtml",
            "-nopng",
            "--pdf-path",
            PDF_FILE
        ], check=True)
        print("CV generated successfully")
    except subprocess.CalledProcessError as e:
        print(f"Error while rendering : {e}")

generate_cv()

@app.route("/")
def serve_cv():
    if PDF_FILE.exists():
        return send_file(
            PDF_FILE,
            as_attachment=False,
            download_name=f"{PDF_NAME.split(".")[0]}_{datetime.now()}.pdf",
            mimetype="application/pdf"
        )
    else:
        return "Cannot render CV from YAML file", 500

if __name__ == "__main__":
    app.run(debug=True)