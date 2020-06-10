class WhySupport < Markdown
MARKDOWN = <<MARKDOWN
<h1 align=center>Why Support St. Tikhon's Seminary</h1>

The Apostle Paul said:

*How then will they call on Him in whom they have not believed?
And how are they to believe in Him of whom they have never heard?
And how are they to hear without someone preaching?*

And to Timothy he also said:

*Be a good worker, one who does not need to be ashamed and who correctly explains the word of truth.*

And James tell us:

*My brethren, let not many of you become teachers, knowing that we shall receive a stricter judgment.*

We see in these words, that we come to the knowledge of God through the word of others.  Ours is a faith
of interpersonal relationships and of people working together seeking God in the fullness of truth.

But we also see that this word must be correctly explained, it cannot be handled lightly.  God's word is
medicine and like any doctor the medicine must be applied carefully at the right time and the right amount.

And finally we see that those who are chosen to teach and lead us will be judged strictly.

To become a priest is a very high calling.  It is not easy, it takes time, and it takes effort. It also requires
teachers to raise our new leaders up.  It requires being immersed in a daily liturgical life in which the student can be
filled not just mental learning but by the heart learning that comes through the sacraments.

This is the environment that is provided at St. Tikhon's, but this does not come cheaply.  Not only is there the
sacrifice in terms of time and commitment, there is also the basic cost of running this Holy institution.

Not many realize that it costs an average of $150,000 to educate a new priest.  That may seem like a lot, but what
do these men accomplish?

+ They raise up new churches all across the country;
+ They baptize our children and grand children;
+ They will be there to annoint us when we are sick;
+ They will be there to hear our confession us when we have fallen;
+ They will bring us new insights into how to live a life pleasing to God;
+ They will pray with us at the end and
+ They will pray for us when we depart this life.

By becoming a sustaining member of the St. Tikhon's family you insure the future of your family, your parish, and the Orthodox Church in our great nation.


MARKDOWN

  render do
    DIV(styles(:container), class: :page) do
      papers
    end
  end
end
