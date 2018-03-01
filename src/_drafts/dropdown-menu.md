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

But most of the examples I found looked fairly complicated -- they were pulling in big JavaScript libraries, like jQuery or Bootstrap, and this was for a small site that didn't have any existing JavaScript.
I'm not much of a web developer, and copy/pasting code I don't really understand into my site feels scary.
If I don't know how it works, how can I know it's safe, or make changes?

Since this feels a relatively simple component, I wanted to try building it from scratch.
I don't have many skills in JavaScript or CSS, but could I do this?

I came up with something that seems to work, and in this post I'll walk through how I wrote it.
I don't think there's anything novel here, but a few things were new to me.

[bootstrap]: https://getbootstrap.com/docs/4.0/components/navbar/

<!-- summary -->

## Part 1: A static menu for wide screens

I started by creating a list of links, and styling that.
In years gone by, I might have used a `<div>` or a `<ul>` -- but semantic HTML elements have been around for a while now, so I used `<nav>` instead.

```html
<nav>
  <ul>
    <li><a href="#">First link</a></li>
    <li><a href="#">Second link</a></li>
    <li><a href="#">Third link</a></li>
    <li><a href="#">Final link</a></li>
  </ul>
</nav>
```

Without any CSS, these render as a typical HTML list -- a vertical list of bullets, one below the other.
If I want them to be a horizontal line with bullets between them, I need to add a bit of CSS:

```css
nav ul {
  list-style-type: none;
  margin:  0;
  padding: 0;
}

nav ul li {
  display: inline-block;
}

nav li:not(:last-child)::after {
  content: " \2022 ";
}
```

The first two selectors take a vertical list of bullets, remove the bullet character, and turn them into a horizontal line.

The third selector gets all the `<li>` elements *except* the last one, and adds an [:after pseudo-element][pseudo] that includes a bullet character.
The `\2022` is a [character escape][escape] that includes the hex code of the [bullet character][bullet] I'm using -- this is how you include non-ASCII characters in CSS.

Here's what the output looks like:

<figure>
  <img src="/images/2018/navbar_1a.png" style="max-width: 527px;">
  <figcaption>
    A menu of four links, without any styling (left), and with styling to render it as a horizontal list (right).
  </figcaption>
</figure>

[pseudo]: https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements
[escape]: https://www.w3.org/International/questions/qa-escapes
[bullet]: https://www.fileformat.info/info/unicode/char/2022/index.htm

---

is this just NIH syndrome?


