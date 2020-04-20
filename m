Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:35886 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgDTHOp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Apr 2020 03:14:45 -0400
Subject: Re: [PATCH] KVM: X86: Fix compile error in svm/sev.c
References: <20200419073047.14413-1-tianjia.zhang@linux.alibaba.com>
 <82ce1798-1dab-d271-d084-e9a89bb44e71@intel.com>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <8af45e72-2c68-7641-6968-70fad9c516b7@linux.alibaba.com>
Date: Mon, 20 Apr 2020 15:14:26 +0800
MIME-Version: 1.0
In-Reply-To: <82ce1798-1dab-d271-d084-e9a89bb44e71@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, tsbogend@alpha.franken.de, paulus@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, peterx@redhat.com, thuth@redhat.com
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 2020/4/19 16:24, Xiaoyao Li wrote:
> On 4/19/2020 3:30 PM, Tianjia Zhang wrote:
>> The compiler reported the following compilation errors:
>>
>> arch/x86/kvm/svm/sev.c: In function ‘sev_pin_memory’:
>> arch/x86/kvm/svm/sev.c:361:3: error: implicit declaration of function
>> ‘release_pages’ [-Werror=implicit-function-declaration]
>>     release_pages(pages, npinned);
>>     ^~~~~~~~~~~~~
>>
>> The reason is that the 'pagemap.h' header file is not included.
>>
> 
> FYI.
> 
> Boris has sent the Patch:
> https://lkml.kernel.org/r/20200411160927.27954-1-bp@alien8.de
> 
> and it's already in kvm master/queue branch
> 
> 

This is the same fix, please ignore this patch.

Thanks and best,
Tianjia
