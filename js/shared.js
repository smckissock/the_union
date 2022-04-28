

// Writes text to an svg, with a css class and optional id
export function text(text, svg, style, x, y, id = "") {  
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

// Writes centered text to an svg, but pass in a css class (Doesn't actually center..)
export function centeredText(text, svg, style, x1, width, y, id = "") {
    const textElm = svg.append("text")
        .attr("x", x1 + (width / 2))
        .attr("y", y)
        .attr("text-anchor", "middle")
        .text(text)
        .classed(style, true);

    // Give it an id, if provided    
    if (id != "")
        textElm.attr("id", id); 
} 


// Writes right justified text to an svg, but pass in a css class
export function rightText(text, svg, style, x1, width, y) {
    if (text === "NaN")
        return;

    svg.append("text")
        .attr("x", x1 + width)
        .attr("y", y)
        .attr("text-anchor", "end")
        .text(text)
        .classed(style, true);
} 

export function secondsToString(secs) {
    //var sec_num = parseInt(this, 10); // don't forget the second param
    var hours   = Math.floor(secs / 3600);
    var minutes = Math.floor((secs - (hours * 3600)) / 60);
    var seconds = secs - (hours * 3600) - (minutes * 60);

    if (minutes < 10) {minutes = "0" + minutes;}
    if (seconds < 10) {seconds = "0" + seconds;}
    
    return hours + ':' + minutes + ':' + seconds;
}

export function formatDate(date, includeDayOfWeek = false) {
    var daysOfWeek = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
    var monthNames = [
      "January", "February", "March",
      "April", "May", "June", "July",
      "August", "September", "October",
      "November", "December"
    ];
  
    var day = date.getDate();
    var monthIndex = date.getMonth();
    var year = date.getFullYear();
  
    const rslt = monthNames[monthIndex] + ' ' + day + ", " + year;

    if (!includeDayOfWeek)
        return rslt;
    else 
        return daysOfWeek[date.getDay()] + ", " + rslt; 
}


// Inserts value at index postition of str 
export function insert(str, index, value) {
    return str.substr(0, index) + value + str.substr(index);
} 


export function className(name){
    if (!name)
        return "";

    name = name.replace(/\W/g, '')
    return name.replace(/\s+/g, '');    
}


export function slugify(text) {
    return text.toString().toLowerCase()
      .replace(/\s+/g, '-')           // Replace spaces with -
      .replace(/[^\w\-]+/g, '')       // Remove all non-word chars
      .replace(/\-\-+/g, '-')         // Replace multiple - with single -
      .replace(/^-+/, '')             // Trim - from start of text
      .replace(/-+$/, '');            // Trim - from end of text
  }
