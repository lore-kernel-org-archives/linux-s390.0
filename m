Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] KVM: X86: Fix compile error in svm/sev.c
References: <20200419073047.14413-1-tianjia.zhang@linux.alibaba.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <82ce1798-1dab-d271-d084-e9a89bb44e71@intel.com>
Date: Sun, 19 Apr 2020 16:24:19 +0800
MIME-Version: 1.0
In-Reply-To: <20200419073047.14413-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/19/2020 3:30 PM, Tianjia Zhang wrote:
> The compiler reported the following compilation errors:
> 
> arch/x86/kvm/svm/sev.c: In function ‘sev_pin_memory’:
> arch/x86/kvm/svm/sev.c:361:3: error: implicit declaration of function
> ‘release_pages’ [-Werror=implicit-function-declaration]
>     release_pages(pages, npinned);
>     ^~~~~~~~~~~~~
> 
> The reason is that the 'pagemap.h' header file is not included.
> 

FYI.

Boris has sent the Patch:
https://lkml.kernel.org/r/20200411160927.27954-1-bp@alien8.de

and it's already in kvm master/queue branch
