Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbfKBIxJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 2 Nov 2019 04:53:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA28WvuF077447
        for <linux-s390@vger.kernel.org>; Sat, 2 Nov 2019 04:53:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w16b70jkt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Sat, 02 Nov 2019 04:53:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Sat, 2 Nov 2019 08:53:06 -0000
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Sat, 2 Nov 2019 09:53:01 +0100
MIME-Version: 1.0
In-Reply-To: <20191024114059.102802-10-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <6ff87f0a-6fad-797f-dc12-e6031933d74a@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com



On 24.10.19 13:40, Janosch Frank wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> Pin the guest pages when they are first accessed, instead of all at
> the same time when starting the guest.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
[...]
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index 80aecd5bea9e..383e660e2221 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -15,8 +15,35 @@
>  #include <asm/mman.h>
>  #include "kvm-s390.h"
>  
> +static void unpin_destroy(struct page **pages, int nr)
> +{
> +	int i;
> +	struct page *page;
> +	u8 *val;
> +
> +	for (i = 0; i < nr; i++) {
> +		page = pages[i];
> +		if (!page)	/* page was never used */
> +			continue;
> +		val = (void *)page_to_phys(page);

Why dont we call the convert from secure directly here to avoid the fault overhead?

> +		READ_ONCE(*val);
> +		put_page(page);

as we also do the export here (via implicit reading that page) this can take a while.
I think we must add a cond_resched here. 

> +	}
> +}
> +

[...]
> -
>  	mutex_unlock(&kvm->slots_lock);
> +
> +	kvm->arch.gmap->pinned_pages = vzalloc(npages * sizeof(struct page *));
> +	if (!kvm->arch.gmap->pinned_pages)
> +		goto out_err;
>  	kvm->arch.pv.guest_len = npages * PAGE_SIZE;
>  
>  	/* Allocate variable storage */
>  	vlen = ALIGN(virt * ((npages * PAGE_SIZE) / HPAGE_SIZE), PAGE_SIZE);
>  	vlen += uv_info.guest_virt_base_stor_len;
>  	kvm->arch.pv.stor_var = vzalloc(vlen);
> -	if (!kvm->arch.pv.stor_var) {
> -		kvm_s390_pv_dealloc_vm(kvm);
> -		return -ENOMEM;
> -	}
> +	if (!kvm->arch.pv.stor_var)
> +		goto out_err;
>  	return 0;
> +
> +out_err:
> +	kvm_s390_pv_dealloc_vm(kvm);
> +	return -ENOMEM;
>  }
>  
>  int kvm_s390_pv_destroy_vm(struct kvm *kvm)
> @@ -216,6 +246,11 @@ int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned long size,
>  	for (i = 0; i < size / PAGE_SIZE; i++) {
>  		uvcb.gaddr = addr + i * PAGE_SIZE;
>  		uvcb.tweak[1] = i * PAGE_SIZE;
> +		down_read(&kvm->mm->mmap_sem);
> +		rc = kvm_s390_pv_pin_page(kvm->arch.gmap, uvcb.gaddr);
> +		up_read(&kvm->mm->mmap_sem);

Here we should also have a cond_resched();

> +		if (rc && (rc != -EEXIST))
> +			break;
>  retry:
>  		rc = uv_call(0, (u64)&uvcb);
>  		if (!rc)
> 
