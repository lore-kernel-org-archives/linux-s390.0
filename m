Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37988 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729632AbgGHObC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 10:31:02 -0400
Received: by mail-qv1-f71.google.com with SMTP id j18so29431065qvk.1
        for <linux-s390@vger.kernel.org>; Wed, 08 Jul 2020 07:30:59 -0700 (PDT)
Date: Wed, 8 Jul 2020 10:30:54 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v5 18/25] mm/s390: Use general page fault accounting
Message-ID: <20200708143054.GB199122@xz-x1>
References: <20200707225021.200906-1-peterx@redhat.com>
 <20200707225021.200906-19-peterx@redhat.com>
 <20200708054947.GA4026@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200708054947.GA4026@oc3871087118.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, David Rientjes <rientjes@google.com>, John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, Jul 08, 2020 at 07:49:47AM +0200, Alexander Gordeev wrote:
> On Tue, Jul 07, 2020 at 06:50:14PM -0400, Peter Xu wrote:
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> > 
> > CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> > CC: Vasily Gorbik <gor@linux.ibm.com>
> > CC: Christian Borntraeger <borntraeger@de.ibm.com>
> > CC: linux-s390@vger.kernel.org
> > Reviewed-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/s390/mm/fault.c | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index fc14df0b4d6e..9aa201df2e94 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	 * make sure we exit gracefully rather than endlessly redo
> >  	 * the fault.
> >  	 */
> > -	fault = handle_mm_fault(vma, address, flags, NULL);
> > +	fault = handle_mm_fault(vma, address, flags, regs);
> >  	if (fault_signal_pending(fault, regs)) {
> >  		fault = VM_FAULT_SIGNAL;
> >  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> > @@ -488,21 +488,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> >  
> > -	/*
> > -	 * Major/minor page fault accounting is only done on the
> > -	 * initial attempt. If we go through a retry, it is extremely
> > -	 * likely that the page will be found in page cache at that point.
> > -	 */
> >  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> 
> Shouldn't this check ^^^ be dropped as well?
> 
> Since commit 4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times")
> FAULT_FLAG_ALLOW_RETRY never gets unset, so no need to check..

I agree, but it should be out of the scope of the accounting changes that this
patch wants to address.  Maybe more suitable for a work on top?

This should also exist for most of the archs too, and I'm also not sure whether
compiler could be smart enough to optimize this directly since it seems to have
all the knowledge.

Thanks,

-- 
Peter Xu
