import { storyChart, mediaList, searchTerm, terms, cleanSearchTerm, storiesMap, storySelect, biasColors, storyGroup, startApp } from './search.js';
import { insert, formatDate } from './shared.js';
import { trackAppChange } from "./track.js";


export class CandidatesHtml {

    candidates = null;
    states = null;
    self = null;

    constructor(div) {
        self = this;
        
        this.div = div;
        this.bodyDiv = div.select(".candidates-content")
    }

    show(candidates) {
        if (candidates != null) {
            debugger;
            this.generateHtml2(data); 
        } else {
            d3.json("data/states.json")
                .then(function (data) {
                    self.states = data;
                    self.generateHtml(self.states);
            });
        }
        self.div.style("display", "block");     
    }

    generateHtml(states) {        
        let html = "";
        self.states.forEach(function(s) {
            html += self.stateHtml(s);
        });
        self.bodyDiv.html("<table><body>" + html + "</body></table>");
    }

    stateHtml(state) {
        let html =
            `<tr>
                <th colspan="4">${state.name}</th>
            </tr>`;
        return html + self.racesHtml(state.races);
    }

    racesHtml(races) {
        let html = "";
        races.forEach(function(race) {
            let raceCellHtml = `<td rowspan="${race.candidates.length}">${race.title}</td>`
            html += self.candidatesHtml(raceCellHtml, race.candidates);
        });
        return html;
    }

    candidatesHtml(raceCellHtml, candidates) {
        let html = "";
        candidates.forEach(function(candidate, i) {
            let bold = candidate.incumbent == "False" ? ""  : 'class="bold"'; 
        
            let color = ""; 
            if (candidate.party == "D")
                color = ' class="blue" ';
            if (candidate.party == "R")
                color = ' class="red" ';
            
            html += 
            `<tr onclick="self.select('${candidate.slug}')" ${bold}>
                ${(i == 0) ? raceCellHtml : ""}
                <td ${color}>${candidate.name}</td>
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
