# Nasa Image Search

[![Build](https://github.com/wjthieme/nasa-image/actions/workflows/swift.yml/badge.svg)](https://github.com/wjthieme/nasa-image/actions/workflows/swift.yml)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=wjthieme_nasa-image&metric=alert_status)](https://sonarcloud.io/dashboard?id=wjthieme_nasa-image)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=wjthieme_nasa-image&metric=coverage)](https://sonarcloud.io/dashboard?id=wjthieme_nasa-image)

# API

[Nasa Image Search](https://images.nasa.gov/docs/images.nasa.gov_api_docs.pdf)

### Assumptions
* An asset always has thumb image and large image and always follow the url pattern "https://images-assets.nasa.gov/image/{nasa_id}/{nasa_id}~{size}.jpg"
* Title, description, location & photographer are optional fields

# TODO

- [ ] Images are not cleared from memory so endless scrolling results in infinite memory expansion
- [ ] Snapshot testing should run on multiple devices and actually compare screenshots
- [ ] Sometimes runs into 403 error which seems to be a rate limit by the backend
- [ ] ViewModel Unit Tests
