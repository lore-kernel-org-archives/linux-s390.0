Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726298AbgBRJMf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Feb 2020 04:12:35 -0500
Subject: Re: [PATCH v2.1] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-10-borntraeger@de.ibm.com>
 <20200218083946.44720-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <42deaa19-d2ca-f1cc-3e83-af0d5d77347f@redhat.com>
Date: Tue, 18 Feb 2020 10:12:26 +0100
MIME-Version: 1.0
In-Reply-To: <20200218083946.44720-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

On 18.02.20 09:39, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>=20
> This contains 3 main changes:
> 1. changes in SIE control block handling for secure guests
> 2. helper functions for create/destroy/unpack secure guests
> 3. KVM_S390_PV_COMMAND ioctl to allow userspace dealing with secure
> machines
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
> 2->2.1  - combine CREATE/DESTROY CPU/VM into ENABLE DISABLE
> 	- rework locking and check locks with lockdep
> 	- I still have the PV_COMMAND_CPU in here for later use in
> 	  the SET_IPL_PSW ioctl. If wanted I can move

I'd prefer to move, and eventually just turn this into a clean, separate
ioctl without subcommands (e.g., if we'll only need a single subcommand
in the near future). And it makes this patch a alittle easier to review
... :)

[...]

>  obj-$(CONFIG_KVM) +=3D kvm.o
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index cc7793525a69..1a7bb08f5c26 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -44,6 +44,7 @@
>  #include <asm/cpacf.h>
>  #include <asm/timex.h>
>  #include <asm/ap.h>
> +#include <asm/uv.h>
>  #include "kvm-s390.h"
>  #include "gaccess.h"
> =20
> @@ -234,8 +235,10 @@ int kvm_arch_check_processor_compat(void)
>  	return 0;
>  }
> =20
> +/* forward declarations */
>  static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
>  			      unsigned long end);
> +static int sca_switch_to_extended(struct kvm *kvm);
> =20
>  static void kvm_clock_sync_scb(struct kvm_s390_sie_block *scb, u64 del=
ta)
>  {
> @@ -571,6 +574,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, l=
ong ext)
>  	case KVM_CAP_S390_BPB:
>  		r =3D test_facility(82);
>  		break;
> +	case KVM_CAP_S390_PROTECTED:
> +		r =3D is_prot_virt_host();
> +		break;
>  	default:
>  		r =3D 0;
>  	}
> @@ -2165,6 +2171,152 @@ static int kvm_s390_set_cmma_bits(struct kvm *k=
vm,
>  	return r;
>  }
> =20
> +static int kvm_s390_switch_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
> +{
> +	int i, r =3D 0;
> +
> +	struct kvm_vcpu *vcpu;
> +

Once we lock the VCPU, it cannot be running, right?

> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		mutex_lock(&vcpu->mutex);
> +		r =3D kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
> +		mutex_unlock(&vcpu->mutex);
> +		if (r)
> +			break;
> +	}

Can this actually ever fail? If so, you would leave half-initialized
state around. Warn and continue?

Especially, kvm_arch_vcpu_destroy() ignores any error from
kvm_s390_pv_destroy_cpu() as well ...

IMHO, we should make kvm_s390_switch_from_pv() and
kvm_s390_pv_destroy_cpu() never fail.

> +	return r;
> +}
> +
> +static int kvm_s390_switch_to_pv(struct kvm *kvm, u16 *rc, u16 *rrc)
> +{
> +	int i, r =3D 0;
> +	u16 dummy;
> +
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		mutex_lock(&vcpu->mutex);
> +		r =3D kvm_s390_pv_create_cpu(vcpu, rc, rrc);
> +		mutex_unlock(&vcpu->mutex);
> +		if (r)
> +			break;
> +	}
> +	if (r)
> +		kvm_s390_switch_from_pv(kvm,&dummy, &dummy);
> +	return r;
> +}
> +
> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
> +{
> +	int r =3D 0;
> +	u16 dummy;
> +	void __user *argp =3D (void __user *)cmd->data;
> +
> +	switch (cmd->cmd) {
> +	case KVM_PV_ENABLE: {
> +		r =3D -EINVAL;
> +		if (kvm_s390_pv_is_protected(kvm))
> +			break;

Why not factor out this check, it's common for all sucommands.

> +
> +		r =3D kvm_s390_pv_alloc_vm(kvm);
> +		if (r)
> +			break;
> +
> +		kvm_s390_vcpu_block_all(kvm);

As kvm_s390_vcpu_block_all() does not support nesting, this will not
work as expected - sca_switch_to_extended() already blocks. Are the
vcpu->locks not enough?

> +		/* FMT 4 SIE needs esca */
> +		r =3D sca_switch_to_extended(kvm);
> +		if (r) {
> +			kvm_s390_pv_dealloc_vm(kvm);
> +			kvm_s390_vcpu_unblock_all(kvm);
> +			mutex_unlock(&kvm->lock);
> +			break;
> +		}
> +		r =3D kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);
> +		if (!r)
> +			r =3D kvm_s390_switch_to_pv(kvm, &cmd->rc, &cmd->rrc);
> +		if (r)
> +			kvm_s390_pv_destroy_vm(kvm, &dummy, &dummy);
> +
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		break;
> +	}
> +	case KVM_PV_DISABLE: {
> +		r =3D -EINVAL;
> +		if (!kvm_s390_pv_is_protected(kvm))
> +			break;
> +
> +		kvm_s390_vcpu_block_all(kvm);

Won't taking the vcpu lock achieve a similar goal (VCPU can't be running)=
.

> +		r =3D kvm_s390_switch_from_pv(kvm, &cmd->rc, &cmd->rrc);
> +		if (!r)
> +			r =3D kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
> +		if (!r)
> +			kvm_s390_pv_dealloc_vm(kvm);
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		break;
> +	}

[...]

> @@ -2558,10 +2735,16 @@ static void kvm_free_vcpus(struct kvm *kvm)
> =20
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> +	u16 rc, rrc;
>  	kvm_free_vcpus(kvm);
>  	sca_dispose(kvm);
> -	debug_unregister(kvm->arch.dbf);
>  	kvm_s390_gisa_destroy(kvm);
> +	/* do not use the lock checking variant at tear-down */
> +	if (kvm_s390_pv_handle(kvm)) {

kvm_s390_pv_is_protected ? I dislike using kvm_s390_pv_handle() when
we're not interested in the handle.

> +		kvm_s390_pv_destroy_vm(kvm, &rc, &rrc);
> +		kvm_s390_pv_dealloc_vm(kvm);
> +	}
> +	debug_unregister(kvm->arch.dbf);
>  	free_page((unsigned long)kvm->arch.sie_page2);
>  	if (!kvm_is_ucontrol(kvm))
>  		gmap_remove(kvm->arch.gmap);

[...]

> +/* implemented in pv.c */
> +void kvm_s390_pv_dealloc_vm(struct kvm *kvm);
> +int kvm_s390_pv_alloc_vm(struct kvm *kvm);
> +int kvm_s390_pv_create_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
> +int kvm_s390_pv_create_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc);
> +int kvm_s390_pv_destroy_vm(struct kvm *kvm, u16 *rc, u16 *rrc);
> +int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc);
> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, =
u16 *rc,
> +			      u16 *rrc);
> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned l=
ong size,
> +		       unsigned long tweak, u16 *rc, u16 *rrc);
> +
> +static inline u64 kvm_s390_pv_handle(struct kvm *kvm)
> +{
> +	return kvm->arch.pv.handle;
> +}

Can we rename this to

kvm_s390_pv_get_handle()

> +
> +static inline u64 kvm_s390_pv_handle_cpu(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.pv.handle;
> +}

Can we rename this to kvm_s390_pv_cpu_get_handle() ? (so it doesn't look
like the function will handle something)

> +
> +static inline bool kvm_s390_pv_is_protected(struct kvm *kvm)
> +{
> +	lockdep_assert_held(&kvm->lock);
> +	return !!kvm_s390_pv_handle(kvm);
> +}
> +
> +static inline bool kvm_s390_pv_cpu_is_protected(struct kvm_vcpu *vcpu)
> +{
> +	lockdep_assert_held(&vcpu->mutex);
> +	return !!kvm_s390_pv_handle_cpu(vcpu);
> +}
> +
>  /* implemented in interrupt.c */
>  int kvm_s390_handle_wait(struct kvm_vcpu *vcpu);
>  void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu);
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> new file mode 100644
> index 000000000000..bf00cde1ead8
> --- /dev/null
> +++ b/arch/s390/kvm/pv.c
> @@ -0,0 +1,262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hosting Secure Execution virtual machines
> + *
> + * Copyright IBM Corp. 2019
> + *    Author(s): Janosch Frank <frankja@linux.ibm.com>
> + */
> +#include <linux/kvm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/pagemap.h>
> +#include <linux/sched/signal.h>
> +#include <asm/pgalloc.h>
> +#include <asm/gmap.h>
> +#include <asm/uv.h>
> +#include <asm/gmap.h>
> +#include <asm/mman.h>
> +#include "kvm-s390.h"
> +
> +void kvm_s390_pv_dealloc_vm(struct kvm *kvm)
> +{
> +	vfree(kvm->arch.pv.stor_var);
> +	free_pages(kvm->arch.pv.stor_base,
> +		   get_order(uv_info.guest_base_stor_len));
> +	memset(&kvm->arch.pv, 0, sizeof(kvm->arch.pv));
> +}
> +
> +int kvm_s390_pv_alloc_vm(struct kvm *kvm)
> +{
> +	unsigned long base =3D uv_info.guest_base_stor_len;
> +	unsigned long virt =3D uv_info.guest_virt_var_stor_len;
> +	unsigned long npages =3D 0, vlen =3D 0;
> +	struct kvm_memory_slot *memslot;
> +
> +	kvm->arch.pv.stor_var =3D NULL;
> +	kvm->arch.pv.stor_base =3D __get_free_pages(GFP_KERNEL, get_order(bas=
e));
> +	if (!kvm->arch.pv.stor_base)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Calculate current guest storage for allocation of the
> +	 * variable storage, which is based on the length in MB.
> +	 *
> +	 * Slots are sorted by GFN
> +	 */
> +	mutex_lock(&kvm->slots_lock);
> +	memslot =3D kvm_memslots(kvm)->memslots;
> +	npages =3D memslot->base_gfn + memslot->npages;
> +	mutex_unlock(&kvm->slots_lock);

Are you blocking the addition of new memslots somehow?

> +int kvm_s390_pv_create_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
> +{
> +	u16 drc, drrc;
> +	int cc;
> +
> +	struct uv_cb_cgc uvcb =3D {
> +		.header.cmd =3D UVC_CMD_CREATE_SEC_CONF,
> +		.header.len =3D sizeof(uvcb)
> +	};
> +
> +	if (kvm_s390_pv_handle(kvm))

Why is that necessary? We should only be called in PV mode.

> +		return -EINVAL;
> +
> +	/* Inputs */
> +	uvcb.guest_stor_origin =3D 0; /* MSO is 0 for KVM */
> +	uvcb.guest_stor_len =3D kvm->arch.pv.guest_len;
> +	uvcb.guest_asce =3D kvm->arch.gmap->asce;
> +	uvcb.guest_sca =3D (unsigned long)kvm->arch.sca;
> +	uvcb.conf_base_stor_origin =3D (u64)kvm->arch.pv.stor_base;
> +	uvcb.conf_virt_stor_origin =3D (u64)kvm->arch.pv.stor_var;
> +
> +	cc =3D uv_call(0, (u64)&uvcb);
> +	*rc =3D uvcb.header.rc;
> +	*rrc =3D uvcb.header.rrc;
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT CREATE VM: handle %llx len %llx rc %x =
rrc %x",
> +		     uvcb.guest_handle, uvcb.guest_stor_len, *rc, *rrc);
> +
> +	/* Outputs */
> +	kvm->arch.pv.handle =3D uvcb.guest_handle;
> +
> +	if (cc && (uvcb.header.rc & UVC_RC_NEED_DESTROY)) {
> +		kvm_s390_pv_destroy_vm(kvm, &drc, &drrc);
> +		return -EINVAL;
> +	}
> +	kvm->arch.gmap->guest_handle =3D uvcb.guest_handle;
> +	atomic_set(&kvm->mm->context.is_protected, 1);
> +	return cc;
> +}
> +
> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, =
u16 *rc,
> +			      u16 *rrc)
> +{
> +	struct uv_cb_ssc uvcb =3D {
> +		.header.cmd =3D UVC_CMD_SET_SEC_CONF_PARAMS,
> +		.header.len =3D sizeof(uvcb),
> +		.sec_header_origin =3D (u64)hdr,
> +		.sec_header_len =3D length,
> +		.guest_handle =3D kvm_s390_pv_handle(kvm),
> +	};
> +	int cc;
> +
> +	if (!kvm_s390_pv_handle(kvm))

Why is that necessary? We should only be called in PV mode.

> +		return -EINVAL;
> +
> +	cc =3D uv_call(0, (u64)&uvcb);
> +	*rc =3D uvcb.header.rc;
> +	*rrc =3D uvcb.header.rrc;
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM SET PARMS: rc %x rrc %x",
> +		     uvcb.header.rc, uvcb.header.rrc);
> +	if (cc)
> +		return -EINVAL;
> +	return 0;
> +}

[...]

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4b95f9a31a2f..50d393a618a4 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1010,6 +1010,7 @@ struct kvm_ppc_resize_hpt {
>  #define KVM_CAP_ARM_NISV_TO_USER 177
>  #define KVM_CAP_ARM_INJECT_EXT_DABT 178
>  #define KVM_CAP_S390_VCPU_RESETS 179
> +#define KVM_CAP_S390_PROTECTED 180
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20
> @@ -1478,6 +1479,40 @@ struct kvm_enc_region {
>  #define KVM_S390_NORMAL_RESET	_IO(KVMIO,   0xc3)
>  #define KVM_S390_CLEAR_RESET	_IO(KVMIO,   0xc4)
> =20
> +struct kvm_s390_pv_sec_parm {
> +	__u64	origin;
> +	__u64	length;

tabs vs. spaces. (I'd use a single space like in kvm_s390_pv_unp below)

> +};
> +
> +struct kvm_s390_pv_unp {
> +	__u64 addr;
> +	__u64 size;
> +	__u64 tweak;
> +};
> +
> +enum pv_cmd_id {
> +	KVM_PV_ENABLE,
> +	KVM_PV_DISABLE,
> +	KVM_PV_VM_SET_SEC_PARMS,
> +	KVM_PV_VM_UNPACK,
> +	KVM_PV_VM_VERIFY,
> +	KVM_PV_VCPU_CREATE,
> +	KVM_PV_VCPU_DESTROY,
> +};
> +
> +struct kvm_pv_cmd {
> +	__u32 cmd;	/* Command to be executed */
> +	__u16 rc;	/* Ultravisor return code */
> +	__u16 rrc;	/* Ultravisor return reason code */
> +	__u64 data;	/* Data or address */
> +	__u32 flags;    /* flags for future extensions. Must be 0 for now */
> +	__u32 reserved[3];
> +};
> +
> +/* Available with KVM_CAP_S390_PROTECTED */
> +#define KVM_S390_PV_COMMAND		_IOWR(KVMIO, 0xc5, struct kvm_pv_cmd)
> +#define KVM_S390_PV_COMMAND_VCPU	_IOWR(KVMIO, 0xc6, struct kvm_pv_cmd)
> +
>  /* Secure Encrypted Virtualization command */
>  enum sev_cmd_id {
>  	/* Guest initialization commands */
>=20


--=20
Thanks,

David / dhildenb
