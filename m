Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406029AbgFXStn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 14:49:43 -0400
Date: Wed, 24 Jun 2020 20:49:30 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 18/26] mm/s390: Use general page fault accounting
Message-ID: <20200624204930.2445bcd6@thinkpad>
In-Reply-To: <20200619161335.9664-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
        <20200619161335.9664-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Fri, 19 Jun 2020 12:13:35 -0400
Peter Xu <peterx@redhat.com> wrote:

> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
> 
> CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> CC: Vasily Gorbik <gor@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> CC: linux-s390@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/s390/mm/fault.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index ab6d7eedcfab..4d62ca7d3e09 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	 * make sure we exit gracefully rather than endlessly redo
>  	 * the fault.
>  	 */
> -	fault = handle_mm_fault(vma, address, flags, NULL);
> +	fault = handle_mm_fault(vma, address, flags, regs);
>  	if (fault_signal_pending(fault, regs)) {
>  		fault = VM_FAULT_SIGNAL;
>  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>  	if (unlikely(fault & VM_FAULT_ERROR))
>  		goto out_up;

There are two cases here where we skipped the accounting,
fault_signal_pending() and VM_FAULT_ERROR, similar to other archs.

fault_signal_pending() should be ok, because that only seems to be true
for fault & VM_FAULT_RETRY, in which case the new approach also skips
the accounting.

But for VM_FAULT_ERROR, the new approach would do accounting, IIUC. Is
that changed on purpose? See also my reply on [PATCH 01/26].

Regards,
Gerald
