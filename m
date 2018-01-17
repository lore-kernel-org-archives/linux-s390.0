From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 01/12] KVM: s390: reverse bit ordering of irqs in pending
 mask
Date: Wed, 17 Jan 2018 11:12:39 +0100
Message-ID: <d83a2ea8-7bd8-715d-7cd7-343c428e5af5@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
 <20180116200217.211897-2-borntraeger@de.ibm.com>
 <84c4a270-99cb-f127-4de6-4995653358f4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <84c4a270-99cb-f127-4de6-4995653358f4@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/16/2018 09:18 PM, David Hildenbrand wrote:
> On 16.01.2018 21:02, Christian Borntraeger wrote:
>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
>>
>> This patch prepares a simplification of bit operations between the irq
>> pending mask for emulated interrupts and the Interruption Pending Mask
>> (IPM) which is part of the Guest Interruption State Area (GISA), a feature
>> that allows interrupt delivery to guests by means of the SIE instruction.
>>
>> Without that change, a bit-wise *or* operation on parts of these two masks
>> would either require a look-up table of size 256 bytes to map the IPM
>> to the emulated irq pending mask bit orientation (all bits mirrored at half
>> byte) or a sequence of up to 8 condidional branches to perform tests of
>> single bit positions. Both options are to reject either by performance or
>> space utilization reasons.
>>
>> Beyond that this change will be transparent.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/include/asm/kvm_host.h | 54 ++++++++++++++++++++--------------------
>>  arch/s390/kvm/interrupt.c        | 10 ++++----
>>  2 files changed, 32 insertions(+), 32 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index e16a9f2a44ad..9981721f258f 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -409,35 +409,35 @@ struct kvm_vcpu_stat {
>>  #define PGM_PER				0x80
>>  #define PGM_CRYPTO_OPERATION		0x119
>>  
>> -/* irq types in order of priority */
>> +/* irq types in ascend order of priorities */
>>  enum irq_types {
>> -	IRQ_PEND_MCHK_EX = 0,
>> -	IRQ_PEND_SVC,
>> -	IRQ_PEND_PROG,
>> -	IRQ_PEND_MCHK_REP,
>> -	IRQ_PEND_EXT_IRQ_KEY,
>> -	IRQ_PEND_EXT_MALFUNC,
>> -	IRQ_PEND_EXT_EMERGENCY,
>> -	IRQ_PEND_EXT_EXTERNAL,
>> -	IRQ_PEND_EXT_CLOCK_COMP,
>> -	IRQ_PEND_EXT_CPU_TIMER,
>> -	IRQ_PEND_EXT_TIMING,
>> -	IRQ_PEND_EXT_SERVICE,
>> -	IRQ_PEND_EXT_HOST,
>> -	IRQ_PEND_PFAULT_INIT,
>> -	IRQ_PEND_PFAULT_DONE,
>> -	IRQ_PEND_VIRTIO,
>> -	IRQ_PEND_IO_ISC_0,
>> -	IRQ_PEND_IO_ISC_1,
>> -	IRQ_PEND_IO_ISC_2,
>> -	IRQ_PEND_IO_ISC_3,
>> -	IRQ_PEND_IO_ISC_4,
>> -	IRQ_PEND_IO_ISC_5,
>> -	IRQ_PEND_IO_ISC_6,
>> -	IRQ_PEND_IO_ISC_7,
>> -	IRQ_PEND_SIGP_STOP,
>> +	IRQ_PEND_SET_PREFIX = 0,
>>  	IRQ_PEND_RESTART,
>> -	IRQ_PEND_SET_PREFIX,
>> +	IRQ_PEND_SIGP_STOP,
>> +	IRQ_PEND_IO_ISC_7,
>> +	IRQ_PEND_IO_ISC_6,
>> +	IRQ_PEND_IO_ISC_5,
>> +	IRQ_PEND_IO_ISC_4,
>> +	IRQ_PEND_IO_ISC_3,
>> +	IRQ_PEND_IO_ISC_2,
>> +	IRQ_PEND_IO_ISC_1,
>> +	IRQ_PEND_IO_ISC_0,
>> +	IRQ_PEND_VIRTIO,
>> +	IRQ_PEND_PFAULT_DONE,
>> +	IRQ_PEND_PFAULT_INIT,
>> +	IRQ_PEND_EXT_HOST,
>> +	IRQ_PEND_EXT_SERVICE,
>> +	IRQ_PEND_EXT_TIMING,
>> +	IRQ_PEND_EXT_CPU_TIMER,
>> +	IRQ_PEND_EXT_CLOCK_COMP,
>> +	IRQ_PEND_EXT_EXTERNAL,
>> +	IRQ_PEND_EXT_EMERGENCY,
>> +	IRQ_PEND_EXT_MALFUNC,
>> +	IRQ_PEND_EXT_IRQ_KEY,
>> +	IRQ_PEND_MCHK_REP,
>> +	IRQ_PEND_PROG,
>> +	IRQ_PEND_SVC,
>> +	IRQ_PEND_MCHK_EX,
>>  	IRQ_PEND_COUNT
> 
> We have to touch all because of irq priority, right?

Yes, we have to swap everything for priority.

> 
>>  };
>>  
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index f8eb2cfa763a..b94173560dcf 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -189,8 +189,8 @@ static int cpu_timer_irq_pending(struct kvm_vcpu *vcpu)
>>  
>>  static inline int is_ioirq(unsigned long irq_type)
>>  {
>> -	return ((irq_type >= IRQ_PEND_IO_ISC_0) &&
>> -		(irq_type <= IRQ_PEND_IO_ISC_7));
>> +	return ((irq_type >= IRQ_PEND_IO_ISC_7) &&
>> +		(irq_type <= IRQ_PEND_IO_ISC_0));
>>  }
>>  
>>  static uint64_t isc_to_isc_bits(int isc)
>> @@ -211,12 +211,12 @@ static inline unsigned long pending_irqs(struct kvm_vcpu *vcpu)
>>  
>>  static inline int isc_to_irq_type(unsigned long isc)
>>  {
>> -	return IRQ_PEND_IO_ISC_0 + isc;
>> +	return IRQ_PEND_IO_ISC_0 - isc;
>>  }
>>  
>>  static inline int irq_type_to_isc(unsigned long irq_type)
>>  {
>> -	return irq_type - IRQ_PEND_IO_ISC_0;
>> +	return IRQ_PEND_IO_ISC_0 - irq_type;
>>  }
>>  
>>  static unsigned long disable_iscs(struct kvm_vcpu *vcpu,
>> @@ -1155,7 +1155,7 @@ int __must_check kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu)
>>  
>>  	while ((irqs = deliverable_irqs(vcpu)) && !rc) {
>>  		/* bits are in the order of interrupt priority */
> 
> this comment should now be "reversed order"

will fix.
> 
>> -		irq_type = find_first_bit(&irqs, IRQ_PEND_COUNT);
>> +		irq_type = find_last_bit(&irqs, IRQ_PEND_COUNT);
>>  		if (is_ioirq(irq_type)) {
>>  			rc = __deliver_io(vcpu, irq_type);
>>  		} else {
>>
> 
> Looks sane to me on the first sight.
> 
