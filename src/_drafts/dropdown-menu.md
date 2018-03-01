---
layout: post
title: A lightweight, JS-free dropdown menu
tags: web-dev
---

Recently I had to build a new navigation bar for a mobile website.
This is a fairly standard component: a horizontal list of links when displayed on a wide screen, which becomes a collapsible vertical list on narrow screens.

Here's a quick mockup of the sort of navbar I wanted:

<figure>
  <img src="/images/2018/navbar_mockup.png" style="max-width: 557px;">
  <figcaption>
    On a wide screen, all the links are available immediately.
    On a narrow screen, you only see "Menu" at first.
    You need to tap "Menu" or the hamburger icon, and then the rest of the links become visible &ndash; at the cost of a bit of vertical space.
  </figcaption>
</figure>

This component has been done lots of times, and I found lots of implementations via Google -- here's one [in Bootstrap][bootstrap], for example.
But most of what I found meant loading big JavaScript libraries, like jQuery or Bootstrap, and this was for a small site that didn't have any existing JavaScript.
Some of them also looked quite complicated.
I'm not much of a web developer, and copy/pasting code I don't really understand into my site feels scary.
If I don't know how it works, how can I make changes?



[bootstrap]

---

is this just NIH syndrome?
