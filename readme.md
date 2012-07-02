Omnigrok
====
[Omnigrok](http://github.com/gmccreight/omnigrok) is an open source polyglot algorithm and data structure learning platform.  If you're impatient, check out [omnigrok.com](http://omnigrok.com), then come back here to read all about it.

Omnigrok aims to have thousands of fully-worked, tested, and immediately runnable examples of algorithms and data structures in an exhaustive variety of languages.  It also aims to be ridiculously, even magically, easy to use in a classroom setting.  In short, it aims to be the first place developers think to go to learn a new language, algorithm, or data structure.

You can currently try data structures and algorithms in the following languages:

* C
* C++
* Clojure
* Coffeescript
* Haskell
* Javascript
* Python
* Ruby

We also have unfinished (but executable) code examples in:

* Lua
* Objective-C
* Go
* Scala

Usage
---

Omnigrok can be used in several ways, which are outlined here.  We describe each usage in more detail later in the readme.

* Standard Usage
    * Hosted:
        * The website, [omnigrok.com](http://omnigrok.com), provides a try-in-the-browser interface.
        * [omnigrok.com](http://omnigrok.com) can also be SSH'd to with credentials available on the website
        * The one-click script to create the hosted version is included in Omnigrok's source code.
    * Downloadable Virtual Machine:
        * downloadable Vagrant boxes for all tagged releases (available on S3 and bittorrent) allow you to run Omnigrok in a specially configured Ubuntu 12.04 Server on your local machine.
        * The one-click script to create the Vagrant boxes (and even the basebox from the Ubuntu 12.04 .iso) is included in Omnigrok's source code.
* Contributor Usage
    * Install script that you can run on your own Ubuntu server:
        * The source code contains an install script that works on Ubuntu 12.04 Server.

Rationale
---

Stack Overflow and Rosetta Code, for all their greatness, provide code snippets without context.  Often those snippets require a particular version of an interpreter and various tough-to-satisfy prerequisites.  Even if your setup is perfect, the code often contains small typos and logical errors that cause bugs because the code isn't automatically tested.  People who are learning a new language are the least well equipped to handle these often obtuse errors.


Contributing
---

Omnigrok aims to be ridiculously easy to contribute to.  It relies very heavily on modularity and conventions.  If you follow the conventions your code and its unit tests will just work.

Challenges
---
TODO
