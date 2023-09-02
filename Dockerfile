FROM michalklempa/dart-sass AS sass

COPY style.scss /sass/style.scss
RUN /opt/dart-sass/sass /sass:/css

FROM pandoc/core:2-ubuntu
ENV FONTS="fonts-roboto"
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get -y --no-install-recommends install weasyprint $FONTS \
    && mkdir /internal

ENTRYPOINT echo "###################" && echo "#  CV Generator   #" && echo "###################" \
            && cp "$INPUT_MARKDOWN_FILE" /internal/input.md && cp -r "$INPUT_MEDIA_FOLDER" /internal/media \
            && echo "Install required fonts ($FONTS) ..." \
            && apt-get install -y --no-install-recommends $FONTS \
            && echo "Generate HTML from Markdown ($INPUT_MARKDOWN_FILE) ..." \
            && pandoc \
            --section-divs --css style.css --embed-resources --standalone --from "markdown+yaml_metadata_block+link_attributes+definition_lists" --to html5 \
            -s "/internal/input.md" -o "/internal/cv.html" \
            # for debugging
            #&& cp /internal/cv.html "/workspace/cv.html" && cp /internal/style.css "/workspace/style.css"\
            && echo "HTML generated" && echo "Generate PDF from HTML ..." \
            && weasyprint "/internal/cv.html" "/internal/out.pdf" \
            && cp /internal/out.pdf "$OUTPUT_PDF_FILE" \
            && echo "Generated PDF ($OUTPUT_PDF_FILE)"

COPY --from=sass /css/style.css /internal/style.css
