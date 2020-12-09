Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgLIO7c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 09:59:32 -0500
Date: Wed, 9 Dec 2020 15:57:17 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
Message-ID: <20201209145717.GD7160@osiris>
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
 <20201208152709.GA26979@osiris>
 <7484e153-6c77-8325-6195-621fe144011e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7484e153-6c77-8325-6195-621fe144011e@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Wed, Dec 09, 2020 at 08:07:04AM +0530, Anshuman Khandual wrote:
> >> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
> >> +		rc = -ERANGE;
> >> +		goto out_resource;
> >> +	}
> >> +
...
> >> +struct range arch_get_mappable_range(void)
> >> +{
> >> +	struct range memhp_range;
> >> +
> >> +	memhp_range.start = 0;
> >> +	memhp_range.end =  VMEM_MAX_PHYS;
> >> +	return memhp_range;
> >> +}
> >> +
> >>  int arch_add_memory(int nid, u64 start, u64 size,
> >>  		    struct mhp_params *params)
> >>  {
> >> @@ -291,6 +300,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
> >>  		return -EINVAL;
> >>  
> >> +	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
> >>  	rc = vmem_add_mapping(start, size);
> >>  	if (rc)
> > Is there a reason why you added the memhp_range_allowed() check call
> > to arch_add_memory() instead of vmem_add_mapping()? If you would do
> 
> As I had mentioned previously, memhp_range_allowed() is available with
> CONFIG_MEMORY_HOTPLUG but vmem_add_mapping() is always available. Hence
> there will be a build failure in vmem_add_mapping() for the range check
> memhp_range_allowed() without memory hotplug enabled.
> 
> > that, then the extra code in __segment_load() wouldn't be
> > required.
> > Even though the error message from memhp_range_allowed() might be
> > highly confusing.
>
> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
> will create three range checks i.e two memhp_range_allowed() and the
> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
> paths, which is not optimal.

Ah, sorry. I didn't follow this discussion too closely. I just thought
my point of view would be clear: let's not have two different ways to
check for the same thing which must be kept in sync.
Therefore I was wondering why this next version is still doing
that. Please find a way to solve this.
