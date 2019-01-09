From: Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 14/15] KVM: s390: add and wire function
 gib_alert_irq_handler()
Date: Wed, 9 Jan 2019 13:35:42 +0100
Message-ID: <97f1294f-cbb3-a54b-6abf-29471b69946e@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-15-mimu@linux.ibm.com>
 <7dfe72db-97d2-9f33-68f7-acf8ec5ddc5e@linux.ibm.com>
 <fd2efaed-24d5-4397-b79c-1f64dc80a9e4@linux.ibm.com>
Reply-To: pmorel@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd2efaed-24d5-4397-b79c-1f64dc80a9e4@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mimu@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/01/2019 11:06, Michael Mueller wrote:
> 
> 
> On 03.01.19 16:16, Pierre Morel wrote:
>> On 19/12/2018 20:17, Michael Mueller wrote:
>>> The patch implements a handler for GIB alert interruptions
>>> on the host. Its task is to alert guests that interrupts are
>>> pending for them.
>>>

...snip...

>>>   {
>>>       u32 final, next_alert, origin = 0UL;
>>>       struct kvm_s390_gisa *gisa;
>>> @@ -3091,7 +3092,10 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
>>>   {
>>>       if (!kvm->arch.gisa)
>>>           return;
>>> +    if (set_iam(kvm->arch.gisa, 0) == -EBUSY)
>>> +        process_gib_alert_list();
>>
>> We call process_gib_alert_list() from different contexts shouldn't we 
>> protect the calls?
> 
> That should not be necessary as the xcgh() guarantees that both
> instances will work on gib alert lists with disjunctive gisas.

Here is how I see the problem:

A CPU get the GAL IRQ and start processing the ALERT list.

On another guest we clear floating interrupt...
we call gisa_clear()
we return from set_iam with -EBUSY, meaning the GISA is in alert list.
   -> we call process_gib_alert_list()
   -> since the list has been disjunct by the GAL IRQ routine we return
      immediately
   -> we nullify the GISA while it has not been handled by the IRQ
      routine

!! if my assumption is right, we loose all GISA following the GISA we 
just nullified.


Regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
