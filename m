Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
Date: Tue, 16 Apr 2019 11:09:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190416110906.6c773aff@mschwideX1>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Apr 2019 09:17:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Can we please have the page refcount overflow fixes out on the list
> > for review, even if it is after the fact?  
> 
> They were actually on a list for review long before the fact, but it
> was the security mailing list. The issue actually got discussed back
> in January along with early versions of the patches, but then we
> dropped the ball because it just wasn't on anybody's radar and it got
> resurrected late March. Willy wrote a rather bigger patch-series, and
> review of that is what then resulted in those commits. So they may
> look recent, but that's just because the original patches got
> seriously edited down and rewritten.

First time I hear about this, thanks for the heads up.
 
> That said, powerpc and s390 should at least look at maybe adding a
> check for the page ref in their gup paths too. Powerpc has the special
> gup_hugepte() case, and s390 has its own version of gup entirely. I
> was actually hoping the s390 guys would look at using the generic gup
> code.

We did look at converting the s390 gup code to CONFIG_HAVE_GENERIC_GUP,
there are some details that need careful consideration. The top one
is access_ok(), for s390 we always return true. The generic gup code
relies on the fact that a page table walk with a specific address is
doable if access_ok() returned true, the s390 specific check is slightly
different:

        if ((end <= start) || (end > mm->context.asce_limit))
                return 0;

The obvious approach would be to modify access_ok() to check against
the asce_limit. I will try and see if anything breaks, e.g. the automatic
page table upgrade.

> I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
> largely irrelevant, partly since even theoretically this whole issue
> needs a _lot_ of memory.
> 
> Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
> (page ref overflow)"). You may or may not really care.

On s390 we can have up to 16TB of memory in a single LPAR. So yes, I do
care about it.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
