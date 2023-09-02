# Markdown CV Generator

Inspired by the [CV generator from @Madic-](https://github.com/Madic-/Lebenslauf),
this is my own version of a pandoc-based CV (or in german "Lebenslauf") generator.

The data ist input as a kind-of formatted Markdown file and results into a PDF with the help of dockerized pandoc,
[WeasyPrint](https://github.com/Kozea/WeasyPrint) and scss styles.
For a preview, look at the [`sample.md`](sample/sample.md) and the rendered [cv.pdf](sample/cv.pdf)

## System requirements

The only requirement is a functional docker / docker-compose or alternative environment (the examples are made with podman).

## Usage

* Create yourself a folder by copying the sample folder to a new one (for example `my-cv`). Or create a new folder by yourself (the `media` folder is
  mandatory!).
* Adjust the commented lines in the `docker-compose.yaml`.
* Execute `podman-compose up --force-recreate -V` in the project folder to (re-)generate the PDF from your Markdown file.
  * This will compile the styles on the first run and creates the pdf afterward.

## Dev Usage

For an easy dev environment execute `podman-compose up --build --force-recreate -V` when you made changes to the Dockerfile or docker-compose.
Also enable the debug copy inside the Dockerfile to get the Live HTML preview.

## Trouleshotting

### `cp: cannot create regular file '/workspace/cv.pdf': Permission denied`

Make sure the pdf is not opened with a pdf reader.
