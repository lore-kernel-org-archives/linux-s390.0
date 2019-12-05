Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729096AbfLEMTh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 07:19:37 -0500
Date: Thu, 5 Dec 2019 13:19:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3] KVM: s390: Add new reset vcpu API
Message-ID: <20191205131930.1b78f78b.cohuck@redhat.com>
In-Reply-To: <20191205120956.50930-1-frankja@linux.ibm.com>
References: <20191205120956.50930-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org

On Thu,  5 Dec 2019 07:09:56 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that. Now that we have a new interface, let's
> properly clear out local IRQs and let this commit be a reminder.

I'm still confused what this commit is supposed to be a reminder of :)

> 
> Also we add a ioctl for the clear reset to have all resets exposed to
> userspace. Currently the clear reset falls back to the initial reset,
> but we plan to have clear reset specific code in the future.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/virt/kvm/api.txt | 45 ++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c       | 14 +++++++++++
>  include/uapi/linux/kvm.h       |  5 ++++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index 4833904d32a5..3b62489308e0 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -4126,6 +4126,44 @@ Valid values for 'action':
>  #define KVM_PMU_EVENT_ALLOW 0
>  #define KVM_PMU_EVENT_DENY 1
>  
> +4.121 KVM_S390_NORMAL_RESET
> +
> +Capability: KVM_CAP_S390_VCPU_RESETS
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures that QEMU

s/QEMU/userspace/ (also below)

> +can't access via the kvm_run structure. The normal reset clears local
> +interrupts, the riccb and PSW bit 24.

What about:

"It is intended to be called when a normal reset is performed on the
vcpu and clears..."

> +
> +4.122 KVM_S390_INITIAL_RESET

Oh, we had never documented it before?

> +
> +Capability: none
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures that QEMU
> +can't access via the kvm_run structure. The initial reset is a
> +superset of the normal reset and additionally clears the psw, prefix,
> +timing related registers, as well as setting the control registers to
> +their initial value.

"It is intended to be called when an initial reset (which is a superset
of the normal reset) is performed on the vcpu and additionally
clears..."

?

> +
> +4.123 KVM_S390_CLEAR_RESET
> +
> +Capability: KVM_CAP_S390_VCPU_RESETS
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures that QEMU
> +can't access via the kvm_run structure. The clear reset is a superset
> +of the initial reset and additionally clears general, access, floating
> +and vector registers.

You can probably guess what I was going to write :)

>  
>  5. The kvm_run structure
>  ------------------------
> @@ -5322,3 +5360,10 @@ handling by KVM (as some KVM hypercall may be mistakenly treated as TLB
>  flush hypercalls by Hyper-V) so userspace should disable KVM identification
>  in CPUID and only exposes Hyper-V identification. In this case, guest
>  thinks it's running on Hyper-V and only use Hyper-V hypercalls.
> +
> +8.22 KVM_CAP_S390_VCPU_RESETS
> +
> +Architectures: s390
> +
> +This capability indicates that the KVM_S390_NORMAL_RESET and
> +KVM_S390_CLEAR_RESET ioctls are available.

(...)

The code looks good.
