class FromTheRector < Markdown
MARKDOWN = <<MARKDOWN
<h1 align=center>Message From The Rector</h1>

The reality that seminary training is necessary for future priests is clearly articulated by St. Gregory the Theologian:  “One must be purified before purifying others, be instructed before instructing, become light in order to enlighten, draw near to God before approaching others, be sanctified in order to sanctify” (Oration 2,71). Such training is equally necessary beyond ordination, as the great Father again affirms, telling us that the growth of the shepherd never stops – even after his initial training he is to grow steadily and continually, like “the common sailor grows to be the helmsman,” or like “the brave soldier grows to be the general.”

These future shepherds are not driven by their own accord, but chosen by the will of God.  The Gospel of John records Our Lord saying to His Church’s future pastors, “Ye have not chosen Me, but I have chosen you, and ordained you, that ye should go and bear fruit” (John 15:16).  This means we must teach future priests to speak Christ’s words – the words of His Church, not their words.  They must proclaim His Gospel – the Gospel of His Church – not their own.  They must be taught to accept, not speculate; preserve, not innovate; defend, not attack; uphold, not tear down our Tradition which is “the life of the Holy Spirit in the Church,” in the words of Vladimir Lossky.

This means that they must have the ethos, the phronema of the Church.  They must understand that they have been chosen and ordained to be part of the continuum of truth-bearers that spans the history of Christ’s Church.  They must be one with the Holy Fathers of the Faith – “the Faith which was once delivered unto the saints” (Jude 3) – so that the Church will have but a single voice amid today’s cacophonies.

Finally, our graduates must know how to love their people.  The New Testament tells us this is what the Christian life is all about:  “God is Love”, writes St. John.  “A new commandment I give to you; that you love one another as I have loved you,” Jesus teaches.  “Love your enemies” is perhaps the greatest challenge of all to come from Our Lord’s lips.  If Christ so commands all His followers, should not our parishioners expect their priests to be a loving spiritual father?

Priests have often complained that their parishes treat them as employees.  Sometimes, in retaliation, they try to become “the boss.”  I believe the solution is for priests to be what Christ taught Andrew and Peter and James and John so long ago – to be a loving spiritual father to His flock.  This will not guarantee that people will never disagree with them; however, it will ensure that what Christ taught, and what people need, will come to pass in His Church in 21st century America.  Truly there is so much to accomplish in three years of seminary!

On behalf of the faculty, administration, staff, students and the whole community of St. Tikhon’s Seminary, I encourage you to “come and see” this holy place – whether as a pilgrim or a prospective student – and experience the grace of God that permeates these hallowed grounds, where Saints have lived and walked, and prayed and taught.

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
