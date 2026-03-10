from flask import Flask, send_file
import subprocess
import shutil
from pathlib import Path
from datetime import *

app = Flask(__name__)

OUTPUT_DIR = Path("rendercv_output")
YAML_FILE = Path("resume.yaml")
PDF_NAME = f"Matheo_Tripnaux_CV.pdf"
PDF_FILE = OUTPUT_DIR / PDF_NAME
IMAGE_EXTENSIONS = {".png", ".jpg", ".jpeg", ".gif", ".webp", ".svg"}


def _link_images():
    """Copy images from rendercv_output/ to root temporarily so that
    rendercv can validate paths relative to the YAML file."""
    created = []
    for f in OUTPUT_DIR.iterdir():
        if f.suffix.lower() in IMAGE_EXTENSIONS:
            dest = Path(f.name)
            if not dest.exists():
                shutil.copy2(f, dest)
                created.append(dest)
    return created


def _unlink_images(links):
    for link in links:
        if link.exists() and not link.is_symlink():
            link.unlink()


def generate_cv():
    links = _link_images()
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
    finally:
        _unlink_images(links)

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