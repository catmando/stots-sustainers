class Mission < Markdown
MARKDOWN = <<MARKDOWN
<h1 align=center>Mission</h1>

St. Tikhon’s Orthodox Theological Seminary is an institution of professional Orthodox Christian theological education,

+ chartered by the Department of Education of the Commonwealth of Pennsylvania and
+ affiliated with the Orthodox Church in America.

In a rural environment conducive to spiritual growth and academic study, the Seminary nurtures the theological vocations
of its students and faculty, who share the unique opportunity of learning and teaching Orthodox theology in the framework
of their daily experience of a rich heritage of Russian Orthodox spiritual and liturgical tradition.

The primary mission of the Seminary lies in providing the necessary theological, liturgical, spiritual and moral foundations
for Orthodox men to become, as God so wills, good shepherds of His Holy Orthodox Church.

At the same time, however, the Seminary also recognizes that many individuals choose to enroll in a professional theological
training program for the fulfillment of needs other than those of ordained ministry. Among these are:
+ preparation for general religious leadership responsibilities in parishes and other settings;
+ advanced theological study;
+ specialized ministry as religious educators or choir directors;
+ personal spiritual enrichment.

Therefore, St. Tikhon’s Seminary continues to support all honorable reasons for matriculation at the Seminary and participation in class.
MARKDOWN

  render do
    DIV(styles(:container), class: :page) do
      papers
    end
  end
end
