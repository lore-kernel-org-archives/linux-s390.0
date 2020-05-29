Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22350 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbgE2JsU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 29 May 2020 05:48:20 -0400
Received: by mail-wr1-f71.google.com with SMTP id 3so822222wrs.10
        for <linux-s390@vger.kernel.org>; Fri, 29 May 2020 02:48:16 -0700 (PDT)
Subject: Re: [PATCH v4 6/7] KVM: MIPS: clean up redundant 'kvm_run' parameters
References: <20200427043514.16144-1-tianjia.zhang@linux.alibaba.com>
 <20200427043514.16144-7-tianjia.zhang@linux.alibaba.com>
 <CAAhV-H7kpKUfQoWid6GSNL5+4hTTroGyL83EaW6yZwS2+Ti9kA@mail.gmail.com>
 <37246a25-c4dc-7757-3f5c-d46870a4f186@linux.alibaba.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30c2ac06-1a7e-2f85-fbe1-e9dc25bf2ae2@redhat.com>
Date: Fri, 29 May 2020 11:48:13 +0200
MIME-Version: 1.0
In-Reply-To: <37246a25-c4dc-7757-3f5c-d46870a4f186@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, Huacai Chen <chenhuacai@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, paulus@ozlabs.org, mpe@ellerman.id.au, Benjamin Herrenschmidt <benh@kernel.crashing.org>, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, sean.j.christopherson@intel.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com, Borislav Petkov <bp@alien8.de>, x86@kernel.org, hpa@zytor.com, Marc Zyngier <maz@kernel.org>, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, christoffer.dall@arm.com, Peter Xu <peterx@redhat.com>, thuth@redhat.com, kvm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.cs.columbia.edu, "open list:MIPS" <linux-mips@vger.kernel.org>, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 27/05/20 08:24, Tianjia Zhang wrote:
>>>
>>>
> 
> Hi Huacai,
> 
> These two patches(6/7 and 7/7) should be merged into the tree of the
> mips architecture separately. At present, there seems to be no good way
> to merge the whole architecture patchs.
> 
> For this series of patches, some architectures have been merged, some
> need to update the patch.

Hi Tianjia, I will take care of this during the merge window.

Thanks,

Paolo
