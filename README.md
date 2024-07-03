# QuickClips

QuickClips is an iOS application built using Swift and SwiftUI that allows users to search and view video clips. The app integrates with the Pexels API to fetch video content and uses the ui-avatars API to generate user avatars.

## Features

- Get video clips using the Pexels API
- View video details and thumbnails
- User avatars generated using ui-avatars API

## Dependencies

QuickClips relies on the following external dependencies, managed via Swift Package Manager (SPM):

- **RealmSwift**: Used for local data storage.
- **Pexels API**: Fetches video content.
- **ui-avatars API**: Generates user avatars.

## Setup and Configuration

To ensure QuickClips functions correctly, you must configure the Pexels API key as an argument in the selected scheme with the key `PREXELS_API_KEY`. Follow these steps:

1. Open your Xcode project.
2. Select the target for QuickClips.
3. Go to the "Scheme" section and select "Edit Scheme."
4. In the "Arguments Passed On Launch" section, add `PREXELS_API_KEY` followed by your actual API key.

## Known Issues and Future Improvements

### Known Issues

- **Image and Video Caching**: Currently, the app only caches information related to the last 10 loaded clips when there is an internet connection. This can lead to performance issues when the app is used offline.

### Future Improvements

- **Enhanced Caching Mechanism**: Improve the caching of images and videos to ensure better performance when the app is offline.
- **Better Clip Cache Management**: Develop a more robust cache management system to store more clips and ensure smoother functionality when there is no internet connection.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Pexels for providing the video content API.
- ui-avatars for the avatar generation API.
- Realm for the local data storage solution.

## Contact

For any queries or issues, please contact [msantim@ehotmail.com].
