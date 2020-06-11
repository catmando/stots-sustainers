Campaign.create(
  slug: 'vanduyns', name: "Mitch and Jan's Virtual Wine and Cheese Tasting Party", goal: 6000,
  sustainer_form_id: "fdaedf72-75c2-4d1d-9e1b-8ae01262d7fd",
  one_time_form_id: "67958a94-b717-4616-b1dc-d1a5bb838ca2",
  greeting: <<MARKDOWN
Welcome to Mitch and Jan's Virtual Wine and Cheese Tasting Party!

Let us know the cost of your refreshments, and we will donate a matching amount to our beloved parish of St. John the Baptist.

Then please enjoy our guest presentations and each other's company. And prayerfully consider a sustaining monthly gift to St. Tikhon’s Seminary.

Our goal for St. Tikhon's is $6,000 annually in new sustaining gifts.

Please give now, and give generously!
MARKDOWN
)

Campaign.create(
  slug: 'htoc-randolph', name: 'Holy Trinity Virtual Wine Tasting', goal: 12_000,
  sustainer_form_id: "0ccf9568-e8c2-46a8-9952-92431623e5b2",
  one_time_form_id: "233bf852-a5a4-49fb-9e13-e8b82ccc01fd",
  greeting: <<MARKDOWN
Welcome to the Holy Trinity Orthodox Church Virtual Wine Tasting fundraiser.

Please consider a sustaining monthly gift to St. Tikhon’s Seminary.

Our goal is $1,000 monthly *or $12,000 annually* in new sustaining gifts.

Please give now, and give generously!
MARKDOWN
)
Campaign.create(slug: 'herzak', name: 'Micky Herzak', goal: 15000, greeting: <<MARKDOWN
Welcome to the Herzak's Virtual Wine Tasting fundraiser.

Please consider a sustaining monthly gift to St. Tikhon’s Seminary.

If you give before June 30th you will be sent a fine bottle of wine which we will taste together at
an online virtual tasting on July 15th.

Our goal is to raise $15,000 annually in new sustaining gifts, so please give generously

MARKDOWN
)
Campaign.create(
  slug: 'bot', name: 'Board of Trustees', goal: 12000,
  sustainer_form_id: "498b0382-2043-41a3-9d49-924622f40ba4",
  one_time_form_id: "ead51868-d729-468c-acf4-1f5fd4c74714",
  greeting: <<MARKDOWN
Welcome to the STOTS Board Meeting. Please consider a sustaining monthly gift.

Our goal for the meeting is $12,000 annually in new sustaining gifts.

Please give now, and give generously!
MARKDOWN
)
Campaign.create(
  slug: 'stots', name: 'Not Attending Any Event', goal: 600_000,
  sustainer_form_id: "b6fcffc0-d7f9-4ca9-893b-ba65cd22f09e",
  one_time_form_id: "d99c0b9f-4b0c-4e2a-a8ad-89b5e5aadad8",
  greeting: <<MARKDOWN
Thank you for considering a gift to St. Tikhon's.

To find out more about the work at St. Tikhon's check out the menu in the
top left corner of this app, or visit St. Tikhon's website at www.stots.edu.
MARKDOWN
)
