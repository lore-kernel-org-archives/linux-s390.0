From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: add kvm_arch_cpu_kick
Date: Fri, 17 Feb 2017 18:07:02 +0100
Message-ID: <6cf497fd-f811-03b9-238e-787758ee4a0b@redhat.com>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
 <1487337007-91063-2-git-send-email-borntraeger@de.ibm.com>
 <20170217151227.GA27770@potion>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170217151227.GA27770@potion>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 17.02.2017 um 16:12 schrieb Radim Krčmář:
> 2017-02-17 14:10+0100, Christian Borntraeger:
>> needed by KVM common code.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kernel/smp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
>> index 4c9ebb3..a4d7124 100644
>> --- a/arch/s390/kernel/smp.c
>> +++ b/arch/s390/kernel/smp.c
>> @@ -513,6 +513,7 @@ void smp_send_reschedule(int cpu)
>>  {
>>  	pcpu_ec_call(pcpu_devices + cpu, ec_schedule);
>>  }
>> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
> 
> s390 doesn't want to use smp_send_reschedule() so I think the patch at
> the bottom is going in a better direction.
> 
> Btw. I think that we shouldn't be using smp_send_reschedule() for
> forcing VCPUs out of guest mode anyway -- the task we want to run is
> already scheduled and we don't want the schduler to do anything.
> 
> We could use smp_call_function() with an empty function instead, but
> that also has high overhead ... allocating a new IPI seems best.
> 
> But optimizing the current code is premature. :)
> 
> ---8<---
> s390 has a different mechanism from bringing the VCPU out of guest mode.
> Make the kick arch-specific.
> 
> Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
> ---
>  arch/arm/kvm/arm.c         | 5 +++++
>  arch/mips/kvm/mips.c       | 5 +++++
>  arch/powerpc/kvm/powerpc.c | 5 +++++
>  arch/s390/kvm/kvm-s390.c   | 6 ++++++
>  arch/x86/kvm/x86.c         | 5 +++++
>  include/linux/kvm_host.h   | 1 +
>  virt/kvm/kvm_main.c        | 2 +-
>  7 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 21c493a9e5c9..a52b0399fa43 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -97,6 +97,11 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
>  }
>  

That's what I had in mind. Looks good.

-- 
Thanks,

David
