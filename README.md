# Nasa Image Search

[![Build](https://github.com/wjthieme/nasa-image/actions/workflows/swift.yml/badge.svg)](https://github.com/wjthieme/nasa-image/actions/workflows/swift.yml)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=wjthieme_nasa-image&metric=alert_status)](https://sonarcloud.io/dashboard?id=wjthieme_nasa-image)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=wjthieme_nasa-image&metric=coverage)](https://sonarcloud.io/dashboard?id=wjthieme_nasa-image)

With the Nasa Image Search app you can browse and search Nasa images. This app uses the freely available [Nasa Images API](https://images.nasa.gov/docs/images.nasa.gov_api_docs.pdf). The app is set up using the MVVM architecture pattern to achieve high code coverage. The app uses Unit Tests to test most of the application logic and Snapshot Tests to test the UI layer. The UI elements are written in code using UIKit.

The app supports the following platforms:
* iOS 13+
* iPadOS 13+
* MacOS 10.15+ (through MacOS Catalyst)

An automatic build/test pipeline runs through Github Actions. The pipeline consists of the following steps:
1. Build the app and run all the tests
2. Analyze the code using SonarCloud

### Assumptions
* An asset in the Nasa Images repository always has a thumbnail image and a large image. The urls to these resources always follow the following pattern "https://images-assets.nasa.gov/image/{nasa_id}/{nasa_id}~{size}.jpg".
* An asset in the Nasa Images repository has one required field, the nasa_id - title, description, location & photographer are optional fields.

### How to run

The app can be built from source using Xcode, just checkout the repository and open the xcodeproj file. There are no external dependencies that are required to run the app. Just remember to change the profile/BundleID if you want to run the app on a physical device.

### Known issues

- [ ] Endless scrolling results in infinite memory expansion as images are kept in memory and only cleared once the search query is changed.
- [ ] Snapshot testing should run on multiple devices and actually compare screenshots between different runs.
- [ ] The app sometimes runs into a 403 error which seems to be caused by rate limiting done by the backend.
