---
layout: post
title: Improving Slack's UX
categories: draft
logo: /assets/img/posts/Slack/slack_logo.png
priority: 1
excerpt: <p>A tutorial for creating UICollectionViewCells that are dynamically sized to fit their content.</p>
---
In short: we're going to examine the user experience of Slack's iOS app.

Everybody loves [Slack](https://slack.com/), for a good reason. It is a great product and a perfect example of how placing emphasis on UX could turn a good idea into a Billion Dollar product.

The reason I love Slack, other than the fact that it replaces the 40 year old email, is that the core ideas behind Slack have existed for years. IRC channels, IM, Group Chat, nothing new. The trick is packaging it all and providing an experience that is productive, fluent, and fun. The Slack team has done a great job creating a product that people can pick up easily, without giving up on advanced features for power users. The web and desktop apps are intuitive, practical, and clean, providing a smooth and easy experience.

Today I'm going to examine Slack's iOS app. It is a successful app that captures the great features described above. When I look at it however, it feels a little too 'simple', and lacks some traits that have proved to be useful in modern mobile apps. We'll look at different parts of the app, examine their function, and suggest alternative ways to achieve the same in a simpler and/or more intuitive fashion.

<div>
  <table class="table-figures">
    <tr>
      <td><figcaption>Fig 1.1 - <em>Before</em></figcaption></td>
      <td><figcaption>Fig 1.2 - <em>After</em></figcaption></td>
    </tr>
    <tr>
      <td>
        <img alt="Before" src="/assets/img/posts/Slack/slackMockup.gif">
      </td>
      <td>
        <img alt="After" src="/assets/img/posts/Slack/final.gif">
      </td>
    </tr>
  </table>
</div>

I've mocked up an iPhone app that mimics the original Slack app, and then made a bunch of modifications to try and improve certain components and design decisions. If I introduced something new, I tried to follow the original app's design patterns and color scheme. It's important to note that this is all done as an experiment and not the design nor the code are meant to be used elsewhere. Let's go over the changes one by one.

## The side menu

<div>
  <table class="table-figures">
    <tr>
      <td>
        <img alt="Slack's side menu" src="/assets/img/posts/Slack/slackSideMenu.png">
      </td>
    </tr>
    <tr>
      <td><figcaption>Fig 2 - The side menu</figcaption></td>
    </tr>
  </table>
</div>

Slack's navigation relies heavily on side menus. Side menus are ones that pop up on the side of the screen, but don't cover it all. We'll focus primarily on the left menu which gives access to Channels, Direct Messaging, and Private Groups. I can imagine Slack's team decided to go with side menus for multiple reasons; Side menus provide quick access, sort of a peek, to offscreen content. It simplifies the main screen by not requiring many controls. And it also follows the same methods of interaction with Slack's other platforms such as web and desktop.

Personally, I'm not a big fan of side menus, and in my opinion in this particular case it is not the best choice. The content this menu serves might be the most important after the conversation thread itself. The limited space restricts how many entries we can serve as the team grows and uses Slack more. In addition, the current design makes it difficult to distinguish between Channels, DM and Private Groups. In general, side menus on the 'small screen' are problematic:

* Expensive real estate - a large portion of the screen is taken by unusable content
* Limited functionality - we're restricted in the amount of content we can present and interact with
* Difficult to get right - designers tend to stick everything they can't find a place for in the side menu
* Not iOS native - what would Steve say?

### What can we do about it?

Messaging apps in general are tricky with the amount of options we can provide in the thread screen. The text box at the bottom follows the keyboard which makes it difficult to add functionality to it. Slack made this restriction even more profound when they made the thread screen the main screen of the app. This is different than most messaging apps that have some sort of a tab bar, and the conversation threads are actually leaf screens.

## Introducing the 'Tuck Menu'

<div>
  <table class="table-figures">
    <tr>
      <td>
        <img alt="After" src="/assets/img/posts/Slack/tuckMenu.gif">
      </td>
    </tr>
    <tr>
      <td><figcaption>Fig 3 - The Tuck Menu™</figcaption></td>
    </tr>
  </table>
</div>

The tuck menu hides at the bottom of the conversation thread, and is exposed using a gesture similar to the pull-to-refresh feature of many apps. It's simple to perform since it only requires one hand, and it's conveniently placed at a reachable spot, even on larger phones. In this context we expose buttons that take us straight to dedicated screens for each type of communication category: Channels, Direct Messages, Private Groups, or Search.

## Dedicated Category Screens

Now that we have a simple way to navigate, we're free to use a dedicated screen for each communication category. We can create more elaborate views that provide simpler interaction and additional useful information.

<div>
  <table class="table-figures">
    <tr>
      <td>
        <img alt="Dedicated Screen" src="/assets/img/posts/Slack/final.gif">
      </td>
      <td>
        <img alt="Screen's Anatomy" src="/assets/img/posts/Slack/dedicatedScreen.png">
      </td>
    </tr>
    <tr>
      <td><figcaption>Fig 4.1 - A Dedicated Category Screen</figcaption></td>
      <td><figcaption>Fig 4.2 - Screen's Anatomy</figcaption></td>
    </tr>
  </table>
</div>

## The Header

Moving on, let's examine the app's header.

<div>
  <table class="table-figures">
    <tr>
      <td>
        <img alt="Original App's Header" src="/assets/img/posts/Slack/oldHeaderMarkup.png">
      </td>
      <td>
        <img alt="Suggested App's Header" src="/assets/img/posts/Slack/newHeaderMarkup.png">
      </td>
    </tr>
    <tr>
      <td><figcaption>Fig 5.1 - Original App's Header</figcaption></td>
      <td><figcaption>Fig 5.2 - Suggested Header</figcaption></td>
    </tr>
  </table>
</div>

As I marked in figure 5.1, I identify a number of topics to discuss:

* Slack's hashtag logo is pretty cool. Its position in the header makes me think it's a logo. But in fact it serves also as a loading spinner, and as a button.
* The tiny arrow next to the channel's name reminds me of a dropdown menu, which makes me think I can switch channels by tapping it. In fact, it takes us to the channel's preferences page.
* Subjectively, I feel the overall aesthetic design of the header is inconsistent. It starts with a colorful bold graphic. Flows to bold text followed by a tiny icon. And ends with thin minimalistic icons.
* Nit pick: The list icon on the far right does a poor job indicating what's behind it.

To address these issues I suggest a slightly modified header. In figure 5.2, I replaced the hashtag logo with an icon that changes according to the type of conversation. I believe that helps the user find him/herself more easily. In addition, together with the channel's name, the icon acts as a button that is more attractive to tap on than the tiny arrow. Tapping it takes us to the channel's preferences page.

I've moved the channel selection hashtag button to the right, and gave it a light background to better indicate it is a button. Novice users who are yet to pick up using the tuck menu, or are at the top of the conversation thread, can use this instead.

And finally I've updated the list button with a new icon. This button opens the right side menu with some less frequent features. It exposes buttons such as 'Recent Mentions', 'Your Files', and 'Team Directory'. It's indeed difficult to try and capture all this functionality with a single icon. I quickly designed the icon you see as my gut tells me it's a bit more intuitive. Aesthetically it fits right in with the design of the new header.

<div>
  <table class="table-figures">
    <tr>
      <td>
        <img alt="Right Side Menu Icon" src="/assets/img/posts/Slack/rightSideMenuIcon.png">
      </td>
    </tr>
    <tr>
      <td><figcaption>Fig 6 - Suggested Right Side Menu Icon</figcaption></td>
    </tr>
  </table>
</div>

## Conclusion

Coming up with a great mobile user experience is not a simple task. It takes time, tests, and iterations to get it right. Slack is definitely a leader in bringing sophisticated technologies to users in a friendly way. That's the reason I decided to perform this experiment with their app. I hope I raised some interesting points.

Here's the final result again. There are many more details to explore, I'll save them for next time. I'd love to get your feedback to my email found on the about page. Or check out the code on my [GitHub repo](https://github.com/eithanshavit/SlackUX).

<div>
  <table class="table-figures">
    <tr>
      <td><figcaption>Fig 7 - <em>This is it</em></figcaption></td>
    </tr>
    <tr>
      <td>
        <img alt="Final Result" src="/assets/img/posts/Slack/final.gif">
      </td>
    </tr>
  </table>
</div>
