Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44925 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727223AbgAJKKw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jan 2020 05:10:52 -0500
Subject: Re: [PATCH v5] KVM: s390: Add new reset vcpu API
References: <20200110094659.4118-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ecd8da3a-5232-6074-f123-196f744a8ba6@redhat.com>
Date: Fri, 10 Jan 2020 11:10:42 +0100
MIME-Version: 1.0
In-Reply-To: <20200110094659.4118-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

On 10/01/2020 10.46, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that on a normal reset.
> 
> Let's implement an interface for the missing normal and clear resets
> and reset all local IRQs, registers and control structures as stated
> in the architecture.
> 
> Userspace might already reset the registers via the vcpu run struct,
> but as we need the interface for the interrupt clearing part anyway,
> we implement the resets fully and don't rely on userspace to reset the
> rest.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.txt |  45 +++++++++++++
>  arch/s390/kvm/kvm-s390.c       | 111 +++++++++++++++++++++++----------
>  include/uapi/linux/kvm.h       |   5 ++
>  3 files changed, 127 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index ebb37b34dcfc..5203d95b1a21 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -4168,6 +4168,44 @@ This ioctl issues an ultravisor call to terminate the secure guest,
>  unpins the VPA pages and releases all the device pages that are used to
>  track the secure pages by hypervisor.
>  
> +4.122 KVM_S390_NORMAL_RESET
> +
> +Capability: KVM_CAP_S390_VCPU_RESETS
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures according to
> +the cpu reset definition in the POP (Principles Of Operation).
> +
> +4.123 KVM_S390_INITIAL_RESET
> +
> +Capability: none
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures according to
> +the initial cpu reset definition in the POP (Principles Of
> +Operation).

Nit: You "defined" POP already in the NORMAL_RESET section, so I'd
either only use the abbreviation here, or spell it out completely, but
not both again.

> However, the cpu is not put into ESA mode. This reset is a
> +superset of the normal reset.
> +
> +4.124 KVM_S390_CLEAR_RESET
> +
> +Capability: KVM_CAP_S390_VCPU_RESETS
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures according to
> +the clear cpu reset definition in the POP (Principles Of Operation).

dito

 Thomas
