# nanoc demo site

This is a demo site built using the [nanoc framework](http://nanoc.stoneship.org/) and the [kramdown](http://kramdown.rubyforge.org/index.html) extended markdown library.

## Folder structure and organisation

* Nanoc takes the content from the `/content` folder and uses it
  to build a site in the `/output` folder.

### Content

* Inside the `/content` folder is the `/contents` folder. This folder
  (`/content/contents/`) contains the chapter structure of the book part
  of the website.
* The other folders/pages (`/content/about/`, `/content/contact/` etc)
  are used by the site.

### SCSS/CSS

* Compass/SASS is used to build the CSS for the site.
* The scss files live in `/content/scss`
* nanoc compiles the scss to css (`/output/css`)

### Media

* All media is stored locally in `/content/_media/`
* The `_media` folder (in both `/content` and `/output`) will NOT get
  stored in git
* There is a rake task that uploads new media from the _media folder to
  Amazon S3 and converts the paths (in the content) so that they point
  to the Amazon hosted files
* There is also a rake task that can get media from Amazon S3 that you
  don't have locally

### Other static files (js and layout images)

* files in `/js` and `/img` are routed through from the `/content/` folder
  to the `/output/` folder without compiling.

### Config files

* `/config.rb` is the config file for Compass (scss)
* `/config.yaml` is the config file for nanoc
* `Rules` is the set of rules that nanoc uses to build the site. For each file type
  it sets up a compile rule and route rule.

## Content conventions

* All content pages have a title in their meta data
* This title attribute is used to render a heading 1 (or chapter/section
  heading in PDF).
* Any headings in the content of a page should start from h2

### Website pages

* If a page in the website appears in the menu for the website, the attribute
  of "menuTitle" is used in the menu.

### Book pages

* As well as a title attribute, book pages also need a date, type (set to
  article) and order attribute.
* The date and type attributes are set automatically if you use `rake create_book_page`
  to create the page.
* The order attribute is used to determine the order of the pages at a given
  level (for the table of contents etc).
* The level of the pages (for table of contents etc) is determined by the
  folder structure.
* A content file with the file name of `index.md` will represent the level of the folder
  itself. Other file names within the folder will be represented as a level down from
  the folder.

## Rake tasks

`rake compile`

This will compile the site (equivalent to `nanoc compile`), upload any new assets from /content/_media
to Amazon S3, download any new or changed assets from Amazon S3 (ready for PDF) and then create a PDF
version of the site.

`rake upload_assets`

This will put any new or changed assets up on Amazon S3.

`rake download_assets`

This will fetch new or changed assets from Amazon S3. `rake download_assets content` downloads to the
`\content\_media\` folder. `rake download_assets pdf` downloads to `\output\pdf\` in preparation for the
pdf creation (this is the default behaviour).

`rake create_pdf`

This creates a PDF from the .tex file that's created by the `nanoc compile`. This command must be run from
the root of the project.

`upload_site_s3`

This uploads the entire static site to Amazon S3.

`create_book_page title="New Page" path="contents/foldername/filename"`

This will create a new content file with the meta data (attributes) set and ready to go.

