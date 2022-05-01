import { 
    mediaList, storySvg, 
    storyDetailsHtml, biasColors, 
    storyChartSvgWidth, mediaChartWidth, barColor, stories, dayWidth, selectedStory, storySelect, featureId } from "./search.js";
import { className } from "./shared.js";    



export class StoryChart {
    
    constructor(mediaSvg, storySvg, xScale, eventChart) {
        this.mediaSvg = mediaSvg;
        this.storySvg = storySvg;
        this.xScale = xScale; // dateScale
        this.eventChart = eventChart;

        this.mediaY = {};
        this.rowHeight = 24;

        this.circleTransitionSpeed = 250;

        this.mediasWithStoryCount = null;
        this.dayLabel = null;
        this.storyBands = null;
        this.currentDateLine = null;

        this.storyCursor = null;

        this.biases = [];
    }

    show(stories) {
        this.makeMediaList(stories);

        let svgHeight = ((this.mediasWithStoryCount.length + 7) * this.rowHeight) + 40; // The 7 is for the extra rows for media types. Should be calced
        storySvg.attr("height", svgHeight);
        
        let featureStory = stories.find(d => d.id == featureId);  // Featured Story
        if (!featureStory)
            storyDetailsHtml(stories[0]);
        else
            storyDetailsHtml(featureStory);

        this.mediaSvg.selectAll("*").remove();
        this.storySvg.selectAll("*").remove();

        this.mediaSvg.attr("height", svgHeight);
        this.storySvg.attr("height", svgHeight); 

        this.drawMediaLabels();
        this.drawStories();
        this.makeStoryCursor();
        this.drawHorizontalLines();
        this.drawDateAxis();

        this.drawDaysOfMonth();
        this.drawMonths();

        // This app may or may not show events
        if (this.eventChart != null) {
            this.eventChart.showEventsOnStoryChart();
            this.eventChart.drawMonths();
        }
    }

    makeStoryCursor() {
        this.storyCursor = 
            this.storySvg.append("ellipse")
                .attr("cx", 4000)
                .attr("cy", 100)
                .attr("rx", 28)
                .attr("ry", 40)
                .attr("fill", "white")
                .style("stroke-width", 22)
                .style("stroke", "black")
                .style("stroke-opacity", 1.0) // Doesn't do anything??
                .attr("opacity", 0.6)
                .attr("pointer-events", "none")
    }

    makeMediaList(stories) {
        let medias = d3.nest()
            .key(function (d) { return d.mediaOutlet; })
            .entries(stories);

        medias.forEach(function (d) {
            d.type = mediaList.find(x => x.name == d.key).bias;

            switch (d.type) {
                case "Newspaper": d.sort = "90000"; break;
                case "Right": d.sort = "70000"; break;
                case "Center Right": d.sort = "60000"; break;
                case "Center": d.sort = "50000"; break;
                case "Center Left": d.sort = "40000"; break;
                case "Left": d.sort = "30000"; break;
                case "International": d.sort = "20000"; break;
                default: d.sort = "0"; break;  // Should be carefull this doesn't happen, but an undefined here will completly break the sort 
            }
        });

        this.mediasWithStoryCount = medias.map(function (media) {
            return {
                name: media.key,
                sort: media.sort,
                bias: media.type,
                storyCount: media.values.length
            }
        });
        this.mediasWithStoryCount = this.mediasWithStoryCount.sort((a, b) => b.sort - a.sort);
    }

    drawMediaLabels() {
        let self = this;

        let y = 26;
        this.biases = [];
        let biases = this.biases;
        this.mediasWithStoryCount.forEach(media => {
            if ((biases.length == 0) || (media.bias != biases[biases.length - 1].bias)) {   
                biases.push({ "bias": media.bias, "y": y });
                y += this.rowHeight;
            }
            this.mediaY[media.name] = y;
            media.color = biasColors[media.bias];
            y += this.rowHeight;
        });

        // rects for rows over stories on mouseover
        self.storyBands = this.storySvg.selectAll("rect")
            .data(this.mediasWithStoryCount)
            .enter()
            .append("rect")
            .attr("x", 3)
            .attr("y", d => this.mediaY[d.name] + 2) 
            .attr("width", storyChartSvgWidth)
            .attr("height", this.rowHeight + 4)  
            .attr("fill", "white")
            .attr("id", d => "l" + className(d.name))
            .on("mouseover", d => self.highlightMediaRow(true, d.name, d.color))
            .on("mouseout", d => self.highlightMediaRow(false, d.name, d.color))

        // This puts the vertical line for the mouse (date) on top of the media outlet row divs    
        this.drawDateLine();
        this.dayLabel = this.storySvg.append("text")
            .classed("current-day-label", true)
            .attr("y", 24);

        // Move the vertical line for the mouse, and change the date label    
        self.storyBands
            .on("mousemove", function (d) {
                const mouseX = d3.mouse(this)[0];
                self.updateCurrentDate(self, mouseX);
            })

        let storyCountScale = d3.scaleLinear()
            .domain([0, d3.max(this.mediasWithStoryCount, d => d.storyCount)])
            .range([0, mediaChartWidth]);

        // Rects for rows over media outlets on mouseover
        this.mediaSvg.selectAll("rect").data(this.mediasWithStoryCount).enter().append("rect")
            .attr("x", 0)
            .attr("y", d => this.mediaY[d.name] + 2)
            .attr("width", storyCountScale.range()[1] + 1)
            .attr("height", this.rowHeight + 19)
            .attr("fill", "white")
            .attr("id", d => "r" + className(d.name))
            .on("mouseover", d => self.highlightMediaRow(true, d.name, d.color))
            .on("mouseout", d => self.highlightMediaRow(false, d.name, d.color))

        this.mediaSvg.selectAll("text").data(this.mediasWithStoryCount).enter().append("text")
            .text(d => d.name) // + " "  + d.storyCount)
            .attr("x", 2)
            .attr("y", d => this.mediaY[d.name] + 21)
            .attr("id", d => "t" + className(d.Name))
            .classed("mediaLabel", true);

        this.storySvg.selectAll("rect.bias-story-rect").data(this.biases).enter().append("rect")
            .attr("x", 0)
            .attr("y", d => d.y + 2) 
            .attr("width", storyChartSvgWidth)
            .attr("height", 23)  
            .attr("fill", d => biasColors[d.bias])
            .classed("bias-story-rect", true);

        this.mediaSvg.selectAll("rect.bias-rect").data(this.biases).enter().append("rect")
            .attr("x", 0)
            .attr("y", d => d.y + 2)
            .attr("width", storyCountScale.range()[1] + 1)
            .attr("height", 23)
            .attr("fill", d => biasColors[d.bias])
            .classed("bias-rect", true);
           
        this.mediaSvg.selectAll("text.biasLabel").data(this.biases).enter().append("text")
            .text(d => d.bias) 
            .attr("x", 4)
            .attr("y", d => d.y + 19)
            .classed("biasLabel", true);
    }

    updateCurrentDate(self, mouseX) {
        return;

        const textWidth = 100;
        const date = self.xScale.invert(mouseX);
        self.dayLabel
            .text(self.niceDate(date))
            .attr("x", mouseX - textWidth);

        // It would be nice to have the text begin on the left edge of the line if they are on the left, and same for right... 
        const pixelsFromRight = self.xScale.range()[1] - mouseX - 480; // 480?!
        //console.log("Pixels From right " + pixelsFromRight);
        if (pixelsFromRight < textWidth)
            mouseX = mouseX - pixelsFromRight;

        self.currentDateLine
            .attr("x1", mouseX)
            .attr("x2", mouseX);
    }

    drawStories() {
        let self = this;

        let mediaTypeColor = "";
        var svg = this.storySvg;
        this.storySvg.selectAll(".story-rect")
            .data(stories)
            .enter()
            .append("rect")
            .classed("story-rect", true)
            .attr("fill", d => d.color)
            .attr("stroke", d => d.color)
            .attr("x", d => self.xScale(d.dateObject) + dayWidth + 9)
            .attr("y", d => this.mediaY[d.mediaOutlet] + 2)
            .attr("width", dayWidth + 3)
            .attr("height", self.rowHeight - 2)
            .each(function(d, i) {
                //console.log(d.color);
            })
            .on('mouseover', function (d) {
                
                self.highlightMediaRow(true, d.mediaOutlet);
                //const mouseX = d3.mouse(this)[0];
                //self.updateCurrentDate(self, mouseX);

                if (selectedStory === d)
                    return;
                      
                svg.append("text")
                    .attr("x", self.xScale(d.dateObject) - 8)
                    .attr("y", self.mediaY[d.mediaOutlet] - 6)  
                    .text("Click to select")
                    .attr("pointer-events", "none")
                    .classed("tooltip", true)
                    .classed("hint", true);
            })
            .on('mouseout', function (d) {
                if (d === selectedStory)
                    return;

                let fillColor = d.color;
                if (d == selectedStory)
                    fillColor = "black";

                d3.select(this)
                    .transition()
                    .duration(self.circleTransitionSpeed)
                    .style("stroke-width", 0)

                self.highlightMediaRow(false, d.mediaOutlet);
                d3.selectAll(".tooltip").remove();
            })
            .on('click', function (d) {
                if (d === selectedStory)
                    return;

                d3.selectAll(".tooltip").remove();

                storySelect(d);                
            })
    }

    moveStoryCursor(d) {
        // 7/14/2020 This should also:
        // Move the brush so story is visible
        // Scroll story area vertically to make story visible


        // Don't know why this is not always set
        d.dateObject = new Date(d.date);

        this.storyCursor
            .transition()
            .duration(500)
            .attr("cx", this.xScale(d.dateObject) + 28)
            .attr("cy", this.mediaY[d.mediaOutlet] + 13)
    }
   
    drawDateLine() {
        this.currentDateLine = this.storySvg.append("line")
            .classed("current-date-line", true)
            .attr("x1", 20)
            .attr("y1", 20)
            .attr("x2", 20)
            .attr("y2", 1200);
    }

    drawHorizontalLines() {
        let self = this;
        return;

        this.storySvg.selectAll("line")
            .data(stories)
            .enter()
            .append("line")
            .attr("class", "mediaLine")
            .attr("x1", 0)
            .attr("y1", function (d, i) { return 20 + (i * self.rowHeight) })
            .attr("x2", storyChartWidth)
            .attr("y2", function (d, i) { return 20 + (i * self.rowHeight) });
    }

    drawMonths() {
        const months = ["Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "July", "Aug", "Sep", "Oct", "Nov"];
        const monthNames = ["December", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November"];
        const firstDay = new Date("2021-12-01");

        let monthIndex = -1;
        for (let i = 0; i < 364; i++) {
            const day = new Date(firstDay.getTime() + (i * 24 * 60 * 60 * 1000));
            this.storySvg.append("text")
                .classed("month-day", true)
                .attr("y", 10)
                .attr("x", this.xScale(day) + 4)
                //.text("1")
                .text(day.getDate());
            this.storySvg.append("text")
                .classed("month-day", true)
                .attr("y", 22)
                .attr("x", this.xScale(day) + 4)
            //.text(day.getDay() + 1);
            //.text("0");

            const newMonthIndex = (day.getFullYear() === 2021) ? 0 : day.getMonth() + 1;
            if (newMonthIndex !== monthIndex) {
                monthIndex = newMonthIndex;

                this.storySvg.append("line")
                    .attr("x1", this.xScale(day))
                    .attr("y1", 20)
                    .attr("x2", this.xScale(day))
                    .attr("y2", 10000)
                    .style("stroke", "grey")
                    .style("stroke-width", 1);

                this.storySvg.append("text")
                    .classed("background-month-large", true)
                    .attr("y", 180)
                    .attr("x", this.xScale(day) + 35)
                    //.attr("transform", 'rotate(45)') 
                    .text(monthNames[monthIndex]);
            }
        }
    }

    drawDaysOfMonth() {

    }

    text(text, svg, style, x, y, id = "") {  
        const textElm = 
            svg.append("text")
            .attr("x", x)
            .attr("y", y)
            .attr("pointer-events", "none")
            .text(text)
            .classed(style, true)

        // Give it an id, if provided    
        if (id != "")
            textElm.attr("id", id);  
            
        return textElm;    
    }

    drawDateAxis() {
        return;

        this.storySvg.append("g")
            .attr("transform", "translate(10," + ((this.rowHeight * this.mediasWithStoryCount.length) + 20) + ")")
            .attr("class", "dateAxis")
            .call(d3.axisBottom(this.xScale).ticks(6 * 12 + 1));
    }

    highlightMediaRow(on, mediaName, mediaColor) {
        let color = "white";
        //let color = mediaColor;
        let bold = "normal";
        if (on) {
            color = "#F0F0F0";
            bold = "800";
        }
        d3.select("#l" + className(mediaName)).attr("fill", color);
        d3.select("#r" + className(mediaName)).attr("fill", color);
        d3.select("#t" + className(mediaName)).attr("font-weight", bold);
    }

    niceDate(date) {
        const weekdays = ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"];
        const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

        return weekdays[date.getDay()] + " " + months[date.getMonth()] + " " + date.getDate() + ", " + date.getFullYear();
    }
}