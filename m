Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1415628AbgDOQVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Apr 2020 12:21:20 -0400
Date: Wed, 15 Apr 2020 18:20:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] kvm_host: unify VM_STAT and VCPU_STAT definitions in
 a single place
Message-ID: <20200415182037.521a92b2.cohuck@redhat.com>
In-Reply-To: <20200414155625.20559-1-eesposit@redhat.com>
References: <20200414155625.20559-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: kvm@vger.kernel.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-s390@vger.kernel.org

On Tue, 14 Apr 2020 17:56:25 +0200
Emanuele Giuseppe Esposito <eesposit@redhat.com> wrote:

> The macros VM_STAT and VCPU_STAT are redundantly implemented in multiple
> files, each used by a different architecure to initialize the debugfs
> entries for statistics. Since they all have the same purpose, they can be
> unified in a single common definition in include/linux/kvm_host.h
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  arch/arm64/kvm/guest.c    |  23 ++---
>  arch/mips/kvm/mips.c      |  61 ++++++------
>  arch/powerpc/kvm/book3s.c |  61 ++++++------
>  arch/powerpc/kvm/booke.c  |  41 ++++----
>  arch/s390/kvm/kvm-s390.c  | 203 +++++++++++++++++++-------------------
>  arch/x86/kvm/x86.c        |  80 +++++++--------
>  include/linux/kvm_host.h  |   5 +
>  7 files changed, 231 insertions(+), 243 deletions(-)

Adds a bit of churn, but the end result does look nicer. Looks sane,
but did not review in detail.

Acked-by: Cornelia Huck <cohuck@redhat.com>
