# Set 1 / Challenge 6 - Break repeating-key XOR

## It is officially on, now.

This challenge isn't conceptually hard, but it involves actual error-prone
coding. The other challenges in this set are there to bring you up to speed.
This one is there to **qualify** you. If you can do this one, you're probably
just fine up to Set 6.

[There's a file here](data/6.txt). It's been base64'd after being encrypted
with repeating-key XOR.

Decrypt it.

Here's how:

<ol>
  <li>
    Let KEYSIZE be the guessed length of the key; try values from 2 to (say) 40.
  </li>
  <li>
    Write a function to compute the edit distance/Hamming distance
    between two strings. <i>The Hamming distance is just the number of
    differing bits.</i> The distance between:
    <pre>this is a test</pre>
    and
    <pre>wokka wokka!!!</pre>
    is
    <b>37.</b>
    <i>Make sure your code agrees before you proceed.</i>
  </li>
  <li>
    For each KEYSIZE, take the <i>first</i> KEYSIZE worth of bytes, and the
    <i>second</i> KEYSIZE worth of bytes, and find the edit distance between
    them. Normalize this result by dividing by KEYSIZE.
  </li>
  <li>
    The KEYSIZE with the smallest normalized edit distance is probably
    the key. You could proceed perhaps with the smallest 2-3 KEYSIZE
    values. Or take 4 KEYSIZE blocks instead of 2 and average the
    distances.
  </li>
  <li>
    Now that you probably know the KEYSIZE: break the ciphertext into
    blocks of KEYSIZE length.
  </li>
  <li>
    Now transpose the blocks: make a block that is the first byte of
    every block, and a block that is the second byte of every block, and
    so on.
  </li>
  <li>
    Solve each block as if it was single-character XOR. You already
    have code to do this.
  </li>
  <li>
    For each block, the single-byte XOR key that produces the best
    looking histogram is the repeating-key XOR key byte for that
    block. Put them together and you have the key.
  </li>
</ol>

This code is going to turn out to be surprisingly useful later on. Breaking
repeating-key XOR ("Vigenere") statistically is obviously an academic exercise,
a "Crypto 101" thing. But more people "know how" to break it than can actually
break it, and a similar technique breaks something much more important.

## No, that's not a mistake.

We get more tech support questions for this challenge than any of the other
ones. We promise, there aren't any blatant errors in this text. In particular:
the "wokka wokka!!!" edit distance really is 37.

