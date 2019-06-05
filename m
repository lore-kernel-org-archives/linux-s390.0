Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbfFEMOi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Jun 2019 08:14:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x55C3266084759
        for <linux-s390@vger.kernel.org>; Wed, 5 Jun 2019 08:14:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sxb01xj8v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 05 Jun 2019 08:14:36 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Wed, 5 Jun 2019 13:14:34 +0100
Subject: Re: [PATCH AUTOSEL 4.4 10/10] KVM: s390: fix memory slot handling for
 KVM_SET_USER_MEMORY_REGION
References: <20190604232532.7953-1-sashal@kernel.org>
 <20190604232532.7953-10-sashal@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Jun 2019 14:14:30 +0200
MIME-Version: 1.0
In-Reply-To: <20190604232532.7953-10-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d2c1b279-ba67-bd0e-07ef-1587b4aa77d3@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org

On 05.06.19 01:25, Sasha Levin wrote:
> From: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> [ Upstream commit 19ec166c3f39fe1d3789888a74cc95544ac266d4 ]
> 
> kselftests exposed a problem in the s390 handling for memory slots.
> Right now we only do proper memory slot handling for creation of new
> memory slots. Neither MOVE, nor DELETION are handled properly. Let us
> implement those.

I gave this a quick spin on 4.4.y and it seems to work fine.


> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/s390/kvm/kvm-s390.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 5ddb1debba95..23911ecfbad6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2721,21 +2721,28 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)
>  {
> -	int rc;
> -
> -	/* If the basics of the memslot do not change, we do not want
> -	 * to update the gmap. Every update causes several unnecessary
> -	 * segment translation exceptions. This is usually handled just
> -	 * fine by the normal fault handler + gmap, but it will also
> -	 * cause faults on the prefix page of running guest CPUs.
> -	 */
> -	if (old->userspace_addr == mem->userspace_addr &&
> -	    old->base_gfn * PAGE_SIZE == mem->guest_phys_addr &&
> -	    old->npages * PAGE_SIZE == mem->memory_size)
> -		return;
> +	int rc = 0;
>  
> -	rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
> -		mem->guest_phys_addr, mem->memory_size);
> +	switch (change) {
> +	case KVM_MR_DELETE:
> +		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
> +					old->npages * PAGE_SIZE);
> +		break;
> +	case KVM_MR_MOVE:
> +		rc = gmap_unmap_segment(kvm->arch.gmap, old->base_gfn * PAGE_SIZE,
> +					old->npages * PAGE_SIZE);
> +		if (rc)
> +			break;
> +		/* FALLTHROUGH */
> +	case KVM_MR_CREATE:
> +		rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
> +				      mem->guest_phys_addr, mem->memory_size);
> +		break;
> +	case KVM_MR_FLAGS_ONLY:
> +		break;
> +	default:
> +		WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
> +	}
>  	if (rc)
>  		pr_warn("failed to commit memory region\n");
>  	return;
> 
