Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgKTOIr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 09:08:47 -0500
Date: Fri, 20 Nov 2020 09:08:20 -0500
From: Mike Snitzer <snitzer@redhat.com>
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
Message-ID: <20201120140819.GA7359@redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com>
 <20201118154944.GB545@redhat.com>
 <20201118160748.GA754@redhat.com>
 <alpine.LRH.2.02.2011181611470.16933@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2011181611470.16933@file01.intranet.prod.int.rdu2.redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

On Wed, Nov 18 2020 at  4:24pm -0500,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> 
> 
> On Wed, 18 Nov 2020, Mike Snitzer wrote:
> 
> > On Wed, Nov 18 2020 at 10:49am -0500,
> > Mike Snitzer <snitzer@redhat.com> wrote:
> > 
> > > I don't think my suggestion will help.. given it'd still leave
> > > persistent_memory_claim() without a return statement.
> > > 
> > > Think it worthwhile to just add a dummy 'return 0;' after the BUG().
> > 
> > Decided to go with this, now staged for 5.11:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1
> 
> Hi
> 
> I would just use "return -EOPNOTSUPP;" and drop the "#ifdef 
> DM_WRITECACHE_HAS_PMEM" that you added.
> 
> That BUG/return -EOPNOTSUPP code can't happen at all - if 
> DM_WRITECACHE_HAS_PMEM is not defined, WC_MODE_PMEM(wc) always returns 
> false - so persistent_memory_claim and BUG() can't ever be called. And if 
> it can't be called, you don't need to add a code that prints an error in 
> that case.
> 
> If we don't have DM_WRITECACHE_HAS_PMEM, the compiler optimizer will 
> remove all the code guarded with if (WC_MODE_PMEM(wc)) as unreachable.
> 
> Mikulas

Fair enough.
