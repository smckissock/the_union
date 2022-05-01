import { text } from "./shared.js";
import { page, selectedDatesHeight, barColor, storyGroup, eventGroup } from "./search.js";


export class DateChart {

    constructor(svg, monthScale, weekScale, dayScale, importantDays) {
        this.svg = svg;
        this.monthScale = monthScale;
        this.weekScale = weekScale;
        this.dayScale = dayScale;
        this.importantDays = importantDays;

        this.brushGroup; 
        this.monthLabel;  

        this.loading = true;
    }

    show(stories) {

        const top = 14;
        const bottom = 112;

        let brushExtent; 
        if (!this.loading) 
            brushExtent = d3.brushSelection(d3.select(".brush").node());
                
        let storiesByMonth = d3.nest()
            .key(function(d) { return d.monthNum; })
            .entries(stories);

        let storiesByWeek = d3.nest()
            .key(function(d) { return d.weekNum; })
            .entries(stories);    

        let margin = page.storyMargins;

        const yScale = d3.scaleLinear()
            .domain([0, d3.max(storiesByWeek, d => d.values.length)]).nice()
            .range([selectedDatesHeight - margin.bottom, margin.top + 20]);
    

        // Transition??
        this.svg.selectAll("*").remove();

        this.monthLabel = this.svg.append("text")
            .classed("month-range-label", true)
            .attr("y", 18);

        // Bars for each week, where the height is the number of stories    
        let rects = this.svg.selectAll("rect")
            .data(storiesByWeek, d => d.key).enter().append("rect")
            .attr("x", d => this.weekScale(d.key))
            .attr("y", d => yScale(d.values.length))
            .attr("width", 15)
            .attr("height", d => yScale(0) - yScale(d.values.length))
            .attr("fill", barColor)
            .on('mouseover', function (d) {
                //console.log(d);
            });

        // Draw light grey text with the months    
        const months = ["Dec", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "July", "Aug", "Sep", "Oct", "Nov" ];   
        const firstDay = new Date("2021-12-01");
        let monthIndex = -1;
        for (let i = 0; i < 364; i++) {
            const day = new Date(firstDay.getTime() + (i * 24 * 60 * 60 * 1000));
            const newMonthIndex = (day.getFullYear() === 2021) ? 0 : day.getMonth() + 1;
            if (newMonthIndex !== monthIndex) {
                monthIndex = newMonthIndex;
                this.svg.append("line")    
                    .attr("x1", this.dayScale(day))
                    .attr("y1", top)
                    .attr("x2", this.dayScale(day))
                    .attr("y2", bottom)
                    .style("stroke", "grey")
                    .style("stroke-width", 1);
                    
                this.svg.append("text")
                    .classed("background-month", true)
                    .attr("y", 38)
                    .attr("x", this.dayScale(day) + 12)
                    .text(months[monthIndex]);

                this.svg.append("text")
                    .classed("background-year", true)
                    .attr("y", 56)
                    .attr("x", this.dayScale(day) + 17)
                    .text(d => (monthIndex === 0) ? "2021" : "2022");
            }
        }

        // Election Day
        this.addDayLines(top, bottom);
       

        // Light box showing time remaining before election    
        // this.svg.append("rect")    
        //     .attr("x", this.dayScale(new Date())) 
        //     .attr("y", top)
        //     //.attr("width", 820 - this.dayScale(new Date()))
        //     .attr("width", 820 - this.dayScale(new Date()))
        //     .attr("height", bottom - top)
        //     .style("fill", "#e6e6e6")
        //     .style("fill", "green")
        //     .style("fill-opacity", 0.22); 

        // .bind(this) forces "this" inside brushMode to be the chart instance, not the dom node that triggerted the event
        // https://stackoverflow.com/questions/36489579/this-within-es6-class-method

        let brush = d3.brushX()
            .extent([ [this.dayScale.range()[0], top], [this.dayScale(new Date()), bottom] ])
            //.extent([ [310, top], [320, bottom] ])
            //.extent([ [50,top], [600,bottom] ])
            .on("brush", this.brushMove.bind(this));     

        this.brushGroup = this.svg.append("g")
            .attr("class", "brush")
            .call(brush);

        // Would like to just create the brush on startup, not every time the stories changes, but can't get it to work
        // So move the brush to where it was before   
        // SUPER AWKWARD. NEEDS TO BE DONE WITH DATES, NOT MONTHS
        //if (this.loading)    
            //brush.move(this.brushGroup, [this.monthScale(90.05), this.monthScale(92.55)]);
        //    brush.move(this.brushGroup, [this.monthScale(90.05), this.dayScale(new Date())]); // first should be ~30 days ago
        // else
        //     brush.move(this.brushGroup, brushExtent);

        // Ugh - need to calculate this based on today's date
        brush.move(this.brushGroup, [250, 350]);

        
        // Prevent resizing of brush
        d3.selectAll('.brush>.handle').remove();
        d3.selectAll('.brush>.overlay').remove();

        this.loading = false;
    }

    // Vertical lines for specific days (e.g. election day)
    addDayLines(top, bottom) {
        this.importantDays.forEach(day => {
            this.svg.append("line")    
                .attr("x1", this.dayScale(day.date)) 
                .attr("y1", top)
                .attr("x2", this.dayScale(day.date))
                .attr("y2", bottom)
                .style("stroke", "red")
                .style("stroke-width", 4); 

            const label = day.name + " " + (day.date.getMonth() + 1) +  "/" + (day.date.getDate() + 1);
            this.text(label, this.svg, "days-until-election", this.dayScale(day.date) - 31, top - 4); 
        });
    }

    brushMove() {
        // Gets months for brush
        var months = d3.brushSelection(d3.select(".brush").node())
            .map(this.monthScale.invert);

        var days = d3.brushSelection(d3.select(".brush").node())
            .map(this.dayScale.invert);    

        let shiftDays = -page.monthToStoryWidth(days[0]);    

        this.showSelectedDates(months);
        let shiftRight = -page.monthToStoryWidth(months[0]);
        storyGroup.attr("transform", "translate(" + shiftRight + ", 0)"); // This does the scroll of the story chart
        eventGroup.attr("transform", "translate(" + shiftRight + ", 0)");
    }

    // Shows a date range above the chart that moves along with the mouse. Hidden, maybe not needed.
    showSelectedDates(extent) {
        return;

        function getDate(monthId) {
            let month = months.filter(d => d.monthId == Math.round(monthId + 0.5))[0];
            return month.month + " " + month.year; 
        }

        const months = this.makeMonths();

        let bru = d3.brushSelection(d3.select(".brush").node());
        let monthsLabel = getDate(extent[0]) + "-" + getDate(extent[1]);
        this.monthLabel
            .text(monthsLabel)
            .attr("x", bru[0]); 
    }

    makeMonths() {
            const monthDefs = [
                { month: "Jan", qtr: 1 }, { month: "Feb", qtr: 1 }, { month: "Mar", qtr: 1 },
                { month: "Apr", qtr: 2 }, { month: "May", qtr: 2 }, { month: "Jun", qtr: 2 },
                { month: "Jul", qtr: 3 }, { month: "Aug", qtr: 3 }, { month: "Sep", qtr: 3 },
                { month: "Oct", qtr: 4 }, { month: "Nov", qtr: 4 }, { month: "Dec", qtr: 4 }
            ];
        
            let months = []
            let year = 2013;
            let monthId = 1;
            while (year < 2023) {
                monthDefs.forEach(function (m) {
                    let month = {};
                    month.monthId = monthId;
                    month.year = year;
                    month.quarter = "Q" + m.qtr;
                    month.month = m.month
        
                    months.push(month);
                    monthId++;
                });
                year++;
            }
            return months;
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

    daysUntilElection() {   
        const oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
        const firstDate = new Date();
        const secondDate = new Date(2022, 11, 8);

        return Math.round(Math.abs((firstDate - secondDate) / oneDay) - .5); 
    }
}