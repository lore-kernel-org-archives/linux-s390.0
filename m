Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH v1] KVM: s390: store DXC/VXC in fpc on
 DATA/Vector-processing exceptions
References: <20180822095310.29145-1-david@redhat.com>
 <02f9379d-d20d-8b69-94b9-959f46490a26@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d0681f2-9c14-dd6f-94e9-e677b7702207@redhat.com>
Date: Wed, 22 Aug 2018 13:13:10 +0200
MIME-Version: 1.0
In-Reply-To: <02f9379d-d20d-8b69-94b9-959f46490a26@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 22.08.2018 12:31, Janosch Frank wrote:
> On 22.08.2018 11:53, David Hildenbrand wrote:
>> When DATA exceptions and vector-processing exceptions (program interrupts)
>> are injected, the DXC/VXC is also to be stored in the fpc, if AFP is
>> enabled in CR0.
>>
>> This can happen inside KVM when reinjecting an interrupt during program
>> interrupt intercepts. These are triggered for example when debugging the
>> guest (concurrent PER events result in an intercept instead of an
>> injection of such interrupts).
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> Only compile-tested.
> 
> It baffles me that AFP is still a thing in zArch mode. I would have
> expected it to be a default 1. But then again, I just found out about it.
> 
> POP checks out:
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> 
> 
>>
>>  arch/s390/include/asm/ctl_reg.h | 1 +
>>  arch/s390/kvm/interrupt.c       | 8 ++++++++
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/ctl_reg.h b/arch/s390/include/asm/ctl_reg.h
>> index 4600453536c2..88f3f14baee9 100644
>> --- a/arch/s390/include/asm/ctl_reg.h
>> +++ b/arch/s390/include/asm/ctl_reg.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/const.h>
>>  
>>  #define CR0_CLOCK_COMPARATOR_SIGN	_BITUL(63 - 10)
>> +#define CR0_AFP_REGISTER_CONTROL	_BITUL(63 - 45)
>>  #define CR0_EMERGENCY_SIGNAL_SUBMASK	_BITUL(63 - 49)
>>  #define CR0_EXTERNAL_CALL_SUBMASK	_BITUL(63 - 50)
>>  #define CR0_CLOCK_COMPARATOR_SUBMASK	_BITUL(63 - 52)
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index fcb55b02990e..5b5754d8f460 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -765,6 +765,14 @@ static int __must_check __deliver_prog(struct kvm_vcpu *vcpu)
>>  		break;
>>  	case PGM_VECTOR_PROCESSING:
>>  	case PGM_DATA:
>> +		if (vcpu->arch.sie_block->gcr[0] & CR0_AFP_REGISTER_CONTROL) {
>> +			/* make sure the new fpc will be lazily loaded */
>> +			save_fpu_regs();
>> +			/* the DXC/VXC cannot make the fpc invalid */
>> +			current->thread.fpu.fpc &= ~0xff00u;
>> +			current->thread.fpu.fpc |= (pgm_info.data_exc_code << 8)
>> +						   & 0xff00u;
> 
> Everything except that byte should be 0 anyway when it comes from
> lowcore, why do you mask?

User space can inject such an interrupt and could therefore set reserved
bits, leading to a crash (fpc invalid when loaded). E.g. via
kvm_s390_set_irq_state().

As of now, DXC/VXC is always 1byte. The other ones are to be stored as
0. (what we expect to always hold for now but user space can do crazy
things)

Thanks!

> 
>> +		}
>>  		rc = put_guest_lc(vcpu, pgm_info.data_exc_code,
>>  				  (u32 *)__LC_DATA_EXC_CODE);
>>  		break;
>>
> 
> 


-- 

Thanks,

David / dhildenb
