Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgEEIkC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 04:40:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 05 May 2020 09:39:59 +0100
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 2/7] KVM: arm64: clean up redundant 'kvm_run'
 parameters
In-Reply-To: <20200427043514.16144-3-tianjia.zhang@linux.alibaba.com>
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-3-tianjia.zhang@linux.alibaba.com>
Message-ID: <35eb095a344b4192b912385bc02c54e6@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com, chenhuacai@gmail.com, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tianjia,

On 2020-04-27 05:35, Tianjia Zhang wrote:
> In the current kvm version, 'kvm_run' has been included in the 
> 'kvm_vcpu'
> structure. For historical reasons, many kvm-related function parameters
> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
> patch does a unified cleanup of these remaining redundant parameters.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

On the face of it, this looks OK, but I haven't tried to run the
resulting kernel. I'm not opposed to taking this patch *if* there
is an agreement across architectures to take the series (I value
consistency over the janitorial exercise).

Another thing is that this is going to conflict with the set of
patches that move the KVM/arm code back where it belongs 
(arch/arm64/kvm),
so I'd probably cherry-pick that one directly.

Thanks,

         M.


-- 
Jazz is not dead. It just smells funny...
