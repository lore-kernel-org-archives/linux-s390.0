Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
In-Reply-To: <20190415051919.GA31481@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2019 09:17:10 -0700
Message-ID: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Can we please have the page refcount overflow fixes out on the list
> for review, even if it is after the fact?

They were actually on a list for review long before the fact, but it
was the security mailing list. The issue actually got discussed back
in January along with early versions of the patches, but then we
dropped the ball because it just wasn't on anybody's radar and it got
resurrected late March. Willy wrote a rather bigger patch-series, and
review of that is what then resulted in those commits. So they may
look recent, but that's just because the original patches got
seriously edited down and rewritten.

That said, powerpc and s390 should at least look at maybe adding a
check for the page ref in their gup paths too. Powerpc has the special
gup_hugepte() case, and s390 has its own version of gup entirely. I
was actually hoping the s390 guys would look at using the generic gup
code.

I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
largely irrelevant, partly since even theoretically this whole issue
needs a _lot_ of memory.

Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
(page ref overflow)"). You may or may not really care.

                 Linus
