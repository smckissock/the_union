import { storyChart, mediaList, searchTerm, terms, cleanSearchTerm, storiesMap, storySelect, biasColors, storyGroup } from './search.js';
import { insert, formatDate } from './shared.js';


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

        self.div
            .style("display", "block");     
    }

    generateHtml(candidates) {
        debugger;
        let html = "";
        candidates.forEach(function(c) {
            html += self.candidateHtml(c);

        });
        self.bodyDiv.html("<table>" + html + "</table>");
    }

    candidateHtml(c) {
        return `
            <tr>
                <td>${c.state}</td>
                <td>${c.race}</td>
                <td>${c.name}</td>
            </tr>
            `
    }
}
