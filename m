Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48118 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503327AbgDPJJA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 05:09:00 -0400
Subject: Re: [PATCH v2] KVM: Optimize kvm_arch_vcpu_ioctl_run function
References: <20200416051057.26526-1-tianjia.zhang@linux.alibaba.com>
 <878sivx67g.fsf@vitty.brq.redhat.com>
 <1000159f971a6fa3b5bd9e5871ce4d82@kernel.org>
 <8b92fb5b-5138-0695-fb90-6c36b8dfad00@linux.alibaba.com>
 <20200416105019.51191d79.cohuck@redhat.com>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <668a12b9-eda5-2d42-95f9-8d5e2990a465@linux.alibaba.com>
Date: Thu, 16 Apr 2020 17:08:51 +0800
MIME-Version: 1.0
In-Reply-To: <20200416105019.51191d79.cohuck@redhat.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com



On 2020/4/16 16:50, Cornelia Huck wrote:
> On Thu, 16 Apr 2020 16:45:33 +0800
> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
> 
>> On 2020/4/16 16:28, Marc Zyngier wrote:
>>> On 2020-04-16 08:03, Vitaly Kuznetsov wrote:
>>>> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> writes:
>>>>   
>>>>> In earlier versions of kvm, 'kvm_run' is an independent structure
>>>>> and is not included in the vcpu structure. At present, 'kvm_run'
>>>>> is already included in the vcpu structure, so the parameter
>>>>> 'kvm_run' is redundant.
>>>>>
>>>>> This patch simplify the function definition, removes the extra
>>>>> 'kvm_run' parameter, and extract it from the 'kvm_vcpu' structure
>>>>> if necessary.
>>>>>
>>>>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>>>>> ---
>>>>>
>>>>> v2 change:
>>>>>    remove 'kvm_run' parameter and extract it from 'kvm_vcpu'
>>>>>
>>>>>   arch/mips/kvm/mips.c       |  3 ++-
>>>>>   arch/powerpc/kvm/powerpc.c |  3 ++-
>>>>>   arch/s390/kvm/kvm-s390.c   |  3 ++-
>>>>>   arch/x86/kvm/x86.c         | 11 ++++++-----
>>>>>   include/linux/kvm_host.h   |  2 +-
>>>>>   virt/kvm/arm/arm.c         |  6 +++---
>>>>>   virt/kvm/kvm_main.c        |  2 +-
>>>>>   7 files changed, 17 insertions(+), 13 deletions(-)
> 
>>> Overall, there is a large set of cleanups to be done when both the vcpu
>>> and the run
>>> structures are passed as parameters at the same time. Just grepping the
>>> tree for
>>> kvm_run is pretty instructive.
>>>
>>>           M.
>>
>> Sorry, it's my mistake, I only compiled the x86 platform, I will submit
>> patch again.
> 
> I think it's completely fine (and even preferable) to do cleanups like
> that on top.
> 
> [FWIW, I compiled s390 here.]
> 

Very good, I will do a comprehensive cleanup of this type of code.

Thanks,
Tianjia
