Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729260AbfLEMuV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 07:50:21 -0500
Subject: Re: [PATCH v4] KVM: s390: Add new reset vcpu API
References: <20191205131930.1b78f78b.cohuck@redhat.com>
 <20191205122810.10672-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <081eebc2-fbe4-d928-ad54-7e90fa06e0b2@redhat.com>
Date: Thu, 5 Dec 2019 13:50:13 +0100
MIME-Version: 1.0
In-Reply-To: <20191205122810.10672-1-frankja@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org

On 05/12/2019 13.28, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that. Now that we have a new interface, let's
> properly clear out local IRQs.
>=20
> Also we add a ioctl for the clear reset to have all resets exposed to
> userspace. Currently the clear reset falls back to the initial reset,
> but we plan to have clear reset specific code in the future.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/virt/kvm/api.txt | 48 ++++++++++++++++++++++++++++++++++
>  arch/s390/kvm/kvm-s390.c       | 14 ++++++++++
>  include/uapi/linux/kvm.h       |  5 ++++
>  3 files changed, 67 insertions(+)
[...]
> +4.123 KVM_S390_CLEAR_RESET
> +
> +Capability: KVM_CAP_S390_VCPU_RESETS
> +Architectures: s390
> +Type: vcpu ioctl
> +Parameters: none
> +Returns: 0
> +
> +This ioctl resets VCPU registers and control structures that userspace
> +can't access via the kvm_run structure. It is intended to be called
> +when an initial reset (which is a superset of the normal reset) is
> +performed on the vcpu and additionally clears general, access,
> +floating and vector registers.

So now you've documented that this ioctl clears the GPRs, ARs and
FRs/VRs ... but the implementation does not! That's quite ugly.
Can you please state clearly that it is the job of userspace to clear
these registers (in the default, non-protected case) and that this ioctl
should be called on top?

Same problem with the PSW bit 24 and riccb during normal reset.

Or should the kernel code maybe also clear these in addition to
userspace, just to be in line with the initial reset?

 Thomas
