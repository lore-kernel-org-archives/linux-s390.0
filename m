Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55708 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgLCLzC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 06:55:02 -0500
Date: Thu, 3 Dec 2020 12:51:33 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
Message-ID: <20201203115133.GB9994@osiris>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
 <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>

On Thu, Dec 03, 2020 at 06:03:00AM +0530, Anshuman Khandual wrote:
> >> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
> >> index 5060956b8e7d..cc055a78f7b6 100644
> >> --- a/arch/s390/mm/extmem.c
> >> +++ b/arch/s390/mm/extmem.c
> >> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
> >>  		goto out_free_resource;
> >>  	}
> >>  
> >> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
> >> +		rc = -ERANGE;
> >> +		goto out_resource;
> >> +	}
> >> +
> >>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
> >>  	if (rc)
> >>  		goto out_resource;
> >> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> >> index b239f2ba93b0..06dddcc0ce06 100644
> >> --- a/arch/s390/mm/vmem.c
> >> +++ b/arch/s390/mm/vmem.c
> >> @@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
> >>  	mutex_unlock(&vmem_mutex);
> >>  }
> >>  
> >> +struct range arch_get_mappable_range(void)
> >> +{
> >> +	struct range memhp_range;
> >> +
> >> +	memhp_range.start = 0;
> >> +	memhp_range.end =  VMEM_MAX_PHYS;
> >> +	return memhp_range;
> >> +}
> >> +
> >>  int vmem_add_mapping(unsigned long start, unsigned long size)
> >>  {
> >>  	int ret;
> >>  
> >> -	if (start + size > VMEM_MAX_PHYS ||
> >> -	    start + size < start)
> >> -		return -ERANGE;
> >> -
> > 
> > I really fail to see how this could be considered an improvement for
> > s390. Especially I do not like that the (central) range check is now
> > moved to the caller (__segment_load). Which would mean potential
> > additional future callers would have to duplicate that code as well.
> 
> The physical range check is being moved to the generic hotplug code
> via arch_get_mappable_range() instead, making the existing check in
> vmem_add_mapping() redundant. Dropping the check there necessitates
> adding back a similar check in __segment_load(). Otherwise there
> will be a loss of functionality in terms of range check.
> 
> May be we could just keep this existing check in vmem_add_mapping()
> as well in order avoid this movement but then it would be redundant
> check in every hotplug path.
> 
> So I guess the choice is to either have redundant range checks in
> all hotplug paths or future internal callers of vmem_add_mapping()
> take care of the range check.

The problem I have with this current approach from an architecture
perspective: we end up having two completely different methods which
are doing the same and must be kept in sync. This might be obvious
looking at this patch, but I'm sure this will go out-of-sync (aka
broken) sooner or later.

Therefore I would really like to see a single method to do the range
checking. Maybe you could add a callback into architecture code, so
that such an architecture specific function could also be used
elsewhere. Dunno.
