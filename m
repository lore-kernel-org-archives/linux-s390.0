Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7815 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB2AIZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Feb 2020 19:08:25 -0500
Subject: Re: [RFC v1 2/2] mm/gup/writeback: add callbacks for inaccessible
 pages
References: <20200228154322.329228-1-imbrenda@linux.ibm.com>
 <20200228154322.329228-4-imbrenda@linux.ibm.com>
 <2e3bf1a2-b672-68e0-97b6-42f08133e077@de.ibm.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <ff35804f-81ef-a245-01d9-1f9b525e3410@nvidia.com>
Date: Fri, 28 Feb 2020 16:08:23 -0800
MIME-Version: 1.0
In-Reply-To: <2e3bf1a2-b672-68e0-97b6-42f08133e077@de.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-next@vger.kernel.org, akpm@linux-foundation.org
Cc: david@redhat.com, aarcange@redhat.com, linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>

On 2/28/20 8:08 AM, Christian Borntraeger wrote:
> Andrew,
> 
> while patch 1 is a fixup for the FOLL_PIN work in your patch queue,
> I would really love to see this patch in 5.7. The exploitation code
> of kvm/s390 is in Linux next also scheduled for 5.7.
> 
> Christian
> 
> On 28.02.20 16:43, Claudio Imbrenda wrote:
>> With the introduction of protected KVM guests on s390 there is now a
>> concept of inaccessible pages. These pages need to be made accessible
>> before the host can access them.
>>
>> While cpu accesses will trigger a fault that can be resolved, I/O
>> accesses will just fail.  We need to add a callback into architecture
>> code for places that will do I/O, namely when writeback is started or
>> when a page reference is taken.
>>
>> This is not only to enable paging, file backing etc, it is also
>> necessary to protect the host against a malicious user space. For
>> example a bad QEMU could simply start direct I/O on such protected
>> memory.  We do not want userspace to be able to trigger I/O errors and
>> thus we the logic is "whenever somebody accesses that page (gup) or


I actually kind of like the sound of that: "We the logic of the kernel,
in order to form a more perfect computer..." :)

Probably this wording is what you want, though:

"thus the logic is "whenever somebody (gup) accesses that page or"


...
>> @@ -458,7 +457,6 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>  	}
>>  
>>  	if (flags & FOLL_SPLIT && PageTransCompound(page)) {
>> -		int ret;
>>  		get_page(page);
>>  		pte_unmap_unlock(ptep, ptl);
>>  		lock_page(page);
>> @@ -475,6 +473,14 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>>  		page = ERR_PTR(-ENOMEM);
>>  		goto out;
>>  	}
>> +	if (flags & FOLL_PIN) {


What about FOLL_GET? Unless your calling code has some sort of BUG_ON(flags & FOLL_GET),
I'm not sure it's a good idea to leave that case unhandled.


>> +		ret = arch_make_page_accessible(page);
>> +		if (ret) {
>> +			unpin_user_page(page);
>> +			page = ERR_PTR(ret);
>> +			goto out;
>> +		}
>> +	}
>>  	if (flags & FOLL_TOUCH) {
>>  		if ((flags & FOLL_WRITE) &&
>>  		    !pte_dirty(pte) && !PageDirty(page))
>> @@ -2143,6 +2149,13 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>  
>>  		VM_BUG_ON_PAGE(compound_head(page) != head, page);
>>  
>> +		if (flags & FOLL_PIN) {
>> +			ret = arch_make_page_accessible(page);
>> +			if (ret) {
>> +				unpin_user_page(page);


Same concern as above, about leaving FOLL_GET unhandled.


thanks,
-- 
John Hubbard
NVIDIA
