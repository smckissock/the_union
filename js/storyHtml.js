import { storyChart, mediaList, searchTerm, terms, cleanSearchTerm, storiesMap } from './search.js';
import { insert } from './shared.js';


export class StoryHtml {

    constructor(div) {
        this.div = div;
    }

    show(story) {

        storyChart.moveStoryCursor(story);
        var mediaOutlet = mediaList.find(d => d.id == story.mediaId) // Always "newspaper"!?

        // See https://github.com/NickKaramoff/shareon/blob/master/src/index.ts for share button code

        let html = `
            <div class="story-result" ${story.date} onclick="window.open('${story.link}')">
                <p class="story-outlet">${this.outlet(story.mediaOutlet)}</p>
                <p><span class="story-date">${story.date}</span></p>
                <p class="story-headline">${this.headline(story.headline)}</p>
                <p class="story-author">${this.author(story.author, story.authorUrl)}</p>
                <img class="story-image" src='${this.image(story)}' onerror="this.style.display='none'" height="190" width="270">
                <p class="story-excerpt">${this.getSentences(story.sentences)}</p>
            </div>

            <div class="shareon">
                <a class="twitter" href="https://twitter.com/intent/tweet?url=${story.link}" rel="noopener noreferrer" target="_blank"></a>
                <a class="facebook" href="https://www.facebook.com/sharer/sharer.php?u=${story.link}" rel="noopener noreferrer" target="_blank"></a>
            </div>

            <div story-term-links>  
                <p>${this.getTermLinksHtml(story)}</p>
            </div>
        `;

        this.div.html(html);
    }

    date(date) {
        return formatDate(date);
    }

    outlet(mediaOutlet) {
        return mediaOutlet;
    }

    headline(headline) {
        if (headline != "")
            return headline;
        else
            return "";
    }

    image(d) {
        return d.image;
    }

    // Put in link
    author(author, authorUrl) {
        if (author)
            return "by " + author;
        return "";
    }


    // This needs to be rewritten....
    getSentences(sentences) {

        if (searchTerm.length < 3)
            return "";

        // In addition to highlighted the full search term, we also want to highlight person's last name    
        let lastName = "";    
        if (terms.filter(d => d.name === searchTerm)[0].type === "Person")
            lastName = searchTerm.split(" ").splice(-1)[0].toLowerCase();

        let matches = []
        sentences.forEach(function (sentence) {
            const lincolnProject = 'lincoln project';

            var lower = sentence.toLowerCase();
            if (matches.length < 10) {                
                if (lower.includes(cleanSearchTerm) || lower.includes(lincolnProject) || (lastName != "" && lower.includes(lastName))) {
                
                    let final = sentence;

                    // Highlight term
                    let start = lower.indexOf(cleanSearchTerm);

                    if (start != -1 && cleanSearchTerm != 'the lincoln project') {
                        final = insert(final, start + searchTerm.length, "</span>");
                        final = insert(final, start, "<span class='selected-term'>");

                        lower = final.toLowerCase();
                    } else {
                        // Is this is a person, try to highlight their last name if thier full name wasn't highlighted 
                        if (lastName != "") {
                            let lastStart = lower.indexOf(lastName);
                            if (lastStart != -1 && cleanSearchTerm != 'the lincoln project') {
                                final = insert(final, lastStart + lastName.length, "</span>");
                                final = insert(final, lastStart, "<span class='selected-term'>");

                                lower = final.toLowerCase();
                            }
                        }
                    }

                    // Highlight Lincoln Project
                    let start2 = lower.indexOf(lincolnProject);
                    if (start2 != -1) {
                        final = insert(final, start2 + lincolnProject.length, "</span>");
                        final = insert(final, start2, "<span class='selected-term'>");
                    }
                    matches.push(final);
                }
            }
        });
        return matches.join("<br>...<br>");
    }

    getTermString(story) {
        if (story.terms === undefined) {
            let list = ""
            story.termIds.forEach(function (id) {
                let t = terms.filter(term => { return term.id == id });
                if (t.length > 0)
                    list += t[0].name + " ";
            })
            story.terms = list;
        }
        return story.terms;
    }


    getTermLinksHtml(story) {

        function typeHtml(term) {
            return `<div class="related-term-type">${term.type} mentioned in this story:</div>`;
        }

        function resultHtml(term) {
            return `<div><a class="related-term-result" href="javascript:setExampleSearch('${term.name}')">${term.name}</a></div>`
        }

        let termList = [];
        story.termIds.forEach(function (id) {
            let matches = terms.filter(term => { return term.id == id });
            if (matches.length > 0)
                termList.push(matches[0]);
        });

        let html = "";
        let type = "";
        termList.forEach(function (term) {
            if (type != term.type) {
                html += typeHtml(term)
                type = term.type;
            }
            html += resultHtml(term);
        }); 
        return html;
    }

    // getStoryLinksHtml(storyDetails) {
    //     let html = "";
    //     let story = storiesMap.get(storyDetails.id);
    //     story.links.forEach(function (linkId) {
    //         let linkedTo = storiesMap.get(linkId);
    //         if (linkedTo)
    //             html += `<div class="related-term-type">${linkedTo.mediaOutlet} ${linkedTo.date}</div>`;
    //     });
    //     return html;
    // }
}