From: Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v5 08/15] KVM: s390: add the GIB and its related life-cyle
 functions
Date: Mon, 7 Jan 2019 17:25:05 +0100
Message-ID: <1ef84b5f-179a-21e2-6ac2-b49f4c3ae5c3@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
 <20181219191756.57973-9-mimu@linux.ibm.com>
 <c244a27a-2d54-0b22-7df4-71f584aed6c0@linux.ibm.com>
Reply-To: mimu@linux.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c244a27a-2d54-0b22-7df4-71f584aed6c0@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pmorel@linux.ibm.com, KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 03.01.19 10:49, Pierre Morel wrote:
> On 19/12/2018 20:17, Michael Mueller wrote:
>> The Guest Information Block (GIB) links the GISA of all guests
>> that have adapter interrupts pending. These interrupts cannot be
>> delivered because no vcpu of these guests is currently running in
>> SIE context. Instead, a GIB alert is issued on the host to schedule
>> these guests to run.
> 
> IMHO "Instead" is not exact.
> The GIB alert is always issued on adapter interrupt if IAM is set even 
> if the guest is running in SIE context.
> 
> I would prefer to rephrase to something like:
> "If enabled, a GIB alert is issued on the host..." ?

I agree.

> 
> 
> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
> 
> 
>>
>> This mechanism allows to process adapter interrupts for currently
>> not running guests.
>>
>> The GIB is created during host initialization and associated with
>> the Adapter Interruption Facility in case an Adapter Interruption
>> Virtualization Facility is available.
>>
>> The GIB initialization and thus the activation of the related code
>> will be done in an upcoming patch of this series.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h | 10 +++++++++
