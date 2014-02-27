From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/3] KVM: add kvm_arch_vcpu_runnable() test to kvm_vcpu_on_spin()
 loop
Date: Thu, 27 Feb 2014 19:20:33 +0100
Message-ID: <530F81F1.5050109@redhat.com>
References: <1393427659-42501-1-git-send-email-borntraeger@de.ibm.com>	<1393427659-42501-3-git-send-email-borntraeger@de.ibm.com> <CAC4Lta32puDyAYXppVJT-nk2=xL1jZh82sWNnZNTrTfJtf0gMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <CAC4Lta32puDyAYXppVJT-nk2=xL1jZh82sWNnZNTrTfJtf0gMw@mail.gmail.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Raghavendra KT <raghavendra.kt.linux@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Il 27/02/2014 19:11, Raghavendra KT ha scritto:
> On Wed, Feb 26, 2014 at 8:44 PM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> From: Michael Mueller <mimu@linux.vnet.ibm.com>
>>
>> Use the arch specific function kvm_arch_vcpu_runnable() to add a further
>> criterium to identify a suitable vcpu to yield to during undirected yield
>> processing.
>>
>> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  virt/kvm/kvm_main.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index f5668a4..5fd4cf8 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -1801,7 +1801,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
>>                                 continue;
>>                         if (vcpu == me)
>>                                 continue;
>> -                       if (waitqueue_active(&vcpu->wq))
>> +                       if (waitqueue_active(&vcpu->wq) && !kvm_arch_vcpu_runnable(vcpu))
>>                                 continue;
>>                         if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
>>                                 continue;
>> --
>> 1.8.4.2
>>
>
> I ran kernbench/sysbench/ebizzy on x86 guest to confirm that this did
> not have any adverse effect in ple handler path.

Thanks!

Paolo
