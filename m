Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgFXUkx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 16:40:53 -0400
Received: by mail-qk1-f199.google.com with SMTP id h18so2500967qkj.13
        for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2020 13:40:50 -0700 (PDT)
Date: Wed, 24 Jun 2020 16:40:47 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 18/26] mm/s390: Use general page fault accounting
Message-ID: <20200624204047.GC64004@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619161335.9664-1-peterx@redhat.com>
 <20200624204930.2445bcd6@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624204930.2445bcd6@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Wed, Jun 24, 2020 at 08:49:30PM +0200, Gerald Schaefer wrote:
> On Fri, 19 Jun 2020 12:13:35 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> > 
> > CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> > CC: Vasily Gorbik <gor@linux.ibm.com>
> > CC: Christian Borntraeger <borntraeger@de.ibm.com>
> > CC: linux-s390@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/s390/mm/fault.c | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index ab6d7eedcfab..4d62ca7d3e09 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	 * make sure we exit gracefully rather than endlessly redo
> >  	 * the fault.
> >  	 */
> > -	fault = handle_mm_fault(vma, address, flags, NULL);
> > +	fault = handle_mm_fault(vma, address, flags, regs);
> >  	if (fault_signal_pending(fault, regs)) {
> >  		fault = VM_FAULT_SIGNAL;
> >  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> > @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> 
> There are two cases here where we skipped the accounting,
> fault_signal_pending() and VM_FAULT_ERROR, similar to other archs.
> 
> fault_signal_pending() should be ok, because that only seems to be true
> for fault & VM_FAULT_RETRY, in which case the new approach also skips
> the accounting.

IMHO it's still possible to have fault_signal_pending() return true even if the
fault is not with VM_FAULT_RETRY, e.g., when the signal is delivered right
after the fault is correctly handled for the thread.  However I hope we can
avoid considering that too even if so...

> 
> But for VM_FAULT_ERROR, the new approach would do accounting, IIUC. Is
> that changed on purpose? See also my reply on [PATCH 01/26].

(replied in the other thread)

Thanks,

-- 
Peter Xu
