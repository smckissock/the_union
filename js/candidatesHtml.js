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

        let totalStories = { "storyCount" : 0, "localStoryCount" : 0 }
        states.forEach(state => {
            state.races.forEach(race => {
                race.candidates.forEach(candidate => {
                    totalStories.storyCount += +candidate.storyCount;
                    totalStories.localStoryCount += +candidate.localStoryCount
                });
            });
        });
        console.log("All Stories " + totalStories.storyCount);
        console.log("Local Stories " + totalStories.localStoryCount);
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
                <th class="big-text" colspan="3">${state.name}</th>
                <th class="light-text">National Stories</th>
                <th class="light-text">Local Stories</th>
            </tr>`;
        return html + self.racesHtml(state.races);
    }

    racesHtml(races) {

        function candidatesHtml(raceCellHtml, candidates) {
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

        let html = "";
        races.forEach(race => {
            let ranking = race.ranking == 0 ? "" : "#" + race.ranking; 
            
            let raceCellHtml =
                `<td class="big-text" rowspan="${race.candidates.length}">${ranking}</td>
                <td class="big-text" rowspan="${race.candidates.length}">${race.title}<span class="light-text"> &nbsp;&nbsp;${race.raceType}</span></td>`
            html += candidatesHtml(raceCellHtml, race.candidates);
        });
        return html;
    }

    // candidatesHtml(raceCellHtml, candidates) {
    //     let html = "";
    //     candidates.forEach((candidate, i) => {
    //         let incumbentBall = candidate.incumbent == "False" ? "" : "⬤ ";

    //         let color = ""; 
    //         if (candidate.party == "D")
    //             color = ' class="blue" ';
    //         if (candidate.party == "R")
    //             color = ' class="red" ';
            
    //         html += 
    //         `<tr onclick="self.select('${candidate.slug}')">
    //             ${(i == 0) ? raceCellHtml : ""}
    //             <td ${color}>${incumbentBall} ${candidate.name}</td>
    //             <td class="number">${candidate.storyCount}</td>
    //             <td class="number">${candidate.localStoryCount}</td>
    //         </tr>`
    //     });
    //     return html;
    // }

    select(slug) {  
        trackAppChange(slug);
        startApp(slug);

        self.div.style("display", "none");    
    }
}
