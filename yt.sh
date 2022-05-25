#!/bin/bash
yt-dlp -j --no-flat-playlist --skip-download "https://www.youtube.com/playlist?list=PLrEnWoR732-BHrPp_Pm8_VleD68f9s14-" \
 | jq '{
  description,
  title,
  duration,
  channel_id,
  author: .uploader,
  url: (.url // .webpage_url),
  thumbnail: (.thumbnails | map(select(.width < 600 and .width > 0)) | max_by(.width) | .url),
  content: {
    "View count": .view_count
  }
}' -c \
 | tee trends.json
 | json2rss -t 'Youtube Trending' > feed.rss
