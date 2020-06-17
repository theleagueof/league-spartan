![League Spartan Variable](https://raw.githubusercontent.com/sursly/league-spartan/master/_images/leaguespartan-variable.gif)

League Spartan Variable
=============

Thanks to [Tyler Finck's](https://twitter.com/typeler) repeated and exhaustive efforts, this version of **League Spartan** has been expanded considerably with multiple weights, from Extralight (200) to Black (900). The Bold style (700) is as close to the original League version as you’re going to get here, redrawn for better variable rendering. But take note — it will differ slightly from the first version (particularly in spacing).

![Updated League Spartan Styles](https://raw.githubusercontent.com/sursly/league-spartan/master/_images/leaguespartan-styles.png)

**Language Support**
Afrikaans, Albanian, Azerbaijani, Basque, Bosnian, Catalan, Croatian, Czech, Danish, Dutch, English, Estonian, Faroese, Filipino, Finnish, French, Galician, German, Hungarian, Icelandic, Indonesian, Irish, Italian, Latvian, Lithuanian, Malay, Norwegian Bokmål, Polish, Portuguese, Romanian, Slovak, Slovenian, Spanish, Swahili, Swedish, Turkish, Vietnamese, Welsh, Zulu

**Names**

It’s worth noting that you don’t need to use the variable version to get all 8 styles. The static OTF and TTF files (in their respective folders) will work and are simply named *League Spartan*.

**How-to**

New to variable fonts? Great, maybe. Desktop applications are slowly adopting this updated TTF format. Currently support is limited to Adobe Illustrator and Adobe Photoshop. Install it like you would any other font.

Web use is a different story completely though. The variable TTF file will work on the web for some browsers but the variable WOFF2 file will provide almost complete support for modern browsers. That one file (lightweight at 24 kb!) can serve up all 8 pre-defined styles and whatever else you feel like using. I find that `font-variation-settings: "wght" 345;` renders better than `font-weight: 345;` Here is how you can initially call League Spartan in your css, provided your webfont is in the same directory as your stylesheet:
```css
@font-face {
  font-family: 'League Spartan Variable';
  src: url('LeagueSpartanVariable.woff2') format('woff2-variations');
  font-weight: 200 900;
}
```

**Questions/suggestions**

Hit Tyler up on on [Twitter](https://www.twitter.com/typeler), tag [@theleagueof](https://www.twitter.com/theleagueof), or make an issue here on Github.
