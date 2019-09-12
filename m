Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730982AbfILLXp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 07:23:45 -0400
Subject: Re: [PATCH] KVM: s390: Do not leak kernel stack data in the
 KVM_S390_INTERRUPT ioctl
References: <20190912090050.20295-1-thuth@redhat.com>
 <6905df78-95f0-3d6d-aaae-910cd2d7a232@redhat.com>
 <253e67f6-0a41-13e8-4ca2-c651d5fcdb69@redhat.com>
 <f9d07b66-a048-6626-e209-9fe455a2bed3@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <239c8d0f-40fb-264a-bc10-445931a3cd9a@redhat.com>
Date: Thu, 12 Sep 2019 13:23:38 +0200
MIME-Version: 1.0
In-Reply-To: <f9d07b66-a048-6626-e209-9fe455a2bed3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/09/2019 12.52, Christian Borntraeger wrote:
> 
> 
> On 12.09.19 11:20, Thomas Huth wrote:
>> On 12/09/2019 11.14, David Hildenbrand wrote:
>>> On 12.09.19 11:00, Thomas Huth wrote:
>>>> When the userspace program runs the KVM_S390_INTERRUPT ioctl to inject
>>>> an interrupt, we convert them from the legacy struct kvm_s390_interrupt
>>>> to the new struct kvm_s390_irq via the s390int_to_s390irq() function.
>>>> However, this function does not take care of all types of interrupts
>>>> that we can inject into the guest later (see do_inject_vcpu()). Since we
>>>> do not clear out the s390irq values before calling s390int_to_s390irq(),
>>>> there is a chance that we copy unwanted data from the kernel stack
>>>> into the guest memory later if the interrupt data has not been properly
>>>> initialized by s390int_to_s390irq().
>>>>
>>>> Specifically, the problem exists with the KVM_S390_INT_PFAULT_INIT
>>>> interrupt: s390int_to_s390irq() does not handle it, but the function
>>>> __deliver_pfault_init() will later copy the uninitialized stack data
>>>> from the ext.ext_params2 into the guest memory.
>>>>
>>>> Fix it by handling that interrupt type in s390int_to_s390irq(), too.
>>>> And while we're at it, make sure that s390int_to_s390irq() now
>>>> directly returns -EINVAL for unknown interrupt types, so that we
>>>> do not run into this problem again in case we add more interrupt
>>>> types to do_inject_vcpu() sometime in the future.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>>  arch/s390/kvm/interrupt.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>>>> index 3e7efdd9228a..165dea4c7f19 100644
>>>> --- a/arch/s390/kvm/interrupt.c
>>>> +++ b/arch/s390/kvm/interrupt.c
>>>> @@ -1960,6 +1960,16 @@ int s390int_to_s390irq(struct kvm_s390_interrupt *s390int,
>>>>  	case KVM_S390_MCHK:
>>>>  		irq->u.mchk.mcic = s390int->parm64;
>>>>  		break;
>>>> +	case KVM_S390_INT_PFAULT_INIT:
>>>> +		irq->u.ext.ext_params = s390int->parm;
>>>> +		irq->u.ext.ext_params2 = s390int->parm64;
>>>> +		break;
>>>> +	case KVM_S390_RESTART:
>>>> +	case KVM_S390_INT_CLOCK_COMP:
>>>> +	case KVM_S390_INT_CPU_TIMER:
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>>  	}
>>>>  	return 0;
>>>>  }
>>>>
>>>
>>> Wouldn't a safe fix be to initialize the struct to zero in the caller?
>>
>> That's of course possible, too. But that means that we always have to
>> zero out the whole structure, so that's a little bit more of overhead
>> (well, it likely doesn't matter for such a legacy ioctl).
> 
> Yes doing something like
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c19a24e940a1..b1f6f434af5d 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4332,7 +4332,7 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp,
>         }
>         case KVM_S390_INTERRUPT: {
>                 struct kvm_s390_interrupt s390int;
> -               struct kvm_s390_irq s390irq;
> +               struct kvm_s390_irq s390irq = {};
>  
>                 if (copy_from_user(&s390int, argp, sizeof(s390int)))
>                         return -EFAULT;
> 
> would certainly be ok as well, but

I don't think that it's urgently necessary, but ok, if you all prefer to
have it, too, I can add it to my patch.

>> But the more important question: Do we then still care of fixing the
>> PFAULT_INIT interrupt here? Since it requires a parameter, the "case
>> KVM_S390_INT_PFAULT_INIT:" part would be required here anyway.
> 
> as long as we we this interface we should fix it and we should do the
> pfault thing correctly. 
> Maybe we should start to deprecate this interface and remove it.

Hmm, we already talked about deprecating support for pre-3.15 kernel
stuff in the past (see
https://wiki.qemu.org/ChangeLog/2.12#Future_incompatible_changes for
example), since this has been broken in QEMU since quite a while, but
the new KVM_S390_IRQ replacement has just been introduced with kernel
4.1 ... so removing this KVM_S390_INTERRUPT ioctl any time soon sounds
wrong to me, we might break some userspace programs that are still there
in the wild...

 Thomas
