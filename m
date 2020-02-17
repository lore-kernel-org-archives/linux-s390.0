Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41938 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727503AbgBQK5N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Feb 2020 05:57:13 -0500
Subject: Re: [PATCH v2 09/42] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-10-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9cac0f98-e593-b6ae-9d53-d3c77ea090a1@redhat.com>
Date: Mon, 17 Feb 2020 11:56:57 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-10-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

[...]
> =20
> +static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
> +{
> +	int r =3D 0;
> +	void __user *argp =3D (void __user *)cmd->data;
> +
> +	switch (cmd->cmd) {
> +	case KVM_PV_VM_CREATE: {
> +		r =3D -EINVAL;
> +		if (kvm_s390_pv_is_protected(kvm))
> +			break;

Isn't this racy? I think there has to be a way to make sure the PV state
can't change. Is there any and I am missing something obvious? (is
suspect we need the kvm->lock)

> +
> +		r =3D kvm_s390_pv_alloc_vm(kvm);
> +		if (r)
> +			break;
> +
> +		mutex_lock(&kvm->lock);
> +		kvm_s390_vcpu_block_all(kvm);
> +		/* FMT 4 SIE needs esca */
> +		r =3D sca_switch_to_extended(kvm);
> +		if (r) {
> +			kvm_s390_pv_dealloc_vm(kvm);
> +			kvm_s390_vcpu_unblock_all(kvm);
> +			mutex_unlock(&kvm->lock);
> +			break;
> +		}
> +		r =3D kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		mutex_unlock(&kvm->lock);
> +		break;
> +	}
> +	case KVM_PV_VM_DESTROY: {
> +		r =3D -EINVAL;
> +		if (!kvm_s390_pv_is_protected(kvm))
> +			break;
> +

dito

> +		/* All VCPUs have to be destroyed before this call. */
> +		mutex_lock(&kvm->lock);
> +		kvm_s390_vcpu_block_all(kvm);
> +		r =3D kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
> +		if (!r)
> +			kvm_s390_pv_dealloc_vm(kvm);
> +		kvm_s390_vcpu_unblock_all(kvm);
> +		mutex_unlock(&kvm->lock);
> +		break;
> +	}
> +	case KVM_PV_VM_SET_SEC_PARMS: {

I'd name this "KVM_PV_VM_SET_PARMS" instead.

> +		struct kvm_s390_pv_sec_parm parms =3D {};
> +		void *hdr;
> +
> +		r =3D -EINVAL;
> +		if (!kvm_s390_pv_is_protected(kvm))
> +			break;
> +

dito

> +		r =3D -EFAULT;
> +		if (copy_from_user(&parms, argp, sizeof(parms)))
> +			break;
> +
> +		/* Currently restricted to 8KB */
> +		r =3D -EINVAL;
> +		if (parms.length > PAGE_SIZE * 2)
> +			break;
> +
> +		r =3D -ENOMEM;
> +		hdr =3D vmalloc(parms.length);
> +		if (!hdr)
> +			break;
> +
> +		r =3D -EFAULT;
> +		if (!copy_from_user(hdr, (void __user *)parms.origin,
> +				    parms.length))
> +			r =3D kvm_s390_pv_set_sec_parms(kvm, hdr, parms.length,
> +						      &cmd->rc, &cmd->rrc);
> +
> +		vfree(hdr);
> +		break;
> +	}
> +	case KVM_PV_VM_UNPACK: {
> +		struct kvm_s390_pv_unp unp =3D {};
> +
> +		r =3D -EINVAL;
> +		if (!kvm_s390_pv_is_protected(kvm))
> +			break;
> +

dito

> +		r =3D -EFAULT;
> +		if (copy_from_user(&unp, argp, sizeof(unp)))
> +			break;
> +
> +		r =3D kvm_s390_pv_unpack(kvm, unp.addr, unp.size, unp.tweak,
> +				       &cmd->rc, &cmd->rrc);
> +		break;
> +	}
> +	case KVM_PV_VM_VERIFY: {
> +		r =3D -EINVAL;
> +		if (!kvm_s390_pv_is_protected(kvm))> +			break;

dito

> +
> +		r =3D uv_cmd_nodata(kvm_s390_pv_handle(kvm),
> +				  UVC_CMD_VERIFY_IMG, &cmd->rc, &cmd->rrc);
> +		KVM_UV_EVENT(kvm, 3, "PROTVIRT VERIFY: rc %x rrc %x", cmd->rc,
> +			     cmd->rrc);
> +		break;
> +	}
> +	default:
> +		return -ENOTTY;
> +	}
> +	return r;
> +}
> +
>  long kvm_arch_vm_ioctl(struct file *filp,
>  		       unsigned int ioctl, unsigned long arg)
>  {
> @@ -2262,6 +2376,25 @@ long kvm_arch_vm_ioctl(struct file *filp,
>  		mutex_unlock(&kvm->slots_lock);
>  		break;
>  	}
> +	case KVM_S390_PV_COMMAND: {
> +		struct kvm_pv_cmd args;
> +
> +		r =3D 0;
> +		if (!is_prot_virt_host()) {
> +			r =3D -EINVAL;
> +			break;
> +		}
> +		if (copy_from_user(&args, argp, sizeof(args))) {
> +			r =3D -EFAULT;
> +			break;
> +		}
> +		r =3D kvm_s390_handle_pv(kvm, &args);
> +		if (copy_to_user(argp, &args, sizeof(args))) {
> +			r =3D -EFAULT;
> +			break;
> +		}
> +		break;
> +	}
>  	default:
>  		r =3D -ENOTTY;
>  	}
> @@ -2525,6 +2658,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned lo=
ng type)
> =20
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
> +	u16 rc, rrc;
> +
>  	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
>  	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
>  	kvm_s390_clear_local_irqs(vcpu);
> @@ -2537,6 +2672,8 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> =20
>  	if (vcpu->kvm->arch.use_cmma)
>  		kvm_s390_vcpu_unsetup_cmma(vcpu);
> +	if (kvm_s390_pv_handle_cpu(vcpu))
> +		kvm_s390_pv_destroy_cpu(vcpu, &rc, &rrc);
>  	free_page((unsigned long)(vcpu->arch.sie_block));
>  }
> =20
> @@ -2558,10 +2695,15 @@ static void kvm_free_vcpus(struct kvm *kvm)
> =20
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> +	u16 rc, rrc;
>  	kvm_free_vcpus(kvm);
>  	sca_dispose(kvm);
> -	debug_unregister(kvm->arch.dbf);
>  	kvm_s390_gisa_destroy(kvm);
> +	if (kvm_s390_pv_is_protected(kvm)) {
> +		kvm_s390_pv_destroy_vm(kvm, &rc, &rrc);
> +		kvm_s390_pv_dealloc_vm(kvm);
> +	}
> +	debug_unregister(kvm->arch.dbf);
>  	free_page((unsigned long)kvm->arch.sie_page2);
>  	if (!kvm_is_ucontrol(kvm))
>  		gmap_remove(kvm->arch.gmap);
> @@ -2657,6 +2799,9 @@ static int sca_switch_to_extended(struct kvm *kvm=
)
>  	unsigned int vcpu_idx;
>  	u32 scaol, scaoh;
> =20
> +	if (kvm->arch.use_esca)
> +		return 0;
> +
>  	new_sca =3D alloc_pages_exact(sizeof(*new_sca), GFP_KERNEL|__GFP_ZERO=
);
>  	if (!new_sca)
>  		return -ENOMEM;
> @@ -2908,6 +3053,7 @@ static void kvm_s390_vcpu_setup_model(struct kvm_=
vcpu *vcpu)
>  static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>  {
>  	int rc =3D 0;
> +	u16 uvrc, uvrrc;
> =20
>  	atomic_set(&vcpu->arch.sie_block->cpuflags, CPUSTAT_ZARCH |
>  						    CPUSTAT_SM |
> @@ -2975,6 +3121,9 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *v=
cpu)
> =20
>  	kvm_s390_vcpu_crypto_setup(vcpu);
> =20
> +	if (kvm_s390_pv_is_protected(vcpu->kvm))
> +		rc =3D kvm_s390_pv_create_cpu(vcpu, &uvrc, &uvrrc);

With an explicit KVM_PV_VCPU_CREATE, this does not belong here. When
hotplugging CPUs, user space has to do that manually. But as I said
already, this user space API could be improved. (below)

> +
>  	return rc;
>  }
> =20
> @@ -4352,6 +4501,38 @@ long kvm_arch_vcpu_async_ioctl(struct file *filp=
,
>  	return -ENOIOCTLCMD;
>  }
> =20
> +static int kvm_s390_handle_pv_vcpu(struct kvm_vcpu *vcpu,
> +				   struct kvm_pv_cmd *cmd)
> +{
> +	int r =3D 0;
> +
> +	if (!kvm_s390_pv_is_protected(vcpu->kvm))
> +		return -EINVAL;
> +
> +	if (cmd->flags)
> +		return -EINVAL;
> +
> +	switch (cmd->cmd) {
> +	case KVM_PV_VCPU_CREATE: {
> +		if (kvm_s390_pv_handle_cpu(vcpu))
> +			return -EINVAL;
> +
> +		r =3D kvm_s390_pv_create_cpu(vcpu, &cmd->rc, &cmd->rrc);
> +		break;
> +	}
> +	case KVM_PV_VCPU_DESTROY: {
> +		if (!kvm_s390_pv_handle_cpu(vcpu))
> +			return -EINVAL;
> +
> +		r =3D kvm_s390_pv_destroy_cpu(vcpu, &cmd->rc, &cmd->rrc);
> +		break;
> +	}
> +	default:
> +		r =3D -ENOTTY;
> +	}
> +	return r;
> +}
> +
>  long kvm_arch_vcpu_ioctl(struct file *filp,
>  			 unsigned int ioctl, unsigned long arg)
>  {
> @@ -4493,6 +4674,25 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  					   irq_state.len);
>  		break;
>  	}
> +	case KVM_S390_PV_COMMAND_VCPU: {
> +		struct kvm_pv_cmd args;
> +
> +		r =3D 0;
> +		if (!is_prot_virt_host()) {
> +			r =3D -EINVAL;
> +			break;
> +		}
> +		if (copy_from_user(&args, argp, sizeof(args))) {
> +			r =3D -EFAULT;
> +			break;
> +		}
> +		r =3D kvm_s390_handle_pv_vcpu(vcpu, &args);
> +		if (copy_to_user(argp, &args, sizeof(args))) {
> +			r =3D -EFAULT;
> +			break;
> +		}
> +		break;
> +	}
>  	default:
>  		r =3D -ENOTTY;


Can we please discuss why we can't

- Get rid of KVM_S390_PV_COMMAND_VCPU
- Do the allocation in KVM_PV_VM_CREATE
- Rename KVM_PV_VM_CREATE -> KVM_PV_ENABLE
- Rename KVM_PV_VM_DESTROY -> KVM_PV_DISABLE

This user space API is unnecessary complicated and confusing.

--=20
Thanks,

David / dhildenb
