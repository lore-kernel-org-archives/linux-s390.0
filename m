Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389445AbgBNVRQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 16:17:16 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EL9mDH059019
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 16:17:14 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y57aty1tv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 16:17:14 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 14 Feb 2020 21:17:11 -0000
Subject: Re: [PATCH 05/35] s390/mm: provide memory management functions for
 protected KVM guests
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-6-borntraeger@de.ibm.com>
 <1fb4da22-bab4-abe3-847b-5a7d79d84774@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Feb 2020 22:17:06 +0100
MIME-Version: 1.0
In-Reply-To: <1fb4da22-bab4-abe3-847b-5a7d79d84774@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <deb3faec-f05c-4fb0-9a4a-e38ee58a637d@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

In general this patch has changed a lot, but several comments still apply

On 14.02.20 18:59, David Hildenbrand wrote:
>>  
>>  /*
>> @@ -1086,12 +1106,16 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>>  					    unsigned long addr,
>>  					    pte_t *ptep, int full)
>>  {
>> +	pte_t res;
> 
> Empty line missing.

ack

> 
>>  	if (full) {
>> -		pte_t pte = *ptep;
>> +		res = *ptep;
>>  		*ptep = __pte(_PAGE_INVALID);
>> -		return pte;
>> +	} else {
>> +		res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
>>  	}
>> -	return ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
>> +	if (mm_is_protected(mm) && pte_present(res))
>> +		uv_convert_from_secure(pte_val(res) & PAGE_MASK);
>> +	return res;
>>  }
> 
> [...]
> 
>> +int uv_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
>> +int uv_convert_from_secure(unsigned long paddr);
>> +
>> +static inline int uv_convert_to_secure(struct gmap *gmap, unsigned long gaddr)
>> +{
>> +	struct uv_cb_cts uvcb = {
>> +		.header.cmd = UVC_CMD_CONV_TO_SEC_STOR,
>> +		.header.len = sizeof(uvcb),
>> +		.guest_handle = gmap->guest_handle,
>> +		.gaddr = gaddr,
>> +	};
>> +
>> +	return uv_make_secure(gmap, gaddr, &uvcb);
>> +}
> 
> I'd actually suggest to name everything that eats a gmap "gmap_",
> 
> e.g., "gmap_make_secure()"
> 
> [...]

ack.

> 
>>  
>>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                          \
>> diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
>> index a06a628a88da..15ac598a3d8d 100644
>> --- a/arch/s390/kernel/uv.c
>> +++ b/arch/s390/kernel/uv.c
>> @@ -9,6 +9,8 @@
>>  #include <linux/sizes.h>
>>  #include <linux/bitmap.h>
>>  #include <linux/memblock.h>
>> +#include <linux/pagemap.h>
>> +#include <linux/swap.h>
>>  #include <asm/facility.h>
>>  #include <asm/sections.h>
>>  #include <asm/uv.h>
>> @@ -99,4 +101,174 @@ void adjust_to_uv_max(unsigned long *vmax)
>>  	if (prot_virt_host && *vmax > uv_info.max_sec_stor_addr)
>>  		*vmax = uv_info.max_sec_stor_addr;
>>  }
>> +
>> +static int __uv_pin_shared(unsigned long paddr)
>> +{
>> +	struct uv_cb_cfs uvcb = {
>> +		.header.cmd	= UVC_CMD_PIN_PAGE_SHARED,
>> +		.header.len	= sizeof(uvcb),
>> +		.paddr		= paddr,
> 
> please drop all the superfluous spaces (just as in the other uv calls).

ack

> 
>> +	};
>> +
>> +	if (uv_call(0, (u64)&uvcb))
>> +		return -EINVAL;
>> +	return 0;
>> +}
> 
> [...]
> 
>> +static int make_secure_pte(pte_t *ptep, unsigned long addr, void *data)
>> +{
>> +	struct conv_params *params = data;
>> +	pte_t entry = READ_ONCE(*ptep);
>> +	struct page *page;
>> +	int expected, rc = 0;
>> +
>> +	if (!pte_present(entry))
>> +		return -ENXIO;
>> +	if (pte_val(entry) & (_PAGE_INVALID | _PAGE_PROTECT))
>> +		return -ENXIO;
>> +
>> +	page = pte_page(entry);
>> +	if (page != params->page)
>> +		return -ENXIO;
>> +
>> +	if (PageWriteback(page))
>> +		return -EAGAIN;
>> +	expected = expected_page_refs(page);
> 
> I do wonder if we could factor out expected_page_refs() and reuse from
> other sources ...
> 
> I do wonder about huge page backing of guests, and especially
> hpage_nr_pages(page) used in mm/migrate.c:expected_page_refs(). But I
> can spot some hugepage exclusion below ... This needs comments.

Yes, we looked into several places and ALL places do their own math with their
own side conditions. There is no single function that accounts all possible
conditions and I am not going to start that now given the review bandwidth of
the mm tree.

I will add:
/*
 * Calculate the expected ref_count for a page that would otherwise have no
 * further pins. This was cribbed from similar functions in other places in
 * the kernel, but with some slight modifications. We know that a secure
 * page can not be a huge page for example.
 */
to expected page count

and something to the hugetlb check.




> 
>> +	if (!page_ref_freeze(page, expected))
>> +		return -EBUSY;
>> +	set_bit(PG_arch_1, &page->flags);
> 
> Can we please document somewhere how PG_arch_1 is used on s390x? (page)
> 
> "The generic code guarantees that this bit is cleared for a page when it
> first is entered into the page cache" - should not be an issue, right?

Right
> 
>> +	rc = uv_call(0, (u64)params->uvcb);
>> +	page_ref_unfreeze(page, expected);
>> +	if (rc)
>> +		rc = (params->uvcb->rc == 0x10a) ? -ENXIO : -EINVAL;
>> +	return rc;
>> +}
>> +
>> +/*
>> + * Requests the Ultravisor to make a page accessible to a guest.
>> + * If it's brought in the first time, it will be cleared. If
>> + * it has been exported before, it will be decrypted and integrity
>> + * checked.
>> + *
>> + * @gmap: Guest mapping
>> + * @gaddr: Guest 2 absolute address to be imported
> 
> I'd just drop the the (incomplete) parameter documentation, everybody
> reaching this point should now what a gmap and what a gaddr is ...

ack.
> 
>> + */
>> +int uv_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
>> +{
>> +	struct conv_params params = { .uvcb = uvcb };
>> +	struct vm_area_struct *vma;
>> +	unsigned long uaddr;
>> +	int rc, local_drain = 0;
>> +
>> +again:
>> +	rc = -EFAULT;
>> +	down_read(&gmap->mm->mmap_sem);
>> +
>> +	uaddr = __gmap_translate(gmap, gaddr);
>> +	if (IS_ERR_VALUE(uaddr))
>> +		goto out;
>> +	vma = find_vma(gmap->mm, uaddr);
>> +	if (!vma)
>> +		goto out;
>> +	if (is_vm_hugetlb_page(vma))
>> +		goto out;
> 
> Hah there it is! How is it enforced on upper layers/excluded? Will
> hpage=true fail with prot virt? What if a guest is not a protected guest
> but wants to sue huge pages? This needs comments/patch description.

will add

        /*
         * Secure pages cannot be huge and userspace should not combine both.
         * In case userspace does it anyway this will result in an -EFAULT for
         * the unpack. The guest is thus never reaching secure mode. If
         * userspace is playing dirty tricky with mapping huge pages later
         * on this will result in a segmenation fault.
         */


> 
>> +
>> +	rc = -ENXIO;
>> +	params.page = follow_page(vma, uaddr, FOLL_WRITE | FOLL_NOWAIT);
>> +	if (IS_ERR_OR_NULL(params.page))
>> +		goto out;
>> +
>> +	lock_page(params.page);
>> +	rc = apply_to_page_range(gmap->mm, uaddr, PAGE_SIZE, make_secure_pte, &params);
> 
> Ehm, isn't it just always a single page?

Yes, already fixed.

> 
>> +	unlock_page(params.page);
>> +out:
>> +	up_read(&gmap->mm->mmap_sem);
>> +
>> +	if (rc == -EBUSY) {
>> +		if (local_drain) {
>> +			lru_add_drain_all();
>> +			return -EAGAIN;
>> +		}
>> +		lru_add_drain();
> 
> comments please why that is performed.

done

> 
>> +		local_drain = 1;
[..]

>> +
>> +	if (PageHuge(page))
>> +		return 0;
> 
> Ah, another instance. Comment please why
> 
>> +
>> +	if (!test_bit(PG_arch_1, &page->flags))
>> +		return 0;
> 
> "Can you describe the meaning of this bit with three words"? Or a couple
> more? :D
> 
> "once upon a time, the page was secure and still might be" ?
> "the page is secure and therefore inaccessible" ?


        /*
         * PG_arch_1 is used in 3 places:
         * 1. for kernel page tables during early boot
         * 2. for storage keys of huge pages and KVM
         * 3. As an indication that this page might be secure. This can
         *    overindicate, e.g. we set the bit before calling
         *    convert_to_secure.
         * As secure pages are never huge, all 3 variants can co-exists.
         */

> 
>> +
>> +	rc = __uv_pin_shared(page_to_phys(page));
>> +	if (!rc) {
>> +		clear_bit(PG_arch_1, &page->flags);
>> +		return 0;
>> +	}
>> +
>> +	rc = uv_convert_from_secure(page_to_phys(page));
>> +	if (!rc) {
>> +		clear_bit(PG_arch_1, &page->flags);
>> +		return 0;
>> +	}
>> +
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(arch_make_page_accessible);
>> +
>>  #endif
>>
> 
> More code comments would be highly appreciated!
> 
done
