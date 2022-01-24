This folder contains utilities to assist with the signup form.

Currently, this is just files to scrape the list of programs and majors for
autocomplete.

## Scrape programs and majors

1. Go to the undergraduate programs page: https://my.uq.edu.au/programs-courses/browse.html?level=ugpg.
2. Execute the scrape.js script in the browser console and paste the result into ugpg.json.
3. Repeat 1 and 2 with the postgraduate programs and pasting into pgpg.json from https://my.uq.edu.au/programs-courses/browse.html?level=pgpg.
4. Manually enter the research programs from https://future-students.uq.edu.au/study/programs?level[Research]=Research&year=2022 into format.py.
5. Execute format.py which will generate programs.json and programs_with_majors.json.
6. Copy programs_with_majors.json into /uqcs/static and commit the changes.
