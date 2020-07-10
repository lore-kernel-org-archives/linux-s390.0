Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36104 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJIG7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 10 Jul 2020 04:06:59 -0400
Received: by mail-wr1-f70.google.com with SMTP id s16so5132875wrv.1
        for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2020 01:06:55 -0700 (PDT)
Subject: Re: [PATCH v6 0/5] clean up redundant 'kvm_run' parameters
References: <20200623131418.31473-1-tianjia.zhang@linux.alibaba.com>
 <6604e273-d7b1-5007-8721-75c4a4dec68e@linux.alibaba.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <433ae9a7-ee86-28ea-e600-8769f9759513@redhat.com>
Date: Fri, 10 Jul 2020 10:06:51 +0200
MIME-Version: 1.0
In-Reply-To: <6604e273-d7b1-5007-8721-75c4a4dec68e@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com, chenhuacai@gmail.com
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/07/20 09:32, Tianjia Zhang wrote:
> Hi Paolo,
> 
> Any opinion on this series patches? Can I help with this patchset ?

I was hoping to have some Tested-by, for now I'm queuing patches 1 and
2.  Thanks,

Paolo

> Thanks and best,
> Tianjia
> 
> On 2020/6/23 21:14, Tianjia Zhang wrote:
>> In the current kvm version, 'kvm_run' has been included in the 'kvm_vcpu'
>> structure. For historical reasons, many kvm-related function parameters
>> retain the 'kvm_run' and 'kvm_vcpu' parameters at the same time. This
>> patch does a unified cleanup of these remaining redundant parameters.
>>
>> This series of patches has completely cleaned the architecture of
>> arm64, mips, ppc, and s390 (no such redundant code on x86). Due to
>> the large number of modified codes, a separate patch is made for each
>> platform. On the ppc platform, there is also a redundant structure
>> pointer of 'kvm_run' in 'vcpu_arch', which has also been cleaned
>> separately.
>>
>> ---
>> v6 changes:
>>    Rearrange patch sets, only keep the unmerged patch.
>>    rebase on mainline.
>>
>> v5 change:
>>    ppc: fix for review.
>>
>> v4 change:
>>    mips: fixes two errors in entry.c.
>>
>> v3 change:
>>    Keep the existing `vcpu->run` in the function body unchanged.
>>
>> v2 change:
>>    s390 retains the original variable name and minimizes modification.
>>
>> Tianjia Zhang (5):
>>    KVM: s390: clean up redundant 'kvm_run' parameters
>>    KVM: arm64: clean up redundant 'kvm_run' parameters
>>    KVM: PPC: clean up redundant kvm_run parameters in assembly
>>    KVM: MIPS: clean up redundant 'kvm_run' parameters
>>    KVM: MIPS: clean up redundant kvm_run parameters in assembly
>>
>>   arch/arm64/include/asm/kvm_coproc.h   |  12 +--
>>   arch/arm64/include/asm/kvm_host.h     |  11 +--
>>   arch/arm64/include/asm/kvm_mmu.h      |   2 +-
>>   arch/arm64/kvm/arm.c                  |   6 +-
>>   arch/arm64/kvm/handle_exit.c          |  36 ++++----
>>   arch/arm64/kvm/mmio.c                 |  11 +--
>>   arch/arm64/kvm/mmu.c                  |   5 +-
>>   arch/arm64/kvm/sys_regs.c             |  13 ++-
>>   arch/mips/include/asm/kvm_host.h      |  32 ++------
>>   arch/mips/kvm/emulate.c               |  59 +++++--------
>>   arch/mips/kvm/entry.c                 |  21 ++---
>>   arch/mips/kvm/mips.c                  |  14 ++--
>>   arch/mips/kvm/trap_emul.c             | 114 +++++++++++---------------
>>   arch/mips/kvm/vz.c                    |  26 +++---
>>   arch/powerpc/include/asm/kvm_ppc.h    |   2 +-
>>   arch/powerpc/kvm/book3s_interrupts.S  |  22 +++--
>>   arch/powerpc/kvm/book3s_pr.c          |   9 +-
>>   arch/powerpc/kvm/booke.c              |   9 +-
>>   arch/powerpc/kvm/booke_interrupts.S   |   9 +-
>>   arch/powerpc/kvm/bookehv_interrupts.S |  10 +--
>>   arch/s390/kvm/kvm-s390.c              |  23 ++++--
>>   21 files changed, 188 insertions(+), 258 deletions(-)
>>
> 
