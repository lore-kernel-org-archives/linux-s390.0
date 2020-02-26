Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726936AbgBZKix (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 05:38:53 -0500
Date: Wed, 26 Feb 2020 11:38:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
Message-ID: <20200226113840.46880055.cohuck@redhat.com>
In-Reply-To: <20200225214822.3611-1-borntraeger@de.ibm.com>
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
        <20200225214822.3611-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: david@redhat.com, Ulrich.Weigand@de.ibm.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

On Tue, 25 Feb 2020 16:48:22 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> This contains 3 main changes:
> 1. changes in SIE control block handling for secure guests
> 2. helper functions for create/destroy/unpack secure guests
> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
> machines
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/kvm_host.h |  24 ++-
>  arch/s390/include/asm/uv.h       |  69 ++++++++
>  arch/s390/kvm/Makefile           |   2 +-
>  arch/s390/kvm/kvm-s390.c         | 209 +++++++++++++++++++++++-
>  arch/s390/kvm/kvm-s390.h         |  33 ++++
>  arch/s390/kvm/pv.c               | 269 +++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h         |  31 ++++
>  7 files changed, 633 insertions(+), 4 deletions(-)
>  create mode 100644 arch/s390/kvm/pv.c

> +int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
> +{
> +		struct uv_cb_cgc uvcb = {

Broken indentation.

> +		.header.cmd = UVC_CMD_CREATE_SEC_CONF,
> +		.header.len = sizeof(uvcb)
> +	};
> +	int cc, ret;
> +	u16 dummy;
> +
> +	ret = kvm_s390_pv_alloc_vm(kvm);
> +	if (ret)
> +		return ret;
> +
> +	/* Inputs */
> +	uvcb.guest_stor_origin = 0; /* MSO is 0 for KVM */

What is 'MSO'? (i.e., where is that 'M' coming from?)

> +	uvcb.guest_stor_len = kvm->arch.pv.guest_len;
> +	uvcb.guest_asce = kvm->arch.gmap->asce;
> +	uvcb.guest_sca = (unsigned long)kvm->arch.sca;
> +	uvcb.conf_base_stor_origin = (u64)kvm->arch.pv.stor_base;
> +	uvcb.conf_virt_stor_origin = (u64)kvm->arch.pv.stor_var;
> +
> +	cc = uv_call(0, (u64)&uvcb);
> +	*rc = uvcb.header.rc;
> +	*rrc = uvcb.header.rrc;
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT CREATE VM: handle %llx len %llx rc %x rrc %x",
> +		     uvcb.guest_handle, uvcb.guest_stor_len, *rc, *rrc);
> +
> +	/* Outputs */
> +	kvm->arch.pv.handle = uvcb.guest_handle;

Is this valid if the call failed?

> +
> +	if (cc) {
> +		if (uvcb.header.rc & UVC_RC_NEED_DESTROY)
> +			kvm_s390_pv_deinit_vm(kvm, &dummy, &dummy);
> +		else
> +			kvm_s390_pv_dealloc_vm(kvm);
> +		return -EIO;
> +	}
> +	kvm->arch.gmap->guest_handle = uvcb.guest_handle;

...especially as you assign that handle only down here.

> +	atomic_set(&kvm->mm->context.is_protected, 1);
> +	return 0;
> +}
> +
> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, u16 *rc,
> +			      u16 *rrc)
> +{
> +	struct uv_cb_ssc uvcb = {
> +		.header.cmd = UVC_CMD_SET_SEC_CONF_PARAMS,
> +		.header.len = sizeof(uvcb),
> +		.sec_header_origin = (u64)hdr,
> +		.sec_header_len = length,
> +		.guest_handle = kvm_s390_pv_get_handle(kvm),
> +	};
> +	int cc = uv_call(0, (u64)&uvcb);
> +
> +	*rc = uvcb.header.rc;
> +	*rrc = uvcb.header.rrc;
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM SET PARMS: rc %x rrc %x",
> +		     *rc, *rrc);
> +	if (cc)
> +		return -EINVAL;
> +	return 0;

Maybe
	return cc ? -EINVAL : 0;

(I assume none of the possible rcs in this case could indicate
something that does not map to -EINVAL?)

> +}
