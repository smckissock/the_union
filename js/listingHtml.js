import { storyChart, mediaList, searchTerm, terms, cleanSearchTerm, storiesMap, storySelect, biasColors, storyGroup } from './search.js';
import { insert, formatDate } from './shared.js';
import { trackStoryClick } from './track.js';


export class ListingHtml {

    selectedDiv = null;

    constructor(div) {
        this.div = div;
    }

    show(stories) {
        // Ugh - put this in scope for generated HTML below
        window.showStoryHtml = this.showStoryHtml;
        window.stories = stories; 

        // this.stories = stories;
        // this.stories = stories.sort(function(x, y){
        //     return d3.descending(new Date(x.date), new Date(y.date));
        // })    

        //console.table(this.stories);

        d3.selectAll("#listing-box > div").remove("*");

        let days = d3.nest()
            .key(function (d) { return d.date; })
            .entries(stories);

        days.sort(function(x, y){
            return d3.descending(new Date(x.key), new Date(y.key));
        })    

        days.forEach(function (d) {
            d.values.sort(function(x, y){
                return d3.descending(x.sort, y.sort);
            });
        });
        
        //debugger;

        const selectStory = this.selectStory;
        let selectedDiv = this.selectedDiv;
        this.div
            .selectAll("div")
            .data(days)
            .enter()
            .append('div')
            .classed("listing-date", true)
            //.html(d => formatDate(new Date(d.key.split("-")), true) + "<span class='listing-story-count'> " + d.values.length + "  stories</span>")
            .html(d => this.dateLabel(d))
                .selectAll("div.listing-item").data(d => d.values).enter() // values is list of stories for day
                .append("div")
                    .classed("listing-item", true)
                    .on("click", function(d) {
                        if (selectedDiv)
                            selectedDiv.classed('listing-item-selected', false);

                        d3.select(this).classed('listing-item-selected', true);
                        selectedDiv = d3.select(this);
                        
                        trackStoryClick(d.id);
                        storySelect(d); 
                    })
                    .html(d => this.storyHtml(d))
    }

    storyHtml(story) {
        return `
            <span class="bias-circle" style="color:${biasColors[story.bias]}">⬤ ${story.mediaOutlet} </span>    
            <span class="listing-title">${story.title}</span>
            <span class="listing-author">${this.authorLabel(story.author)}</span><br>
            <span class="listing-sentence">${story.sentence}</span>
        `
    }

    dateLabel(d) {
        const date = formatDate(new Date(d.key.split("-")), true);
        const stories = (d.values.length === 1)  ? "" : "<span class='listing-story-count'> &nbsp;&nbsp;" + d.values.length + " stories</span>";

        return date + stories;
    }

    authorLabel(author = "") {
        if (!author)
            return "";
        return "by " + author;    
    } 

    showStoryHtml(storyId) {
        const story = stories.find(d => d.id = storyId); 
        storySelect(story); 
    }
}

 