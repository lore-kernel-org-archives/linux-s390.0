Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgKRPt7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Nov 2020 10:49:59 -0500
Date: Wed, 18 Nov 2020 10:49:44 -0500
From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
Message-ID: <20201118154944.GB545@redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117163147.GA27243@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, Nov 17 2020 at 11:31am -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, Nov 16 2020 at  6:00pm -0500,
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 11/15/20 11:30 PM, Christian Borntraeger wrote:
> > > 
> > > 
> > > On 13.11.20 23:52, Randy Dunlap wrote:
> > >> Building on arch/s390/ flags this as an error, so add the
> > >> __noreturn attribute modifier to prevent the build error.
> > >>
> > >> cc1: some warnings being treated as errors
> > >> ../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
> > >> ../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]
> > > 
> > > ok with me, but I am asking why
> > > 
> > > the unreachable macro is not good enough. For x86 it obviously is.
> > > 
> > > form arch/s390/include/asm/bug.h
> > > #define BUG() do {                                      \
> > >         __EMIT_BUG(0);                                  \
> > >         unreachable();                                  \
> > > } while (0)
> > > 
> > 
> > Hi Christian,
> > 
> > Good question.
> > I don't see any guidance about when to use one or the other etc.
> > 
> > I see __noreturn being used 109 times and unreachable();
> > being used 33 times, but only now that I look at them.
> > That had nothing to do with why I used __noreturn in the patch.
> 
> But doesn't that speak to the proper fix being needed in unreachable()?
> Or at a minimum the fix is needed to arch/s390/include/asm/bug.h's BUG.
> 
> I really don't think we should be papering over that by sprinkling
> __noreturn around the kernel's BUG() callers.
> 
> Maybe switch arch/s390/include/asm/bug.h's BUG to be like
> arch/mips/include/asm/bug.h?  It itself uses __noreturn with a 'static
> inline' function definition rather than #define.
> 
> Does that fix the issue?
> 
> Thanks,
> Mike
> 
> p.s. you modified dm-writecache.c (not dm-writeback, wich doesn't
> exist).

I don't think my suggestion will help.. given it'd still leave
persistent_memory_claim() without a return statement.

Think it worthwhile to just add a dummy 'return 0;' after the BUG().

Mike
