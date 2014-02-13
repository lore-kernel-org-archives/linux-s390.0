From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 2/3] s390/kvm: Platform specific kvm_arch_vcpu_dont_yield
Date: Thu, 13 Feb 2014 23:54:15 +0100
Message-ID: <52FD4D17.10307@de.ibm.com>
References: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com> <1392119132-50182-3-git-send-email-borntraeger@de.ibm.com> <52FD4913.3000107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52FD4913.3000107@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 13/02/14 23:37, Paolo Bonzini wrote:
> Il 11/02/2014 12:45, Christian Borntraeger ha scritto:
>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
>>
>> Commit "s390/kvm: Use common waitqueue" caused a performance regression
>> on s390. It turned out that a yield candidate was missed by just a simple
>> test on its non-empty waitqueue. If an interrupt is outstanding, the candidate
>> might be suitable. kvm_arch_vcpu_dont_yield is extended by a test that
>> additionally tests for not yet delivered interrupts.
>>
>> Significant performance measurement work and code analysis to solve
>> this issue was provided by Mao Chuan Li and his team in Beijing.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/Kconfig    | 1 +
>>  arch/s390/kvm/kvm-s390.c | 7 +++++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
>> index c8bacbc..e44adef 100644
>> --- a/arch/s390/kvm/Kconfig
>> +++ b/arch/s390/kvm/Kconfig
>> @@ -25,6 +25,7 @@ config KVM
>>      select HAVE_KVM_EVENTFD
>>      select KVM_ASYNC_PF
>>      select KVM_ASYNC_PF_SYNC
>> +    select HAVE_KVM_ARCH_VCPU_DONT_YIELD
>>      ---help---
>>        Support hosting paravirtualized guest machines using the SIE
>>        virtualization capability on the mainframe. This should work
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index a5da2cc..1a33e1e 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1231,6 +1231,13 @@ int kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
>>      return VM_FAULT_SIGBUS;
>>  }
>>
>> +#ifdef CONFIG_HAVE_KVM_ARCH_VCPU_DONT_YIELD
>> +bool kvm_arch_vcpu_dont_yield(struct kvm_vcpu *vcpu)
>> +{
>> +    return waitqueue_active(&vcpu->wq) && !kvm_cpu_has_interrupt(vcpu);
>> +}
>> +#endif
> 
> I wonder if just using "&& !kvm_arch_vcpu_runnable(vcpu)" in kvm_vcpu_on_spin would be better.
> 
> Right now, you do not need it in s390 because kvm_vcpu_block is not used either.  But you could simply define it to kvm_cpu_has_interrupt(vcpu) instead.
> 
> Paolo

We had several variants but in the end we tried to come up with a patch that does not
influence other architectures. Your proposal would certainly be fine for s390,
but what impact does it have on x86, arm, arm64? Will it cause performance regressions?
So I think that the patch as is is probably the safest choice until we have some
data from x86, arm, arm64, no?

Christian
