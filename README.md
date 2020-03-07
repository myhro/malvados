Malvados
========

This repository contains the tools needed to build a [Malvados][malvados] search engine.

## OCR

Image to text conversion is done through [optical character recognition (OCR)][ocr] using [Google Cloud Vision API][gcloud-vision]. This is a paid service and [its authentication has to be properly configured][gcloud-auth] by setting the `GOOGLE_APPLICATION_CREDENTIALS` environment variable before actually doing any conversion.

## Crawler and OCR wrapper

The `comic-strip.sh` wrapper has the `fetch` and `convert` commands which will download all comic strips to a folder and convert them from image to text, respectively.

    $ ./comic-strip.sh
    Usage:

    ./comic-strip.sh convert <FOLDER>
    ./comic-strip.sh fetch <FOLDER>

## Demo

A demo using the awesome [Algolia][algolia] Search-as-a-Service platform (which has a generous free plan) is available at https://bm.myhro.info/

[algolia]: https://www.algolia.com/
[gcloud-auth]: https://cloud.google.com/vision/docs/libraries#setting_up_authentication
[gcloud-vision]: https://cloud.google.com/vision/
[malvados]: http://www.malvados.com.br/
[ocr]: https://en.wikipedia.org/wiki/Optical_character_recognition
