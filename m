Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] KVM: arm64: clean up redundant 'kvm_run'
 parameters
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-3-tianjia.zhang@linux.alibaba.com>
 <35eb095a344b4192b912385bc02c54e6@kernel.org>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <f093f6cf-4892-7c8f-d3aa-e908d5740cba@linux.alibaba.com>
Date: Thu, 7 May 2020 21:04:37 +0800
MIME-Version: 1.0
In-Reply-To: <35eb095a344b4192b912385bc02c54e6@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com, chenhuacai@gmail.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 2020/5/5 16:39, Marc Zyngier wrote:
> Hi Tianjia,
> 
> On 2020-04-27 05:35, Tianjia Zhang wrote:
>> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
>> structure. For historical reasons, many kvm-related function parameters
>> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
>> patch does a unified cleanup of these remaining redundant parameters.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> On the face of it, this looks OK, but I haven't tried to run the
> resulting kernel. I'm not opposed to taking this patch *if* there
> is an agreement across architectures to take the series (I value
> consistency over the janitorial exercise).
> 
> Another thing is that this is going to conflict with the set of
> patches that move the KVM/arm code back where it belongs (arch/arm64/kvm),
> so I'd probably cherry-pick that one directly.
> 
> Thanks,
> 
>          M.
> 

Do I need to submit this set of patches separately for each 
architecture? Could it be merged at once, if necessary, I will
resubmit based on the latest mainline.

Thanks,
Tianjia
