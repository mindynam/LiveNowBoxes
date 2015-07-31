# Remove framer cursor-------
document.body.style.cursor = "auto"

#Default initialization-------

back = new BackgroundLayer({backgroundColor:"#1d1d1f"})
pageNo = 1

isHBOrec = false
isTNTrec = false
isAMCrec = false
isABCrec = false

isRec = [isHBOrec,isTNTrec,isAMCrec,isABCrec]

Framer.Defaults.Animation = {
    curve: "ease-in"
    time: .2
}


# initializing pages-------
page3 = new Layer
	x:0, y:0, width:1280, height:545, image:"images/9:00PM-rec@2x.png"
page2 = new Layer
	x:0, y:0, width:1280, height:545, image:"images/9:00PM@2x.png"
page1 = new Layer
	x:0, y:0, width:1280, height:545, image:"images/NowPlaying@2x.png"

pages = [page3, page2, page1]

for p in pages
	p.states.add
		hide: opacity:0

#Changing recording button color-------

recButton1= new Layer
	x:502, y:178, width:14, height:15, image:"images/recButton@2x.png"
recButton2=new Layer
	x:926, y:178, width:14, height:15, image:"images/recButton@2x.png"
recButton3=new Layer
	x:1138, y:178, width:14, height:15, image:"images/recButton@2x.png"
recButtons = [recButton1, recButton2, recButton3]
for r in recButtons
	r.states.add
		hide:opacity:0
	r.states.switch("hide")

#initializing channel hovers-------
abc1 = new Layer
	x:963, y:165, width:202, height:203, image:"images/ABC1@2x.png"
abc2 = new Layer
	x:963, y:165, width:202, height:203, image:"images/ABC2@2x.png"
abc3 = new Layer
	x:963, y:165, width:202, height:203, image:"images/ABC3@2x.png"
amc1 = new Layer
	x:751, y:165, width:202, height:203, image:"images/AMC1@2x.png"
amc2 = new Layer
	x:751, y:165, width:202, height:203, image:"images/AMC2@2x.png"
amc3 = new Layer
	x:751, y:165, width:202, height:203, image:"images/AMC3@2x.png"
hbo1 = new Layer
	x:327, y:165, width:202, height:203, image:"images/HBO1@2x.png"
hbo2 = new Layer
	x:327, y:165, width:202, height:203, image:"images/HBO2@2x.png"
hbo3 = new Layer
	x:327, y:165, width:202, height:203, image:"images/HBO3@2x.png"
tnt1 = new Layer
	x:539, y:165, width:202, height:203, image:"images/TNT1@2x.png"
tnt2 = new Layer
	x:539, y:165, width:202, height:203, image:"images/TNT2@2x.png"
tnt3 = new Layer
	x:539, y:165, width:202, height:203, image:"images/TNT3@2x.png"
recordpop = new Layer
	x:0, y:163, width:178, height:48, image:"images/recordpop@2x.png"

hbo = [hbo1,hbo2,hbo3]
tnt = [tnt1,tnt2,tnt3]
amc = [amc1,amc2,amc3]
abc = [abc1,abc2,abc3]

channels = [hbo,tnt,amc,abc]

#hide all hovers
for ch in channels
	for c in ch
		c.states.add
			hide: opacity:0
		c.states.switch("hide")	

#touchpoints-------
hboTouch = new Layer
	x:327, y:165, width:202, height:203
tntTouch = new Layer
	x:539, y:165, width:202, height:203
amcTouch = new Layer
	x:751, y:165, width:202, height:203
abcTouch = new Layer
	x:963, y:165, width:202, height:203
touchPoints = [hboTouch,tntTouch,amcTouch,abcTouch]

for t, index in touchPoints
	t.backgroundColor = "transparent"

hover = (pg,ch) ->
	switch pg
		when 1 then return ch[0]
		when 2 then return ch[1]
		when 3 then return ch[2]

#---function that updates recording status
updateRec = () ->
	for r in recButtons
		r.states.switch("hide")
	if isHBOrec
		recButton1.states.switch("default")
	if isAMCrec
		recButton2.states.switch("default")
	if isABCrec
		recButton3.states.switch("default") 



#page changing-------

updatePage = (pg) ->
	for p in pages
		p.states.switch("hide")
	switch pg
		when 1 
			page1.states.switch("default")
			for r in recButtons
				r.states.switch("hide")
		when 2
			page2.states.switch("default")
			updateRec()
		when 3
			page3.states.switch("default") 


updatePage (pageNo)
#---function that changes cursor to pointers
cursorChange = (x) ->
	x.on Events.MouseOver, ->
		document.body.style.cursor = "pointer"
	x.on Events.MouseOut, ->
		document.body.style.cursor = "auto"


now = new Layer
	x:330, y:110, width: 100, height: 30, backgroundColor:"transparent"

nine = new Layer
	x:450, y:110, width: 70, height: 30, backgroundColor:"transparent"

now.on Events.Click, ->
	pageNo = 1	
	updatePage(pageNo)
nine.on Events.Click, ->
	pageNo = 2
	updatePage(pageNo)
cursorChange(now)
cursorChange(nine)

#record popup------- 
recordpop.states.add
	hide: opacity:0 
recordpop.states.switch("hide")
cursorChange(recordpop)

#--- make record popup show up at the right places
recTouch1 = new Layer
	x:500, y:175, width: 20,height:20, backgroundColor:"transparent"
recTouch2 = new Layer
	x:924, y:175, width: 20,height:20, backgroundColor:"transparent"
recTouch3 = new Layer
	x:1136, y:175, width: 20,height:20, backgroundColor:"transparent"
	
recTouch = [recTouch1,recTouch2,recTouch3]
for r in recTouch
	r.bringToFront()
	cursorChange(r)
recTouch1.on Events.Click, (event) ->
	recordpop.x = recTouch1.x-18
	recordpop.states.next()

recTouch2.on Events.Click, (event) ->
	recordpop.x = recTouch2.x-18
	recordpop.states.next()

recTouch3.on Events.Click, (event) ->
	recordpop.x = recTouch3.x-18
	recordpop.states.next()
	

recordpop.on Events.Click, (event) ->
	print recordpop.x
	for t in touchPoints
		t.ignoreEvents
	recordpop.bringToFront()
	event.stopPropagation()
	recordpop.states.switch("hide")
	switch recordpop.x
		when 482 then isHBOrec = true
		when 906 then isAMCrec = true
		when 1118 then isABCrec = true
	updateRec()	
	print isHBOrec

# enable hover effect complete with cursor change (how do I make this DRY?)-------
hboTouch.on Events.MouseOver, ->
	if isHBOrec and (pageNo == 2)
		item = hbo3
	else
		item = hover(pageNo, hbo)
	item.states.switch("default")
	document.body.style.cursor = "pointer"

hboTouch.on Events.MouseOut, ->
	for h in hbo
		h.states.switch("hide")	
	document.body.style.cursor = "auto"

tntTouch.on Events.MouseOver, ->
	if isTNTrec and (pageNo == 2)
		item = hover(3,tnt)
	else
		item = hover(pageNo, tnt)
	item.states.switch("default")
	document.body.style.cursor = "pointer"

tntTouch.on Events.MouseOut, ->
	for h in tnt
		h.states.switch("hide")	
	document.body.style.cursor = "auto"

amcTouch.on Events.MouseOver, ->
	if isAMCrec and (pageNo == 2)
		item = hover(3,amc)
	else
		item = hover(pageNo, amc)
	item.states.switch("default")
	document.body.style.cursor = "pointer"

amcTouch.on Events.MouseOut, ->
	for h in amc
		h.states.switch("hide")	
	document.body.style.cursor = "auto"

abcTouch.on Events.MouseOver, ->
	if isABCrec and (pageNo == 2)
		item = hover(3,abc)
	else
		item = hover(pageNo, abc)
	item.states.switch("default")
	document.body.style.cursor = "pointer"

abcTouch.on Events.MouseOut, ->
	for h in abc
		h.states.switch("hide")	
	document.body.style.cursor = "auto"
