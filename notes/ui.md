# UI Considerations

Some UI Starting points:

- [Microsoft Guidelines](https://developer.microsoft.com/en-us/windows/apps/design)
- [macOS Guidelines](https://developer.apple.com/design/human-interface-guidelines/macos/overview/themes/)
- [Wikipedia - User Interface #Interface_design](https://en.wikipedia.org/wiki/User_interface#Interface_design)
- [Wikipedia - User Experience Design](User experience design)
- [UX Glossary](https://uxplanet.org/ux-glossary-task-flows-user-flows-flowcharts-and-some-new-ish-stuff-2321044d837d)

## Preliminary considerations

Text analysis, like all data analysis, is a non-linear flow. The question becomes, how to embody that flow in a ui? Examples of proposed data analysis flows include:

![](./img/ppdac.PNG)

![](./img/data-science-explore.png)

A stackexchange [answer](https://ux.stackexchange.com/questions/49765/how-to-create-a-non-linear-wizard) has some insights; I particularly like the notion of maintaining a summary, and clear directions.

skeuomorphism](https://en.wikipedia.org/wiki/Skeuomorph) vs [flat design](https://en.wikipedia.org/wiki/Flat_design)

From Wikipedia:

> All great interfaces share eight qualities or characteristics:
> 1. **Clarity** The interface avoids ambiguity by making everything clear through language, flow, hierarchy and metaphors for visual elements.
> 2. **Concision**[[14\]](https://en.wikipedia.org/wiki/User_interface#cite_note-artofunix-14)  It's easy to make the interface clear by over-clarifying and labeling  everything, but this leads to interface bloat, where there is just too  much stuff on the screen at the same time. If too many things are on the  screen, finding what you're looking for is difficult, and so the  interface becomes tedious to use. The real challenge in making a great  interface is to make it concise and clear at the same time.
> 3. **Familiarity**[[15\]](https://en.wikipedia.org/wiki/User_interface#cite_note-15)  Even if someone uses an interface for the first time, certain elements  can still be familiar. Real-life metaphors can be used to communicate  meaning.
> 4. **Responsiveness**[[16\]](https://en.wikipedia.org/wiki/User_interface#cite_note-16)  A good interface should not feel sluggish. This means that the  interface should provide good feedback to the user about what's  happening and whether the user's input is being successfully processed.
> 5. **Consistency**[[17\]](https://en.wikipedia.org/wiki/User_interface#cite_note-17) Keeping your interface consistent across your application is important because it allows users to recognize usage patterns.
> 6. **Aesthetics**  While you don't need to make an interface attractive for it to do its  job, making something look good will make the time your users spend  using your application more enjoyable; and happier users can only be a  good thing.
> 7. **Efficiency** Time is money, and a great interface should make the user more productive through shortcuts and good design.
> 8. **Forgiveness** A good interface should not punish users for their mistakes but should instead provide the means to remedy them.

In light of the above, I think Cassidy was on the right track with her [program](https://usresp-student.shinyapps.io/text_analysis/) explaining and hand-holding along the process. I think iNZight may have too much tucked away in the top toolbar, and having it clear and easily accessible will greatly improve ease of access. A [template](https://en.wikipedia.org/wiki/File:Mobile_sketch_template.pdf):

![](img/page1-640px-Mobile_sketch_template.pdf.jpg)

Hierarchical methods and tools within each part of the process is somewhat restrictive, especially for a nonlinear workflow.

Browser-based app preferred, far more extensible (see if electron can port shiny apps to desktop, or if they can inherently) - this app is so seperate from iNZight, it should likely be launched as a utility from the "iNZight suite" 

