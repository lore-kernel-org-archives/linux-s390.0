Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727381AbgBHO6K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Feb 2020 09:58:10 -0500
Subject: Re: [PATCH 09/35] KVM: s390: protvirt: Add KVM api documentation
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
 <20200207113958.7320-10-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7089ad6-65d2-35fc-16fb-b94e968fd4e8@redhat.com>
Date: Sat, 8 Feb 2020 15:57:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200207113958.7320-10-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 07/02/2020 12.39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
> 
> Add documentation for KVM_CAP_S390_PROTECTED capability and the
> KVM_S390_PV_COMMAND and KVM_S390_PV_COMMAND_VCPU ioctls.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/api.txt | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.txt b/Documentation/virt/kvm/api.txt
> index 73448764f544..4874d42286ca 100644
> --- a/Documentation/virt/kvm/api.txt
> +++ b/Documentation/virt/kvm/api.txt
> @@ -4204,6 +4204,60 @@ the clear cpu reset definition in the POP. However, the cpu is not put
>  into ESA mode. This reset is a superset of the initial reset.
>  
>  
> +4.125 KVM_S390_PV_COMMAND
> +
> +Capability: KVM_CAP_S390_PROTECTED
> +Architectures: s390
> +Type: vm ioctl
> +Parameters: struct kvm_pv_cmd
> +Returns: 0 on success, < 0 on error
> +
> +struct kvm_pv_cmd {
> +	__u32	cmd;	/* Command to be executed */
> +	__u16	rc;	/* Ultravisor return code */
> +	__u16	rrc;	/* Ultravisor return reason code */
> +	__u64	data;	/* Data or address */

That remindes me ... do we maybe want a "reserved" field in here for
future extensions? Or is the "data" pointer enough?

> +};
> +
> +cmd values:
> +KVM_PV_VM_CREATE
> +Allocate memory and register the VM with the Ultravisor, thereby
> +donating memory to the Ultravisor making it inaccessible to KVM.
> +
> +KVM_PV_VM_DESTROY
> +Deregisters the VM from the Ultravisor and frees memory that was
> +donated, so the kernel can use it again. All registered VCPUs have to
> +be unregistered beforehand and all memory has to be exported or
> +shared.
> +
> +KVM_PV_VM_SET_SEC_PARMS
> +Pass the image header from VM memory to the Ultravisor in preparation
> +of image unpacking and verification.
> +
> +KVM_PV_VM_UNPACK
> +Unpack (protect and decrypt) a page of the encrypted boot image.
> +
> +KVM_PV_VM_VERIFY
> +Verify the integrity of the unpacked image. Only if this succeeds, KVM
> +is allowed to start protected VCPUs.

You also don't mention rc and rrc here ... yet another indication that
it is unused?

 Thomas
