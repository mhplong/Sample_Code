var timer = setInterval("showClutter();", 10*60*1000);

function redraw()
{
    var bgnd = document.getElementById("bgnd");
    var dclutter = widget.preferenceForKey("dclutter");
    var dlightning = widget.preferenceForKey("dlightning");

    bgnd.innerHTML="<img id='backgroundImage' src='http://radblast.wunderground.com/cgi-bin/radar/WUNIDS_map?station=BMX&brand=wui&num=6&delay=15&type=N0R&frame=0&scale=1.000&noclutter=" + dclutter + "&t=1145500882&lat=33.53933716&lon=-86.55779266&label=Leeds%2C+AL&showstorms=0&map.x=400&map.y=240&centerx=400&centery=240&transx=0&transy=0&showlabels=1&severe=0&rainsnow=0&lightning=" + dlightning + "&random="+ Math.floor(Math.random() * 999999) + "' height=300 width=400>";
}

function setup()
{
    if(window.widget)
    {
	var dclutter = widget.preferenceForKey("dclutter");
	var dlightning = widget.preferenceForKey("dlightning");
	var clutter = document.getElementById("clutter");
	var lightning = document.getElementById("lightning");
	var bgnd = document.getElementById("bgnd");

	if (dclutter==0)
	{
	    clutter.checked=true;
	} else {
	    clutter.checked=false;
	} if (dlightning == 1)
	{
	    lightning.checked=true;
       } else {
	    lightning.checked=false;
	}

	bgnd.innerHTML="<img id='backgroundImage' src='http://radblast.wunderground.com/cgi-bin/radar/WUNIDS_map?station=BMX&brand=wui&num=6&delay=15&type=N0R&frame=0&scale=1.000&noclutter=" + dclutter + "&t=1145500882&lat=33.53933716&lon=-86.55779266&label=Leeds%2C+AL&showstorms=0&map.x=400&map.y=240&centerx=400&centery=240&transx=0&transy=0&showlabels=1&severe=0&rainsnow=0&lightning=" + dlightning + "&random="+ Math.floor(Math.random() * 999999) + "' height=300 width=400>";
	timer = setInterval("showClutter();", 10*60*1000);
    }
}

if (window.widget)
{
    widget.onshow=onshow;
    widget.onhide=onhide;
}

function showWebsite(url) {
var websiteURL = url;

widget.openURL(websiteURL);
}

function changeWorld(elem)
{
    var world = document.getElementById("worldText");

    switch( parseInt(elem.options[elem.selectedIndex].value))
    {
	case 1:
	    world.innerText=" ";
	    if(window.widget)
	    {
		widget.setPreferenceForKey(" ", "worldString");
		widget.setPreferenceForKey("0", "popupidx");
	    }
	    break;
	case 2:
	    world.innerText="Hello !!!";
	    world.style.left="215px";
	    if (window.widget)
	    {
		widget.setPreferenceForKey("Hello !!!", "worldString");
		widget.setPreferenceForKey("215px","leftOffset");
		widget.setPreferenceForKey("1", "popupidx");
	    }
	    break;
	case 3:
	    world.innerText="Goodbye !!!";
	    world.style.left="185px";
	    if(window.widget)
	    {
		widget.setPreferenceForKey("Goodbye !!!","worldString");
		widget.setPreferenceForKey("185px","leftOffset");
		widget.setPreferenceForKey("2", "popupidx");
	    }
	    break;
    }
}

function onshow()
{

}

function onhide()
{

}

function showPrefs()
{
    var front = document.getElementById("front");
    var back = document.getElementById("back");

    if (window.widget)
	widget.prepareForTransition("ToBack");

    front.style.display="none";
    back.style.display="block";

    if (window.widget)
	setTimeout('widget.performTransition();', 0);

    document.getElementById('fliprollie').style.display='none';
}

function showClutter()
{
    var dclutter = document.getElementById("clutter");

     if (dclutter.checked==false)
    {
	dclutter="1";
	widget.setPreferenceForKey("1","dclutter");
    }
    else
    {
	dclutter="0";
	widget.setPreferenceForKey("0","dclutter");
    }
    redraw();
}

function showLightning()
{
    var dlightning = document.getElementById("lightning");

     if (dlightning.checked==true)
    {
	dlightning="1";
	widget.setPreferenceForKey("1","dlightning");
    }
    else
    {
	dlightning="0";
	widget.setPreferenceForKey("0","dlightning");
    }
    redraw();
}

function hidePrefs()
{
    var front = document.getElementById("front");
    var back = document.getElementById("back");

    if (window.widget)
	widget.prepareForTransition("ToFront");

    back.style.display="none"
    front.style.display="block";

    if (window.widget)
	setTimeout('widget.performTransition();',0);

}

var flipShown = false;

var animation = {duration:0, starttime:0, to:1.0, now:0.0, from:0.0, firstElement:null, timer:null};

function mousemove (event)
{
    if (!flipShown)
    {
	if (animation.timer !=null)
	{
	    clearInterval (animation.timer);
	    animation.timer = null;
	}

	var starttime = (new Date).getTime() - 13;

	animation.duration =500;
	animation.starttime=starttime;
	animation.firstElement = document.getElementById('flip');
	animation.timer = setInterval("animate();",13);
	animation.from = animation.now;
	animation.to=1.0;
	animate();
	flipShown=true;
    }
}

function mouseexit(event)
{
    if(flipShown)
    {
	if (animation.timer !=null)
	{
	    clearInterval (animation.timer);
	    animation.timer = null;
	}

	var starttime = (new Date).getTime()-13;

	animation.duration=500;
	animation.starttime =starttime;
	animation.firstElement = document.getElementById ('flip');
	animation.timer = setInterval ("animate();", 13);
	animation.from = animation.now;
	animation.to = 0.0;
	animate();
	flipShown = false;
    }
}

function animate()
{
    var T;
    var ease;
    var time = (new Date).getTime();

    T = limit_3(time-animation.starttime, 0, animation.duration);

    if (T >= animation.duration)
    {
	clearInterval (animation.timer);
	animation.timer = null;
	animation.now = animation.to;
    }
    else
    {
	ease = 0.5 - (0.5 * Math.cos(Math.PI * T /animation.duration));
	animation.now = computeNextFloat (animation.from, animation.to, ease);
    }

    animation.firstElement.style.opacity = animation.now;
}

function limit_3 (a, b, c)
{
    return a < b ? b : (a > c ? c : a);
}

function computeNextFloat (from, to, ease)
{
    return from + (to - from) * ease;
}

function enterflip(event)
{
    document.getElementById('fliprollie').style.display = 'block';
}

function exitflip(event)
{
    document.getElementById('fliprollie').style.display = 'none';
}