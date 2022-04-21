class EventChart {

    constructor(labelSvg, eventSvg, eventGroup, xScale, events, storySvg) {
        this.labelSvg = labelSvg;
        this.eventSvg = eventSvg;
        this.eventGroup = eventGroup;
        this.xScale = xScale;
        this.events = events;
        this.storySvg = storySvg;

        this.svgHeight;
        this.eventsByType;

        this.loading = true;
        
        this.events.forEach(event => event.dateObject = new Date(event.date)); 

        this.eventTypes = d3.nest()
            .key(function(d) { return d.type; })
            .entries(this.events); 

        // For now these are all dark grey 
        const eventColor = "#222222";  
        this.eventTypes[0].color = eventColor;
        this.eventTypes[1].color = 	eventColor;
        this.eventTypes[2].color = eventColor;
    }

    setEventsVerticalPosition(labels) {
        let types = this.types;    
        
        const xScale = this.xScale; 
        const labelSvg = this.labelSvg;
        const eventGroup = this.eventGroup;
        
        const rowHeight = 16;    
        let top = 50;  
        //let top = 66;  
        this.eventTypes.forEach(function(eventType) {
            eventType.y = top;

            // Everything below gets run for each type
            let events = eventType.values;
            // Sort each type of event from earlier to later
            events.sort((a,b) => {return a.dateObject - b.dateObject});
            
            // The right-most text for each row 
            let rowsRight = [];
            events.forEach(function(event) {                
                // Put in existing row, if it fits
                let placed = false;
                for (var i = 0; i < rowsRight.length; i++) {
                    if (rowsRight[i] < xScale(event.dateObject)) {
                        event.y = top + (i * rowHeight) - 3;
                        rowsRight[i] = xScale(event.dateObject) + event.length;
                        placed = true;
                        break;
                    }
                } 
                // Doesn't fit - add a new row at the bottom
                if (!placed) {
                    rowsRight.push(xScale(event.dateObject) + event.length);
                    event.y = top + ((rowsRight.length - 1) * rowHeight);
                }
            });   
            
            // Draw grey bands for types
            const typeHeight = (rowsRight.length * rowHeight) + 9;
            [eventGroup, labelSvg].map(d => d
                .append("rect")
                .attr("x", 0)
                .attr("y", top - 14)
                .attr("width", xScale.range()[1])
                .attr("height", typeHeight)
                .attr("fill", "#F3F3F3")
                .attr("fill-opacity", 0.6));

            // Make next group of events move down
            top = top + typeHeight + 8;
        });
 
        let height = top + 8;
        this.labelSvg.attr("height", height) 
        this.eventSvg.attr("height", height)   
        document.documentElement.style.setProperty('--events-height', height.toString() + "px");
        this.svgHeight = height;

        // Set y on all events
        labels.attr("y", d => d.y + 4);
    }

    show() {
        let labels = this.eventGroup.selectAll("text").data(this.events).enter().append("text")
            .text(d => d.name) 
            .attr("x", d => this.xScale(d.dateObject) + 12)
            .classed("eventLabel", true)
            .each(function(d) {
                d.length = this.getComputedTextLength(); 
            });

        // This figures out what the height of each event label should be and sets it
        // It also sets this.svgHeight, which depends on how much space the events take up     
        this.setEventsVerticalPosition(labels);    

        // Vertical lines for events on event chart
        this.eventGroup.selectAll("line").data(this.events).enter().append("line")
            .attr("x1", d => this.xScale(d.dateObject))
            .attr("y1", d => d.y)
            .attr("x2", d => this.xScale(d.dateObject))
            //.attr("y2", 120)
            .attr("y2", this.svgHeight)
            .style("stroke", d => this.eventTypes.filter(x => x.key == d.type)[0].color)
            .style("stroke-width", 1); 

        this.eventGroup.selectAll("circle").data(this.events).enter().append("circle")
            .attr("fill", "black")
            .on('click', function (d) {
            })
            .on('mouseover', function (d) {
            })
            .on('mouseout', function (d) {
            })
            .attr("cx", d => this.xScale(d.dateObject))
            .attr("cy", d => d.y)
            .attr("r", d => 8)
            .attr("fill", d => this.eventTypes.filter(x => x.key == d.type)[0].color)
            .attr("stroke", "black")
            .attr("strokeWidth", 1)
            .style("fill-opacity", 1);

        this.showEventTypeLabels(); 
        this.drawMonths();
           
    }

    showEventTypeLabels() {        
        this.labelSvg.selectAll("text").data(this.eventTypes).enter().append("text")
            .text(d => d.key)
            .attr("x", 6)
            .attr("y", d => d.y + 3)
            .classed("eventTypeLabel", true)
            .attr("fill", d => d.color)  
    }

    // Called by Story chart because lins need to come after the rectangles
    drawMonths() {
        let xScale = this.xScale;
        let start = xScale.domain()[0];
        let end = xScale.domain()[1];
        
        // Move to first day of month
        while (start.getDate() != 1)
            start = new Date(start.setDate(start.getDate() + 1));

        while (end > start) {
            if (this.loading) {
                let month = this.eventGroup
                    .append("text")
                    .text(start.toLocaleString('en-us', {month: 'long'}) + " " + start.toLocaleString('en-us', {year: 'numeric'})) 
                    .attr("y", 24)
                    .classed("background-month", true);

                // Once the month label is created, get the width and figures out what X needs to be to center it    
                let textWidth = month.node().getComputedTextLength();
                let nextMonth = new Date(start).setMonth(start.getMonth() + 1);
                let monthWidth = xScale(nextMonth) - xScale(start); 
                let offset = (monthWidth - textWidth) / 2;
                month.attr("x", xScale(start) + offset - 2);
            }

            this.eventGroup.append("line")
                .attr("x1", d => xScale(start))
                .attr("y1", 0)
                .attr("x2", d => xScale(start))
                .attr("y2", this.svgHeight)
                .classed("month-line", true)

            this.storySvg.append("line")
                .attr("x1", d => xScale(start))
                .attr("y1", 0)
                .attr("x2", d => xScale(start))
                .attr("y2", this.storySvg.attr("height") - 10)
                .classed("month-line", true)

            start = new Date(start.setMonth(start.getMonth() + 1));  
        }
        this.loading = false;
    }

    // Vertical lines for events on story chart
    // Called by Story chart because lines need to come after the rectangles
    showEventsOnStoryChart() {
        // These conflict with existing lines?  Do I need keys??
        this.storySvg.selectAll("line").remove();
        this.storySvg.selectAll("line").data(this.events).enter().append("line")
            .attr("x1", d => this.xScale(d.dateObject))
            .attr("y1", 0)
            .attr("x2", d => this.xScale(d.dateObject))
            .attr("y2", this.storySvg.attr("height"))
            .classed("event-line", true);
    }
}