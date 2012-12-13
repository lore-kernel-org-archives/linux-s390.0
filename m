From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 4/4] KVM: s390: Add a channel I/O based virtio transport
 driver.
Date: Thu, 13 Dec 2012 17:08:02 +0100
Message-ID: <50C9FD62.9070203@de.ibm.com>
References: <1355330201-36481-1-git-send-email-cornelia.huck@de.ibm.com> <1355330201-36481-5-git-send-email-cornelia.huck@de.ibm.com> <50C8CD8F.2000909@suse.de> <50C8E52A.1@de.ibm.com> <051FA3EB-2FCA-4AEB-914C-DD19A8F17572@suse.de> <50C9B873.5090800@de.ibm.com> <71DC6A29-6025-4B9C-86D4-5165E3F09775@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <71DC6A29-6025-4B9C-86D4-5165E3F09775@suse.de>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 13/12/12 12:19, Alexander Graf wrote:
> 
> On 13.12.2012, at 12:13, Christian Borntraeger wrote:
> 
>> On 13/12/12 12:06, Alexander Graf wrote:
>>>
>>> On 12.12.2012, at 21:12, Christian Borntraeger wrote:
>>>
>>>> On 12/12/12 19:31, Alexander Graf wrote:
>>>> +static inline long do_kvm_notify(struct subchannel_id schid,
>>>>>> +                 unsigned long queue_index)
>>>>>> +{
>>>>>> +    register unsigned long __nr asm("1") = KVM_S390_VIRTIO_CCW_NOTIFY;
>>>>>> +    register struct subchannel_id __schid asm("2") = schid;
>>>>>
>>>>> How does the compiler know that the struct fits within a register?
>>>>>
>>>>
>>>> Well it knows that sizeof struct subchannel_id is 4.
>>>
>>> How so? The asm/ccwdev.h header simply says
>>>
>>>  struct subchannel_id;
>>
>> see original patch:
>>
>>>>> +#include <asm/cio.h>
>>>>> +#include <asm/ccwdev.h>
>>>>> +#include <asm/schid.h>
>>>>> +
>>>>> +/*
>>>>> + * virtio related functions
>>>>> + */
>>>>> +
>>
>> asm/schid.h includes uapi/asm/schid.h and that contains the definition.
> 
> My point is that the asm/schid.h include should be in asm/ccwdev.h then, not in virtio_ccw.c. Because semantically you are creating a dependency due to the new function that returns a struct schid.

Ok, so you actually want to have patch 3 slightly modified as described above.
Yes makes sense.

Christian
