Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436522AbgDNIVD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 04:21:03 -0400
Received: by mail-wr1-f71.google.com with SMTP id r11so7239420wrx.21
        for <linux-s390@vger.kernel.org>; Tue, 14 Apr 2020 01:19:02 -0700 (PDT)
Subject: Re: [PATCH] kvm_host: unify VM_STAT and VCPU_STAT definitions in a
 single place
References: <20200413140332.22896-1-eesposit@redhat.com>
 <03a481a8-bcf2-8755-d113-71ef393508bf@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf870876-9f9a-7ba8-d941-a3883e519eed@redhat.com>
Date: Tue, 14 Apr 2020 10:18:58 +0200
MIME-Version: 1.0
In-Reply-To: <03a481a8-bcf2-8755-d113-71ef393508bf@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Emanuele Giuseppe Esposito <eesposit@redhat.com>, kvm@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

On 13/04/20 23:34, Philippe Mathieu-Daudé wrote:
>> +#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
>> +#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__
> I find this macro expanding into multiple fields odd... Maybe a matter
> of taste. Sugggestion, have the macro define the full structure, as in
> the arm64 arch:
> 
> #define VM_STAT(n, x, ...) { n, offsetof(struct kvm, stat.x),
> KVM_STAT_VM, ## __VA_ARGS__ }
> 
> Ditto for VCPU_STAT().
> 

Yes, that's a good idea.  Emanuele, can you switch it to this format?

Thanks,

Paolo
