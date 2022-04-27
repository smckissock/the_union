import { storyChart, mediaList, searchTerm, terms, cleanSearchTerm, storiesMap, storySelect, biasColors, storyGroup, startApp } from './search.js';
import { insert, formatDate } from './shared.js';
import { trackAppChange } from "./track.js";


export class CandidatesHtml {

    candidates = null;
    self = null;

    constructor(div) {
        self = this;
        
        this.div = div;
        this.bodyDiv = div.select(".candidates-content")
    }

    show(candidates) {
        if (candidates != null) {
            generateHtml(data); 
        } else {
            d3.json("data/candidates.json")
                .then(function (data) {
                    candidates = data;
                    self.generateHtml(candidates);
            });
        }

        self.div.style("display", "block");     
    }

    generateHtml(candidates) {        
        let html = "";
        candidates.forEach(function(c) {
            html += self.candidateHtml(c);

        });
        self.bodyDiv.html("<table>" + self.headerHtml() + "<body>" + html + "</body></table>");
    }

    // See this for sticky header css
    // https://css-tricks.com/position-sticky-and-table-headers/
    headerHtml() {
        return `
            <thead>
                <tr>
                    <th>State</th>
                    <th>Race</th>
                    <th>Candidate</th>
                    <th>Stories</th>
                </tr>
            </thead>
            `
    }

    candidateHtml(c) {
        let bold = c.incumbent == "False" ? ""  : 'class="bold"'; 
        
        let color = ""; 
        if (c.party == "D")
            color = ' class="blue" ';
        if (c.party == "R")
            color = ' class="red" ';

        //debugger;

        return `
            <tr onclick="self.select('${c.slug}')" ${bold}>
                <td>${c.state}</td>
                <td>${c.officeTitle}</td>
                <td ${color}>${c.name}</td>
                <td class="number">${c.storyCount}</td>
            </tr>
            `
    }   

    select(slug) {     
        trackAppChange(slug);
        startApp(slug);

        self.div.style("display", "none");    
    }
}
