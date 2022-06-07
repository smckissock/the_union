export let page = {}
export let selectedDatesHeight = 120;
export const barColor = "#bddfeb";
export let storyGroup;
export let eventGroup;
export let mediaList;
export let storySvg;

export let terms;
export let stories;
export let storiesMap;
export let states;
//export let startApp;

export const biasColors = {
    'Newspaper': 'darkGrey',  
    //'Digital Native': 'light-grey',  
    'Left' : '#335064', 
    'Center Left' : '#84a4ba',   
    'Center' : '#CDCDCD',    
    'Center Right' : '#e48175', 
    //'Right' : '#923024',  
    'Right' : '#ff1a1a',
    'International' : 'green'
};   

const days = 364
export const dayWidth = 12; 
export let storyChartSvgWidth = days * dayWidth; 

// Read these from css properties on layout.css (or responsive..)?
let storyWidth = 300;
export let mediaChartWidth = 130;
let storyChartWidth = 700;

export let storyChart = null;
export let searchTerm = "";
export let cleanSearchTerm = ""
export let selectedStory = null;

export let featuredStoryId;


import { svgDropDown } from "./svgDropDown.js";
import { insert, slugify, formatDate, centeredText, text } from './shared.js';

import { DateChart } from "./dateChart.js";
import { StoryChart } from "./storyChart.js";
import { StoryHtml } from "./storyHtml.js";
import { ListingHtml } from "./listingHtml.js";
import { CandidatesHtml } from "./candidatesHtml.js";
import { trackAppChange, trackInitialApp } from "./track.js";


let appName; 
let appSlug; 

let eventsHeight = 120;
let storyChartSvgHeight = 0; 

let aboutSvg;
let dateSvg;
let eventLabelSvg;
let eventSvg;
let mediaSvg;

let selectedCircle = null;
let selectedTerm = null;

let listingShown = false;

let monthToStoryWidth = null

// instances of chart classes defined in other files
let dateChart = null;
let eventChart = null;
let storyHtml = null;
let listingHtml = null;
let candidatesHtml = null;

let updateDate = new Date("2022/6/7"); 

let initialLoad = true;


(function loadPage() {
    // if query string is like: ?candidate=jd-vance  start app with that
    const params = new URLSearchParams(window.location.search)
    appSlug = params.get('candidate');

    getApps();  
}) ()


export function startApp(slug) {

    // Called from popup
    if (slug) {
        appSlug = slug;
    }

    console.log("Starting app for " + appSlug);
    d3.json("data/" + appSlug + "/dimensions.json").then(function (data) {
        renderApp(data); 
    });
    document.getElementById('search-input').focus();

    // Kludgy - put in window scope so this can be called from an HREF on generated HTML
    window.setExampleSearch = setExampleSearch;
    window.showStories = showStories; 

    var url = new URL(window.location);
    url.searchParams.set('candidate', appSlug);
    console.log(appSlug);
    window.history.pushState({}, '', url);
}


function getApps() {    

    console.log("getApps()");
            
    d3.json("data/states.json").then(data => {
        states = data;

        // Add field for each candidate's race
        states.forEach(state => {
            state.races.forEach(race => {
                race.candidates.forEach(candidate => {
                    candidate.race = race;
                });
            });
        }); 
        
        // Confirm that the app slug given (e.g. "liz-cheney") in the URL exists, otherwise use the first app in the list  
        let appFound = false;
        states.forEach(state => {
            state.races.forEach(race => {
                race.candidates.forEach(candidate => {
                    if (candidate.slug == appSlug) {
                        console.log("Query parameter " + appSlug + " found")
                        appFound = true;
                    }
                });
            });
        }); 
        if (!appFound)
            appSlug = states[0].races[0].candidates[0].slug; 
        
        d3.select("#selectedApp").property("value", appSlug);      
        
        trackInitialApp(appSlug);
        startApp();
        aboutButton();
        candidatesButton();
        switchButton();

        candidatesHtml = new CandidatesHtml(d3.select("#candidates-backdrop"));
    });
}


function renderApp(data) {
    appName = data.appName;
    featuredStoryId = data.featuredStoryId;

    terms = data.terms;
    terms.forEach(term => term.lower = term.name.toLowerCase());
    mediaList = data.media;

    d3.select("#search-input").on('keyup', function (event) {
        searchTerm = document.getElementById("search-input").value;
        setWord(searchTerm);
    });

    addSvgs();
    addDateScales(data);

    let race = getCandidate(appSlug).race;
    let importantDays = [ {name: "General", date: new Date("2022-11-08")} ];
    if (race.raceType.includes("Primary"))
        importantDays.push({name: "Primary", date: new Date(race.primaryDate)});        

    dateChart = new DateChart(dateSvg, page.monthScale, page.weekScale, page.dayScale, importantDays); 

    if (data.events.length != 0) {
        eventChart = new EventChart(eventLabelSvg, eventSvg, eventGroup, page.dateScale, data.events, storyGroup);
        eventChart.show();
    }

    storyChart = new StoryChart(mediaSvg, storyGroup, page.dateScale, eventChart);
    storyHtml = new StoryHtml(d3.select("#story-box"));
    listingHtml = new ListingHtml(d3.select("#listing-box"));
    
    getExampleTerms(terms);
    setWord(appName);
  
    var term = terms.find(d => d.name == appName);
    if (!term)
        console.log(appName + " term not found")
    else
        console.log(appName + " term found")
    showStories(term.id); 
    
    document.getElementById("search-input").focus();
    
    d3.select("#title-text").text("Lincoln Project / The Union Media Tracking") 
    d3.select("title").text("Media Tracking");
}

function addSvgs() {  
    d3.select("#date-chart-box").selectAll("*").remove();
    dateSvg = d3.select("#date-chart-box")
        .append("svg")
        .attr("width", mediaChartWidth + storyChartWidth)  
        .attr("height", selectedDatesHeight);
    
    d3.select("#event-labels-box").selectAll("*").remove();
    eventLabelSvg = d3.select("#event-labels-box")
        .append("svg")
        .attr("width", mediaChartWidth)
        .attr("height", eventsHeight) 
    
    d3.select("#event-chart-box").selectAll("*").remove();
    eventSvg = d3.select("#event-chart-box")
        .append("svg")
        .attr("width", storyChartWidth)
        .attr("height", eventsHeight) 
    eventGroup = eventSvg.append("g");

    d3.select("#story-chart-box").selectAll("*").remove();
    storySvg = d3.select("#story-chart-box")
        .append("svg")
        .attr("width", storyChartWidth)
        .attr("height", storyChartSvgHeight)
        //.attr("visibility", "hidden")
        
    storyGroup = storySvg.append("g");
    //storyGroup.attr("visibility", "hidden")

    d3.select("#media-chart-box").selectAll("*").remove();
    mediaSvg = d3.select("#media-chart-box")
        .append("svg")
        .attr("width", mediaChartWidth)
        .attr("height", storyChartSvgHeight) 
}

function addDateScales() {
        
    let firstMonth = 109; // Dec 2021
    let lastMonth = 121;  // Nov 2022
    
    page.storyMargins = ({top: 6, right: 0, bottom: 10, left: 40})

    page.monthScale = d3.scaleLinear()
        .domain([firstMonth, lastMonth])
        .range([0, mediaChartWidth + storyChartWidth - page.storyMargins.right]);

    page.weekScale = d3.scaleLinear()
        .domain([-1, 51])   // Don't understand why these are weird
        .range([0, mediaChartWidth + storyChartWidth - page.storyMargins.right]);

    page.dayScale = d3.scaleLinear()
        .domain([new Date("2021-12-01"), new Date("2022-12-01")])
        .range([0, mediaChartWidth + storyChartWidth - page.storyMargins.right]);

    // Ugh - used to scroll the story <g>    
    page.monthToStoryWidth = d3.scaleLinear()
        .domain([firstMonth, lastMonth])
        .range([0, storyChartSvgWidth + days * dayWidth + 3800]); // This needs to get smaller larger each day. Need to figure formula based on current date  
    // Ugh - used to scroll the story <g>  
    // NOT USED, BUT PROBABLY SHOULD BE INSTEAD OF ABOVE   
    page.dayToStoryWidth = d3.scaleLinear()
        .domain([new Date("2021-12-01"), new Date("2022-12-01")])
        .range([0, storyChartSvgWidth]); // Why 250?  Need to setup scales in one place...

    page.dateScale = d3.scaleTime()
        .domain([new Date("2021-12-01"), new Date()])
        .range([0, storyChartSvgWidth]); 
}

// Draw a vertical line with this?
function mousemove() {
    var x = d3.mouse(this)[0];
    var y = d3.mouse(this)[1];
}


function setFocus() {
    document.getElementById('search-input').focus();
}

// They clicked on an example. If this gives a single result - as it usually will - don't 
// show list of choices, just put the term in the search box and show the results for that term
// If there is more than one results, show the list  
export function setExampleSearch(term) {
    d3.select("#search-input")
        .attr("value", term);

    searchTerm = term;    
    cleanSearchTerm = term.toLowerCase();
    let matchedTerms = terms.filter(x => { return x.lower.indexOf(cleanSearchTerm) !== -1 });

    if (matchedTerms.length == 0) {
        alert("No entities found for " + cleanSearchTerm + "? WTF?");
    }

    // If there is only one result, "click" it 
    if (matchedTerms.length == 1) {
        // Put term in search box
        d3.select("#search-input")
            .attr("value", matchedTerms[0].name);

        showStories(matchedTerms[0].id);
    } else {
        setWord(term);
    }
}

// Changes the list of terms, they need to select term to refresh stories 
function setWord(word) {
    searchTerm = word;
    cleanSearchTerm = word.toLowerCase();
    
    let matchedTerms = [];
    if (word.length > 2) 
        matchedTerms = terms.filter(x => { return x.lower.indexOf(cleanSearchTerm) !== -1 });

    document.getElementById("results-box").innerHTML = searchTermsHtml(matchedTerms);
}

function setSelectedDates(extent) {
    function getDate(monthId) {
        let month = months.filter(d => d.monthId == Math.round(monthId + 0.5))[0];
        return month.month + " " + month.year; 
    }
    document
        .getElementById("selected-dates-box")
        .innerHTML = getDate(extent[0]) + "</br>" + getDate(extent[1]);
}


function displayStories(data) {
    
    data.forEach(function (story) {
        story.dateSort = story.date; 

        let parts = story.date.split("-");
        let year = Number(parts[0]);
        let month = Number(parts[1]);
               
        story.monthNum = (year === 2021) ? 0 : month;   
        story.weekNum = weekNum(story.date); 
        story.dateObject = new Date(story.date);

        let media = mediaList.find(x => x.id == story.mediaId);
        if (!media) {
            console.log("No media for " + story.mediaId)
            debugger;
        }

        story.mediaOutlet = media.name; 
        story.bias = media.bias;
        story.color = biasColors[media.bias];

        switch(story.bias) {
            case "Newspaper":       story.sort = 100000; break; 
            case "Right":           story.sort = 70000; break;
            case "Center Right":    story.sort = 60000; break;
            case "Center":          story.sort = 50000; break;
            case "Center Left":     story.sort = 40000; break;
            case "Left":            story.sort = 30000; break;
            case "International":   story.sort = 20000; break;
        }
    }); 

    storiesMap = new Map();
    data.forEach(x => storiesMap.set(x.id, x)); 

    stories = data; // !!

    dateChart.show(data);       
    showFilters();
    document.getElementById("results-box").innerHTML = searchTermsHtml([]);

    toggleListing(initialLoad);
}

function weekNum(date) {
    var theDate = new Date(date);
    var start = new Date("2021-12-01");
    var diff = theDate - start;
    var oneDay = 1000 * 60 * 60 * 24;
    var day = Math.floor(diff / oneDay);

    return Math.floor(day / 7) - 1;  // -1??!!
}


// When they click on a search term 
function showStories(id) {
    const term = terms.filter(term => { return term.id == id })[0];
    
    searchTerm = term.name;
    cleanSearchTerm = searchTerm.toLowerCase();
    var dom = d3.select("#search-input")
    dom.innerHTML = term.name;
    d3.select("#search-input")
        .attr("value", term.name);  

    const slug = slugify(term.name);
    selectedTerm = terms.filter(term => { return term.id == id })[0];
    d3.json("data/" + appSlug + "/terms/" + slug + ".json").then(function (data) {
        displayStories(data);
    });
}


function storyClick(circle, story) {

    alert("STORY CLICK!");

    // If a story is already selected, color it blue 
    if ((selectedCircle != circle) && (selectedCircle)) 
        selectedCircle.setAttribute("fill", selectedStory.color)
        
    selectedCircle = circle;
    selectedStory = story;

    storyDetailsHtml(selectedStory);
}

export function storySelect(story) {
    storyDetailsHtml(story);
}

function storyDeselect(story) {
    if (selectedStory)
        storyDetailsHtml(story);
    else
        d3.select("#story-box").html("<p class='no-story'>No story selected (select circle)</p>");
}

function showFilters() {
    
    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    d3.select("#count-box").text("  " + numberWithCommas(stories.length) + " stories, updated through " + formatDate(updateDate, true));

    let filterStrings = [];
    if (selectedTerm)
        filterStrings.push(selectedTerm.name);
   
    let filterString = "";
    if (selectedTerm)
        filterString = selectedTerm.name;

    let filterDiv = document.getElementById("filter-box");
    if (filterString) {
        const title = ((filterString === appName) ? appName + " - all coverage" : appName + " & " + filterString);
        d3.select("#filter-box").text(title); 
    }

    // Clear selected story whenever filters change (I guess?)
    clearStory();

    storyChart.show(stories);
    if (listingShown)
        listingHtml.show(stories);
}

function clearStory() { 
    selectedStory = null;
    selectedCircle = null;
    storyDeselect();
}

// Show search terms with chars they typed 
function searchTermsHtml(matchedTerms) {

    function typeHtml(term) {
        return `<div class="term-type">${term.type}</div>`;
    }

    function resultHtml(term) {
        let firstChar = term.lower.indexOf(cleanSearchTerm);
        let bolded = insert(term.name, firstChar + cleanSearchTerm.length, "</span>");
        bolded = insert(bolded, firstChar, "<span class='selected-term'>");

        return `<div class="term-result" onclick="showStories(${term.id})">${bolded}</div>`;
    }

    let html = "";
    let type = "";
    matchedTerms.forEach(function (term) {
        if (type != term.type) {
            html += typeHtml(term)
            type = term.type;
        }
        html += resultHtml(term);
    });

    toggleChartVisible(html != "");
    return html;
}


export function storyDetailsHtml(story) {
    d3.json("data/" + appSlug + "/story/" + story.id + ".json").then(function (data) {
        storyHtml.show(data);
    });
}


function switchButton() {

    var switchSvg = d3.select("#switch-box")
        .append("svg")
        .attr("width", 270)
        .attr("height", 60)

    const left = 186; 
    const width = 80;     
    const switchRect = switchSvg.append("rect")
        .attr("x", left)
        .attr("y", 6)
        .attr("width", width)
        .attr("height", 50)
        .attr("fill", "white")
        .attr("stroke", "black")
        .attr("stroke-width", 2)
        .attr("opacity", "1.0")
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(50)
                .attr("stroke-width", 5)
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(80)
                .attr("stroke-width", 2);
        })
        .on('click', function (d) {
            toggleListing();
        });

    text("Switch to", switchSvg, "button-text", left + 10, 26);
    text("", switchSvg, "button-text", left + 13, 45, "timeline-label");
    text("Listing", switchSvg, "button-text", left + 18, 45, "listing-label");
}


function toggleListing(toggle = true) {
    if (toggle)
        listingShown = !listingShown;
    
    const svg = d3.select("#grid-container");

    if (listingShown) {
        d3.select("rect.selection").attr("visibility", "hidden"); // Hide date brush

        svg.classed("container", false)
        svg.classed("listing-container", true)
        d3.select("#media-chart-box")
            .style("display", "none");
        d3.select("#story-chart-box")
            .style("display", "none")

        listingHtml.show(stories);   
    } else {
        d3.select("rect.selection").attr("visibility", "visible"); // Hide date brush

        // Remove all divs on story listing dic because they "push out" chart. Be nice to leave them there  
        d3.selectAll("#listing-box > div").remove("*");

        svg.classed("listing-container", false)
        svg.classed("container", true)
        d3.select("#media-chart-box")
            .style("display", "block")
        d3.select("#story-chart-box")
            .style("display", "block")
    }

    if (listingShown) {
        svg.select("#timeline-label").text("Timeline");
        svg.select("#listing-label").text("");
    } else {
        svg.select("#timeline-label").text("");
        svg.select("#listing-label").text("Listing");
    }
    
    initialLoad = false;
    return;
}

function toggleChartVisible(hide) {
    let display = "block";
    if (hide)
        display = "none";
    d3.select("#story-box").style("display", display);
}

function candidatesButton() {

    //var candidatesButtonSvg = d3.select("#candidatesButton")
    var candidatesButtonSvg = d3.select("#appDropdown")
        .append("svg")
        .attr("width", 150)
        .attr("height", 50)

    const left = 186; 
    const width = 80;     
    const candidatesButtonRect = candidatesButtonSvg.append("rect")
        .attr("x", 4)  // left
        .attr("y", 4)
        .attr("width", 130) // width
        .attr("height", 30)
        .attr("fill", "white")
        .attr("stroke", "black")
        .attr("stroke-width", 2)
        .attr("opacity", "1.0")
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(50)
                .attr("stroke-width", 5)
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(80)
                .attr("stroke-width", 2);
        })  
        .on('click', function (d) {
            showCandidatesModal();
        });

    text("Select Candidate", candidatesButtonSvg, "button-text", 14, 24);
    //text("", candidatesButtonSvg, "button-text", left + 13, 45, "timeline-label");
    //text("Candidate", candidatesButtonSvg, "button-text", left + 18, 45, "listing-label");
}

function showCandidatesModal() {
    candidatesHtml.show();    
}


function aboutButton() {
    aboutSvg = d3.select("#aboutButton")
        .append("svg")
        .attr("width",50)
        .attr("height", 50)

    aboutSvg.append("circle")
        .attr("cx", 26)
        .attr("cy", 19)
        .attr("r", 12)
        .attr("fill", "white")
        .attr("stroke", "white")
        .attr("stroke-width", 0)
        .on('mouseover', function (d) {
            d3.select(this)
                .transition()
                .duration(50)
                .attr("stroke-width", 6)
        })
        .on('mouseout', function (d) {
            d3.select(this)
                .transition()
                .duration(80)
                .attr("stroke-width", 0);
        })
        .on('click', function (d) {
            window.open('about.html', '_blank');
        });

    aboutSvg.append("text")
        .attr("x", 21)
        .attr("y", 25)
        .text("?")
        .attr("font-size", ".8em")
        .attr("font-weight", "800")
        .attr("fill", "black")
        .attr("pointer-events", "none");
}

  
function refreshExamples(allTerms) {
    d3.select("#search-input")
        .attr("value", "");
    cleanSearchTerm = "";
    searchTerm = "";
    toggleChartVisible(true)
    clearStory();

    setExampleSearch(getExampleTerms());
}

// Gets a new list of random  examples and renders them. Returns the first item, which will always have a single associated term. 
function getExampleTerms() {

    let sampleCount = 11;
    if (terms.length < sampleCount)
        sampleCount = terms.length;
        
    let picked = new Set();
    //picked.add(appName);  // NO - appName should not be a term.  All stories should apply to app name
    while (picked.size < sampleCount)
        picked.add(terms[Math.floor(Math.random() * terms.length)].name);
    let examples = Array.from(picked);
    
    let html = `
        <span onclick="refreshExamples()">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="-2 -3 18 18">
            <path d="M9 13.5c-2.49 0-4.5-2.01-4.5-4.5S6.51 4.5 9 4.5c1.24 0 2.36.52 3.17 1.33L10 8h5V3l-1.76 1.76C12.15 3.68 10.66 3 9 3 5.69 3 3.01 5.69 3.01 9S5.69 15 9 15c2.97 0 5.43-2.16 5.9-5h-1.52c-.46 2-2.24 3.5-4.38 3.5z"/>
        </svg>
        </span> 
        <span class="example-label">Click a term: </span>
    `;

    // First term (app name) is bold
    html += `<span><a class="search-example-bold" href="javascript:setExampleSearch('${appName}')">${appName}</a></span> `;
    for (let i = 1; i < sampleCount; i++) // Skip the first, because it was added above 
        html += `<span><a class="search-example" href="javascript:setExampleSearch('${examples[i]}')">${examples[i]}</a></span> `;
    document.getElementById("examples-div").innerHTML = html

    return examples[0];
}


function clearAll() {
    document.getElementById("search-input").value = "";
}

function getCandidate(slug) {
    let match = null;
    states.forEach(state => {
        state.races.forEach(race => {
            race.candidates.forEach(candidate => {
                if (candidate.slug == slug) {
                    match = candidate;
                }
            });
        });
    });
    return match; 
}