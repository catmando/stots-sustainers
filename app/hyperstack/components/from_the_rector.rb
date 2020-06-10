class FromTheRector < Markdown
MARKDOWN = <<MARKDOWN
<h1 align=center>Message From The Rector</h1>

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
