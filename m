Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729810AbgFPQfQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jun 2020 12:35:16 -0400
Received: by mail-qv1-f72.google.com with SMTP id ba13so15932894qvb.15
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2020 09:35:13 -0700 (PDT)
Date: Tue, 16 Jun 2020 12:35:10 -0400
From: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200616163510.GD11838@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616155933.GA12897@oc3871087118.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Hi, Alexander,

On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> > @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> > 
> > -	/*
> > -	 * Major/minor page fault accounting is only done on the
> > -	 * initial attempt. If we go through a retry, it is extremely
> > -	 * likely that the page will be found in page cache at that point.
> > -	 */
> >  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > -		if (fault & VM_FAULT_MAJOR) {
> > -			tsk->maj_flt++;
> > -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> > -				      regs, address);
> > -		} else {
> > -			tsk->min_flt++;
> > -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> > -				      regs, address);
> > -		}
> >  		if (fault & VM_FAULT_RETRY) {
> >  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> 
> Seems like the call to mm_fault_accounting() will be missed if
> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> jumps to "out_up"...

This is true as a functional change.  However that also means that we've got a
VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
than handled correctly (for instance, due to some try_lock failed during the
fault process).

To me, that case should not be counted as a page fault at all?  Or we might get
the same duplicated accounting when the page fault retried from a higher stack.

Thanks,

-- 
Peter Xu
