Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8442 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388957AbgJLOlj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 12 Oct 2020 10:41:39 -0400
Subject: Re: [PATCH v2 08/17] s390/pci: Remove races against pte updates
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-9-daniel.vetter@ffwll.ch>
 <6deb08dd-46f3-bf26-5362-fdc696f6fd74@linux.ibm.com>
 <20201012141906.GX438822@phenom.ffwll.local>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <3c28a96a-6bb5-f581-4671-5c87161238f7@linux.ibm.com>
Date: Mon, 12 Oct 2020 16:39:30 +0200
MIME-Version: 1.0
In-Reply-To: <20201012141906.GX438822@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

... snip ...
>>> Cc: linux-media@vger.kernel.org
>>> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
>>> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>>> Cc: linux-s390@vger.kernel.org
>>> --
>>> v2: Move VM_IO | VM_PFNMAP checks around so they keep returning EINVAL
>>> like before (Gerard)
>>
>> I think the above should go before the CC/Signed-off/Reviewev block.
> 
> This is a per-subsystem bikeshed :-) drivers/gpu definitely wants it
> above, but most core subsystems want it below. I'll move it.

Today I learned, thanks! That said I think most of the time I've
actually not seen version change information in the commit message itself
only in the cover letters. I really don't care just looked odd to me.

> 
>>> ---
>>>  arch/s390/pci/pci_mmio.c | 98 +++++++++++++++++++++++-----------------
>>>  1 file changed, 57 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
>>> index 401cf670a243..1a6adbc68ee8 100644
>>> --- a/arch/s390/pci/pci_mmio.c
>>> +++ b/arch/s390/pci/pci_mmio.c
>>> @@ -119,33 +119,15 @@ static inline int __memcpy_toio_inuser(void __iomem *dst,
>>>  	return rc;
>>>  }
>>>  
>>> -static long get_pfn(unsigned long user_addr, unsigned long access,
>>> -		    unsigned long *pfn)
>>> -{
>>> -	struct vm_area_struct *vma;
>>> -	long ret;
>>> -
>>> -	mmap_read_lock(current->mm);
>>> -	ret = -EINVAL;
>>> -	vma = find_vma(current->mm, user_addr);
>>> -	if (!vma)
>>> -		goto out;
>>> -	ret = -EACCES;
>>> -	if (!(vma->vm_flags & access))
>>> -		goto out;
>>> -	ret = follow_pfn(vma, user_addr, pfn);
>>> -out:
>>> -	mmap_read_unlock(current->mm);
>>> -	return ret;
>>> -}
>>> -
>>>  SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
>>>  		const void __user *, user_buffer, size_t, length)
>>>  {
>>>  	u8 local_buf[64];
>>>  	void __iomem *io_addr;
>>>  	void *buf;
>>> -	unsigned long pfn;
>>> +	struct vm_area_struct *vma;
>>> +	pte_t *ptep;
>>> +	spinlock_t *ptl;
>>
>> With checkpatch.pl --strict the above yields a complained
>> "CHECK: spinlock_t definition without comment" but I think
>> that's really okay since your commit description is very clear.
>> Same oin line 277.
> 
> I think this is a falls positive, checkpatch doesn't realize that
> SYSCALL_DEFINE3 is a function, not a structure. And in a structure I'd
> have added the kerneldoc or comment.

Interesting, your theory sounds convincing, I too thought this
was a bit too pedantic.

> 
> I'll fix up all the nits you've found for the next round. Thanks for
> taking a look.

You're welcome hope I didn't sound pedantic. I think you've a lot
more experience actually and this can indeed turn into bikeshedding
but since I was answering anyway and most of this was checkpatch…

> -Daniel
> 
