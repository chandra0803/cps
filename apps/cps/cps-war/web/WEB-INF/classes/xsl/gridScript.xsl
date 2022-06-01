<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lxslt="http://xml.apache.org/xslt" xmlns:java="http://xml.apache.org/xslt/java" version="1.0">

  <xsl:output method="html" indent="yes"/>


<xsl:template name="gridScript">
  <xsl:param name="cellHeight"                   select="''"/>
  <xsl:param name="cellWidth"                    select="''"/>
  <xsl:param name="rowHeaderDepth"               select="''"/>
  <xsl:param name="columnHeaderDepth"            select="''"/>
  <xsl:param name="rowCount"               select="''"/>
  <xsl:param name="columnCount"            select="''"/>
  <xsl:param name="rowHeaderWidthCalculated"     select="''"/>
  <xsl:param name="columnHeaderHeightCalculated" select="''"/>

<script>

// DEBUGGING Scripts

function shoWin()
{
  win = window.open('','_blank');
  var results = document.documentElement.innerHTML;
  
  var reLeft = new RegExp("&lt;", "g");
  var reRight = new RegExp("&gt;", "g");

  var results1 = results.replace(reLeft, "&amp;lt;");
  var results2 = results1.replace(reRight, "&amp;gt;");

  win.document.write(results2);
}

// Common grid objects
  var data       = {};
	var scrollbars = {};
	var top        = {};
	var left       = {};
	var scrollImg  = {};
	var space      = {};


// Sizing and Scrolling Scripts

function initGrid()
{
  data       = document.all['gridData']; 
  scrollbars = document.all['scrollDiv'];	
  top        = document.all['gridTop'];  
  left       = document.all['gridLeft']; 
	scrollImg  = document.all['inlineClear'];
	space      = document.all['gridCorner'];

  resizeScroll();

  // uncommenting this will cause the page HTML
	// to pop in a new window for debugging your XML/XSL
	//shoWin();
}


function scrollAdj()
{
	var x = scrollbars.scrollLeft;
	var y = scrollbars.scrollTop;

	data.scrollLeft = x;
	top.scrollLeft  = x;
	data.scrollTop  = y;
	left.scrollTop  = y;

  //alert("sa");
}

function dataScrollAdj(row, column)
{
  // if the data sheet has automatically moved up/down or right/left due to tabbing, 
  // make sure the cells are fully visible
  // then move the rest of the grid into alignment
  if ((data.scrollLeft != scrollbars.scrollLeft) || (data.scrollTop != scrollbars.scrollTop))
  {
    if (column &lt; <xsl:value-of select="$rowHeaderDepth"/>)
    {
      data.scrollLeft  = 0;
    }
    // this code is too naive, it needs to calculate if tabbing has left the current window position 
    // leaves the rightmost column partially obscured but the math is not as easy as this
    //else
    //{
    //  data.scrollLeft += (<xsl:value-of select="$cellWidth"/> - (data.scrollLeft % <xsl:value-of select="$cellWidth"/>));
    //}
  
    scrollbars.scrollLeft = data.scrollLeft;
    top.scrollLeft        = data.scrollLeft;

    if (row &lt; <xsl:value-of select="$columnHeaderDepth"/>)
    {
      data.scrollTop = 0;
    }
    // this code is too naive, it needs to calculate if tabbing has left the current window position 
    // the bottommost row partially obscured but the math is not as easy as this
    //else
    //{
    //  data.scrollTop += (<xsl:value-of select="$cellHeight"/> - (data.scrollTop % <xsl:value-of select="$cellHeight"/>));
    //}

    scrollbars.scrollTop  = data.scrollTop;
    left.scrollTop        = data.scrollTop;
  }
}


function resizeScroll()
{
	scrollImg.width  = tableTop.offsetWidth + <xsl:value-of select="$rowHeaderWidthCalculated"/>;
	scrollImg.height = tableLeft.offsetHeight + <xsl:value-of select="$columnHeaderHeightCalculated"/>;

	var y = scrollbars.clientHeight;
	var x = scrollbars.clientWidth;

	data.runtimeStyle.width  = x;
	top.runtimeStyle.width   = x;
	data.runtimeStyle.height = y;
	left.runtimeStyle.height = y;

	top.scrollLeft = data.scrollLeft;
	left.scrollTop = data.scrollTop;

  data.runtimeStyle.zIndex       = 1;
	top.runtimeStyle.zIndex        = 2;
	left.runtimeStyle.zIndex       = 2;
	space.runtimeStyle.zIndex      = 3;
	scrollbars.runtimeStyle.zIndex = 0;
}


// CELL Editing and Event Scripts
function cellEnter(row, column, cell)
{
  // realign the headers
  // in the event we've tabbed through the 
  // grid to a new cell 
  // (moving the data grid under the scroll headers)
  dataScrollAdj(row, column);


  //alert(event.type + " " + cell.name);

}


function cellExit(row, column, cell)
{
  //alert(event.keyCode + " " + cell.name);

}

function cellChanged(row, column, cell)
{
  //alert(event.keyCode + " " + cell.name);

  window.status = (row + ":" + column) + " is now " + cell.value;
}


function cellKeyPress(row, column, cell)
{
  var ek = event.keyCode;
  //window.status = "keycode: " + ek;

  //if (ek &gt; 36 &amp;&amp; ek &lt; 41)
  //{
  //  var newRow = row;
  //  var newCol = column;

  //  if (ek==37)
  //    // left
  //    newCol = ((column - 1) &lt; 1) ?  <xsl:value-of select="$columnCount"/> : (column - 1);
  //  else if (ek==39)
  //    // right
  //    newCol = ((column + 1) &gt; <xsl:value-of select="$columnCount"/>) ? 1 : (column + 1);
  //  else if (ek==38)
  //    // up
  //    newCol = ((row + 1) &gt; <xsl:value-of select="$rowCount"/>) ? 1 : (row + 1);
  //  else if (ek==40)
  //    // down
  //    newCol = ((row - 1) &lt; 1) ?  <xsl:value-of select="$rowCount"/> : (row - 1);

  //  document.all[newRow + ":" + newCol].focus();
  //  return false;
  //}
}


</script>


</xsl:template>

</xsl:stylesheet>
