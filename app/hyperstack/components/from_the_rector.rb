class FromTheRector < Markdown
MARKDOWN = <<MARKDOWN
<h1 align=center>Message From The Rector</h1>

The reality that seminary training is necessary for future priests is clearly articulated by St. Gregory the Theologian:  “One must be purified before purifying others, be instructed before instructing, become light in order to enlighten, draw near to God before approaching others, be sanctified in order to sanctify” (Oration 2,71). Such training is equally necessary beyond ordination, as the great Father again affirms, telling us that the growth of the shepherd never stops – even after his initial training he is to grow steadily and continually, like “the common sailor grows to be the helmsman,” or like “the brave soldier grows to be the general.”

These future shepherds are not driven by their own accord, but chosen by the will of God.  The Gospel of John records Our Lord saying to His Church’s future pastors, “Ye have not chosen Me, but I have chosen you, and ordained you, that ye should go and bear fruit” (John 15:16).  This means we must teach future priests to speak Christ’s words – the words of His Church, not their words.  They must proclaim His Gospel – the Gospel of His Church – not their own.  They must be taught to accept, not speculate; preserve, not innovate; defend, not attack; uphold, not tear down our Tradition which is “the life of the Holy Spirit in the Church,” in the words of Vladimir Lossky.

This means that they must have the ethos, the phronema of the Church.  They must understand that they have been chosen and ordained to be part of the continuum of truth-bearers that spans the history of Christ’s Church.  They must be one with the Holy Fathers of the Faith – “the Faith which was once delivered unto the saints” (Jude 3) – so that the Church will have but a single voice amid today’s cacophonies.

Finally, our graduates learn how to love their people.  The New Testament tells us this is what the Christian life is all about:  “God is Love”, writes St. John.  “A new commandment I give to you; that you love one another as I have loved you,” Jesus teaches.  “Love your enemies” is perhaps the greatest challenge of all to come from Our Lord’s lips.  If Christ so commands all His followers, should not our parishioners expect their priests to be a loving spiritual father?

Our Seminary’s task is to spiritually form and theologically educate our future clergy in our three-year M.Div. program.
We are asking you to consider becoming a “Sustainer of Saint Tikhon’s Seminary” by making a pledge of monthly assistance
to help fund this sacred work.

Your gift will make possible a brighter future for our Church by your support of vocations to the Holy Priesthood –
one of whom one day might become your new pastor!

We ask you to listen carefully to the teaching of Our Lord in the Gospel and follow His command:

> **Do not lay up for yourselves treasures on earth, where moth and rust destroy and where thieves break in and steal; but lay up for yourselves treasures in Heaven, where neither moth nor rust destroy and where thieves do not break in and steal” (Matthew 6:19-20).**

While your dividends for this investment will not be in dollars and cents they will instead be in this form:

You will have a spiritual son you have helped, praying for you always in return for your great generosity to him, now in his daily prayers, and in the future when he serves at the Altar as a priest!

As our gracious God has blessed you, please consider sharing your blessings for the building up of Christ’s Holy Church and for the extension of His Heavenly Kingdom on earth.

You will be demonstrating your faith and love in action, and Our Lord will surely reward you for it with His grace and bounties and love for mankind.

With love in Christ,</br>
**+Archbishop Michael**</br>
**Rector**
MARKDOWN

  render do
    DIV(styles(:container), class: :page) do
      papers
    end
  end
end
