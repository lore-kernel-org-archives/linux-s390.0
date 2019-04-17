Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Linux 5.1-rc5
In-Reply-To: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
 <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
Date: Wed, 17 Apr 2019 13:38:33 +1000
Message-ID: <87sguhti6e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

[ Cc += Nick & Aneesh & Paul ]

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> Can we please have the page refcount overflow fixes out on the list
>> for review, even if it is after the fact?
>
> They were actually on a list for review long before the fact, but it
> was the security mailing list. The issue actually got discussed back
> in January along with early versions of the patches, but then we
> dropped the ball because it just wasn't on anybody's radar and it got
> resurrected late March. Willy wrote a rather bigger patch-series, and
> review of that is what then resulted in those commits. So they may
> look recent, but that's just because the original patches got
> seriously edited down and rewritten.
>
> That said, powerpc and s390 should at least look at maybe adding a
> check for the page ref in their gup paths too. Powerpc has the special
> gup_hugepte() case

Which uses page_cache_add_speculative(), which handles the case of the
refcount being zero but not overflow. So that looks like it needs
fixing.

We also have follow_huge_pd() that should use try_get_page().

And we have a few uses of bare get_page() in KVM code which might be
subject to the same attack.

cheers
