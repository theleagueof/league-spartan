![League Spartan Variable](https://raw.githubusercontent.com/sursly/league-spartan/master/_images/leaguespartan-variable.gif)

League Spartan Variable
=============

**The variable fork** 

This version has been expanded considerably with multiple weights, from Extralight (200) to Black (900). The Bold style (700) is as close to the original League version as you’re going to get here, but it will differ slightly (as in, if you’re spacing is sacred maybe don’t use this version).

I re-drew almost every glyph for better variable rendering. It’s still a work in progress but stable for use.

![Updated League Spartan Styles](https://raw.githubusercontent.com/sursly/league-spartan/master/_images/leaguespartan-styles.png)

**Names**

It’s worth noting that you don’t need to use the variable version to get all 8 styles. The static OTF and TTF files (in their respective folders) will work and are simply named *League Spartan*. They will work fine alongside the single variable TTF file which is called *League Spartan Variable*.

**How-to**

New to variable fonts? Great, maybe. Desktop applications are slowly adopting this updated TTF format. Currently support is limited to Adobe Illustrator and Adobe Photoshop. Install it like you would any other font. 

Web use is a different story completely though. The variable TTF file will work on the web for some browsers but the variable WOFF2 file will provide almost complete support for modern browsers. That one file (lightweight at 24kb!) can serve up all 8 pre-defined styles and whatever else you feel like using. Import the I find that ‘font-variation-settings: “wght” 345;’` renders better than `font-weight: 345;` Here is how you can initially call League Spartan in your css, provided your webfont is in the same directory as your stylesheet:
```
@font-face {
font-family: ‘League Spartan Variable’;
src: url('LeagueSpartanVariable.woff2') format('woff2-variations'); 
font-weight: 200 900;
}
```

**Questions/suggestions**

Hit me up on on [Twitter](https://www.twitter.com/typeler) or make an issue here on Github.

## [Download ZIP](https://github.com/sursly/league-spartan/archive/master.zip)

