Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56207 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387970AbgFXCjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jun 2020 22:39:47 -0400
Subject: Re: [PATCH v6 1/5] KVM: s390: clean up redundant 'kvm_run' parameters
References: <20200623131418.31473-1-tianjia.zhang@linux.alibaba.com>
 <20200623131418.31473-2-tianjia.zhang@linux.alibaba.com>
 <c49f8814-c7ea-6884-91c5-3dcd40c6509f@de.ibm.com>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <650c2193-5299-714e-92f4-75cbff319948@linux.alibaba.com>
Date: Wed, 24 Jun 2020 10:39:39 +0800
MIME-Version: 1.0
In-Reply-To: <c49f8814-c7ea-6884-91c5-3dcd40c6509f@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com, chenhuacai@gmail.com
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 2020/6/23 23:31, Christian Borntraeger wrote:
> 
> 
> On 23.06.20 15:14, Tianjia Zhang wrote:
>> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
>> structure. For historical reasons, many kvm-related function parameters
>> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
>> patch does a unified cleanup of these remaining redundant parameters.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 23 +++++++++++++++--------
>>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> Tinajia,
> 
> I have trouble seeing value in this particular patch. We add LOCs
> without providing any noticable benefit. All other patches in this series at
> least reduce the amount of code. So I would defer this to Paolo if he prefers
> to have this way across all architectures.

Yes, this is a full architecture optimization. Some of the architecture 
optimization has been merged into the mainline. I think it is necessary 
to unify this optimization. This is also the meaning of Paolo.
You can refer to the email of the previous version:
https://lkml.org/lkml/2020/4/27/16

Thanks,
Tianjia
