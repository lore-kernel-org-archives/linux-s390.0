Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgH1PBZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 28 Aug 2020 11:01:25 -0400
Date: Fri, 28 Aug 2020 17:01:03 +0200
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828170103.6d954d95@thinkpad>
In-Reply-To: <20200828142137.GX24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
        <20200828142137.GX24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 28 Aug 2020 11:21:37 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Aug 28, 2020 at 04:03:12PM +0200, Gerald Schaefer wrote:
> > Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> > code") introduced a subtle but severe bug on s390 with gup_fast, due to
> > dynamic page table folding.
> 
> I think the page walk code in mm/pagewalk.c has similar issues to
> GUP. I've been noodling on some patches to add the missing stack
> copies to pagewalk.c as they are clearly missing..
> 
> It would be good if this could be less GUP specific?
> 
> Generically this is about walking the page table without holding the
> page table spinlocks using READ_ONCE.

Indeed, if there were other code paths doing that, they would most
likely also be broken (at least) for s390. Alexander was already
looking into generalizing the new gup-specific helpers, but so
far we assumed that would only be "nice to have" for the future,
and not fix any real issues at the moment. So we wanted to
focus on first fixing the very real gup_fast issue.

Both approaches here probably could be generalized, by either
changing pXd_address_end() or pXd_offset(), but I guess it makes
sense to already take into account that we might need such
generalization sooner than expected.

Just to make sure, you are referring to some future / planned
changes to mm/pagewalk.c, and not some currently existing
pagetable walkers already using the READ_ONCE logic w/o
spinlocks? If those would exist already, I guess we would
already have issues on s390, independent from our conversion
to common code gup_fast.

Regards,
Gerald
