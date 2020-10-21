Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 08/17] s390/pci: Remove races against pte updates
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-9-daniel.vetter@ffwll.ch>
 <6deb08dd-46f3-bf26-5362-fdc696f6fd74@linux.ibm.com>
 <20201012141906.GX438822@phenom.ffwll.local>
From: Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <3594c115-541f-806a-ee33-e99a2d1d31e8@linux.ibm.com>
Date: Wed, 21 Oct 2020 09:55:57 +0200
MIME-Version: 1.0
In-Reply-To: <20201012141906.GX438822@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Daniel Vetter <daniel.vetter@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Jan Kara <jack@suse.cz>

Hi Daniel,

friendly ping. I haven't seen a new version of this patch series,
as I said I think your change for s390/pci is generally useful so
I'm curious, are you planning on sending a new version soon?
If you want you can also just sent this patch with the last few
nitpicks (primarily the mail address) fixed and I'll happily apply.

Best regards,
Niklas Schnelle

On 10/12/20 4:19 PM, Daniel Vetter wrote:
> On Mon, Oct 12, 2020 at 04:03:28PM +0200, Niklas Schnelle wrote:
... snip ....
>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Jérôme Glisse <jglisse@redhat.com>
>>> Cc: Jan Kara <jack@suse.cz>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>
>> The above Cc: line for Dan Williams is a duplicate
>>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-samsung-soc@vger.kernel.org
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
> 
> I'll fix up all the nits you've found for the next round. Thanks for
> taking a look.
> -Daniel
> 
