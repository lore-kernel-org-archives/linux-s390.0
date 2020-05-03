Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgECQpm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 3 May 2020 12:45:42 -0400
Date: Sun, 3 May 2020 09:45:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/7] sha1 library cleanup
Message-ID: <20200503164539.GA938@sol.localdomain>
References: <20200502182427.104383-1-ebiggers@kernel.org>
 <CAHmME9oPqWfTwTtawM-29Lqck-N-kYo4nGr1-4hCW975DhB0Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9oPqWfTwTtawM-29Lqck-N-kYo4nGr1-4hCW975DhB0Uw@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Paolo Abeni <pabeni@redhat.com>, mptcp@lists.01.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org

On Sat, May 02, 2020 at 03:05:46PM -0600, Jason A. Donenfeld wrote:
> Thanks for this series. I like the general idea. I think it might make
> sense, though, to separate things out into sha1.h and sha256.h. That
> will be nice preparation work for when we eventually move obsolete
> primitives into some <crypto/dangerous/> subdirectory.

That's basically what I suggested in the cover letter:

"As future work, we should split sha.h into sha1.h and sha2.h and try to
remove the remaining uses of SHA-1.  For example, the remaining use in
drivers/char/random.c is probably one that can be gotten rid of."

("sha2.h" rather than "sha256.h", since it would include SHA-512 too.
Also, we already have sha3.h, so having sha{1,2,3}.h would be logical.)

But there are 108 files that include <crypto/sha.h>, all of which would need to
be updated, which risks merge conflicts.  So this series seemed like a good
stopping point to get these initial changes in for 5.8.  Then in the next
release we can split up sha.h (and debate whether sha1.h should really be
"<crypto/dangerous/sha1.h>" or whatever).

There are 3 files where I added an include of sha.h, where we could go directly
to sha1.h if we did it now.  But that's not much compared to the 108 files.

- Eric
