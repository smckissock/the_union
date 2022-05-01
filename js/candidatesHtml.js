import { storyChart, mediaList, searchTerm, terms, cleanSearchTerm, storiesMap, storySelect, biasColors, storyGroup, startApp, states } from './search.js';
import { insert, formatDate } from './shared.js';
import { trackAppChange } from "./track.js";


export class CandidatesHtml {
    
    self = null;
    //states = null;
    
    constructor(div) {
        self = this;
        
        this.div = div;
        this.bodyDiv = div.select(".candidates-content")
    }

    show() {
        self.generateHtml(states);
        self.div.style("display", "block");         
    }

    generateHtml(states) {        
        let html = "";
        states.forEach(state => {
            html += self.stateHtml(state);
        });
        self.bodyDiv.html("<table><body>" + html + "</body></table>");
    }

    stateHtml(state) {
        let html =
            `<tr>
                <th class="big-text" colspan="1">${state.name}</th>
                <th class="light-text">Primary ${state.races[0].primaryDate}</th>
                <th class="light-text">All Stories</th>
                <th class="light-text">Local Stories</th>
            </tr>`;
        return html + self.racesHtml(state.races);
    }

    racesHtml(races) {
        let html = "";
        races.forEach(race => {
            let raceCellHtml = `<td rowspan="${race.candidates.length}">${race.title}</td>`
            html += self.candidatesHtml(raceCellHtml, race.candidates);
        });
        return html;
    }

    candidatesHtml(raceCellHtml, candidates) {
        let html = "";
        candidates.forEach((candidate, i) => {
            let incumbentBall = candidate.incumbent == "False" ? "" : "⬤ ";

            let color = ""; 
            if (candidate.party == "D")
                color = ' class="blue" ';
            if (candidate.party == "R")
                color = ' class="red" ';
            
            html += 
            `<tr onclick="self.select('${candidate.slug}')">
                ${(i == 0) ? raceCellHtml : ""}
                <td ${color}>${incumbentBall} ${candidate.name}</td>
                <td class="number">${candidate.storyCount}</td> 
                <td class="number">${candidate.localStoryCount}</td>    
            </tr>`
        });
        return html;
    }

    select(slug) {  
        trackAppChange(slug);
        startApp(slug);

        self.div.style("display", "none");    
    }
}
