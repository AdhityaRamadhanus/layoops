# layoops
    interactive cli to query covid-19 layoffs data https://drive.google.com/open?id=1U13Ef3EnJnMzuElElAJPbWiNBKutQuB7ldQED4C8L_Y

<p>
  <a href="#Usage">Usage |</a>
  <a href="#Todo">Todo |</a>
  <a href="#licenses">License</a>
  <br><br>
  <blockquote>
    How it works:
        layoops will fetch excel from the link above and transform the employee table to sqlite table record and save it.
        User can then query the data using prompt provided by layoops

  </blockquote>
</p>

Usage
-----
* git clone
* bundle install
* ./bin/layoffs i

![Screenshot from 2020-04-11 12-36-22](https://user-images.githubusercontent.com/5761975/79036308-3bde9880-7bf1-11ea-879f-67084a0c41a4.png)

Todo
----
* Use activerecord-import
* Log
* Format Output

License
----

MIT © [Adhitya Ramadhanus]
