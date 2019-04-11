Return-Path: <SRS0=MvP8=SN=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [qemu-s390x] [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe
 to access channel programs
References: <20190301093902.27799-1-cohuck@redhat.com>
 <20190301093902.27799-2-cohuck@redhat.com>
 <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
 <20190408190747.12e3618b.cohuck@redhat.com>
 <20190410013434.7cea1971@oc2783563651>
 <4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
 <20190411175831.7be345f4@oc2783563651>
From: Eric Farman <farman@linux.ibm.com>
Date: Thu, 11 Apr 2019 12:25:38 -0400
MIME-Version: 1.0
In-Reply-To: <20190411175831.7be345f4@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <72385d8c-a050-67e7-85cf-bc804f941137@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>



On 4/11/19 11:58 AM, Halil Pasic wrote:
> On Wed, 10 Apr 2019 22:59:41 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> r the next release :) It would be one thing less on my plate...
>>>>   
>>>
>>> Sorry I was not able to spend any significant amount of time on this
>>> lately.
>>>
>>> Gave the combined set (this + Farhans fio-ccw fixes for kernel
>>> stacktraces v2) it a bit of smoke testing after some minor adjustments
>>> to make it compile:
>>>
>>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/vfio.h>
>>>    #include <linux/mdev.h>
>>>    #include <linux/nospec.h>
>>> +#include <linux/slab.h>
>>>    
>>>    #include "vfio_ccw_private.h"
>>>
>>>    
>>
>> Hrm...  Taking today's master, and the two series you mention (slight
>> adjustment to apply patch 3 of Connie's series, because part of it was
>> split out a few weeks ago), and I don't encounter this.  Tried switching
>> between SLUB/SLAB, but still compiles fine.
> 
> Let me guess: you have CONFIG_PCI in our .config, right?
> 
> In arch/s390/include/asm/pci_io.h we have
> 
> #ifndef _ASM_S390_PCI_IO_H
> #define _ASM_S390_PCI_IO_H
> 
> #ifdef CONFIG_PCI
> 
> #include <linux/kernel.h>
> #include <linux/slab.h>
> 
> and pci_io.h comes in via
> 
> include/linux/vfio.h
> include/linux/iommu.h
> include/linux/scatterlist.h
> arch/s390/include/asm/io.h
> arch/s390/include/asm/pci_io.h
> 
> 
> Figured it out with help from Farhan. Took me quite some time.

That would have been useful information up front.

> 
> Regards,
> Halil
> 
> 
