

// Currently selected app that get sent with story clicks 
let app = 'the-lincoln-project';


// App is starting up. If the URL has a slug it would be here, otherwise first in dropdown (Lincoln Project) 
export function trackInitialApp(slug) {
    app = slug;

    gtag('event', 'app_start', {
        'event_label': slug
    });
}

// They changed app wioth dropdown
export function trackAppChange(slug) {
    app = slug;

    gtag('event', 'app_change', {
        'event_label': slug
    });
}

// They clicked a story
export function trackStoryClick(storyId) {
    
    gtag('event', 'story_click', {
        'event_label': app,
        'event_category' : storyId
    });
}