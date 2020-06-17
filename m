Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41810 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726496AbgFQQGY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Jun 2020 12:06:24 -0400
Received: by mail-qv1-f70.google.com with SMTP id p18so1936623qvy.11
        for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2020 09:06:21 -0700 (PDT)
Date: Wed, 17 Jun 2020 12:06:17 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200617160617.GD76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
 <20200616163510.GD11838@xz-x1>
 <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-kernel@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org

Hi, Christian,

On Wed, Jun 17, 2020 at 08:19:29AM +0200, Christian Borntraeger wrote:
> 
> 
> On 16.06.20 18:35, Peter Xu wrote:
> > Hi, Alexander,
> > 
> > On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> >>> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >>>  	if (unlikely(fault & VM_FAULT_ERROR))
> >>>  		goto out_up;
> >>>
> >>> -	/*
> >>> -	 * Major/minor page fault accounting is only done on the
> >>> -	 * initial attempt. If we go through a retry, it is extremely
> >>> -	 * likely that the page will be found in page cache at that point.
> >>> -	 */
> >>>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> >>> -		if (fault & VM_FAULT_MAJOR) {
> >>> -			tsk->maj_flt++;
> >>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> >>> -				      regs, address);
> >>> -		} else {
> >>> -			tsk->min_flt++;
> >>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> >>> -				      regs, address);
> >>> -		}
> >>>  		if (fault & VM_FAULT_RETRY) {
> >>>  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >>>  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {

[1]

> >>
> >> Seems like the call to mm_fault_accounting() will be missed if
> >> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> >> jumps to "out_up"...
> > 
> > This is true as a functional change.  However that also means that we've got a
> > VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
> > than handled correctly (for instance, due to some try_lock failed during the
> > fault process).
> > 
> > To me, that case should not be counted as a page fault at all?  Or we might get
> > the same duplicated accounting when the page fault retried from a higher stack.
> > 
> > Thanks
> 
> This case below (the one with the gmap) is the KVM case for doing a so called
> pseudo page fault to our guests. (we notify our guests about major host page
> faults and let it reschedule to something else instead of halting the vcpu).
> This is being resolved with either gup or fixup_user_fault asynchronously by
> KVM code (this can also be sync when the guest does not match some conditions)
> We do not change the counters in that code as far as I can tell so we should
> continue to do it here.
> 
> (see arch/s390/kvm/kvm-s390.c
> static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
> {
> [...]
>         } else if (current->thread.gmap_pfault) {
>                 trace_kvm_s390_major_guest_pfault(vcpu);
>                 current->thread.gmap_pfault = 0;
>                 if (kvm_arch_setup_async_pf(vcpu))
>                         return 0;
>                 return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
>         }

Please correct me if I'm wrong... but I still think what this patch does is the
right thing to do.

Note again that IMHO when reached [1] above it means the page fault is not
handled correctly so we need to fallback to KVM async page fault, then we
shouldn't increment the accountings until it's finally handled correctly. That
final accounting should be done in the async pf path in gup code where the page
fault is handled:

  kvm_arch_fault_in_page
    gmap_fault
      fixup_user_fault

Where in fixup_user_fault() we have:

	if (tsk) {
		if (major)
			tsk->maj_flt++;
		else
			tsk->min_flt++;
	}

Thanks,

-- 
Peter Xu
