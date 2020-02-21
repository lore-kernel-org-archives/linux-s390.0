Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59564 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgBULpn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 06:45:43 -0500
Subject: Re: [PATCH v3.1 09/37] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <b9aa96ce-9701-cefb-68d8-76d1cba4d5c7@de.ibm.com>
 <20200221080742.10233-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <08f6ad60-1046-f281-ce81-539f2c967f30@redhat.com>
Date: Fri, 21 Feb 2020 12:45:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200221080742.10233-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com


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
> +
> +		r =3D kvm_s390_pv_alloc_vm(kvm);
> +		if (r)
> +			break;
> +

To make this nicer, can we simply merge alloc+create into init

	/* FMT 4 SIE needs esca */
	r =3D sca_switch_to_extended(kvm);
	if (r)
		break;
=09
	r =3D kvm_s390_pv_init_vm();
	if (r)
		break;

	r =3D kvm_s390_cpus_to_pv(kvm, &cmd->rc, &cmd->rrc);
	if (r)
		kvm_s390_pv_deinit_vm();
	break;

I remember the split dates back to an earlier UAPI interface.

Similarly from deinit.

The you can just make deinit never fail and handle that freeing
special-case in there and add a comment.

[...]

> +int kvm_s390_pv_set_sec_parms(struct kvm *kvm, void *hdr, u64 length, =
u16 *rc,
> +			      u16 *rrc)
> +{
> +	struct uv_cb_ssc uvcb =3D {
> +		.header.cmd =3D UVC_CMD_SET_SEC_CONF_PARAMS,
> +		.header.len =3D sizeof(uvcb),
> +		.sec_header_origin =3D (u64)hdr,
> +		.sec_header_len =3D length,
> +		.guest_handle =3D kvm_s390_pv_get_handle(kvm),
> +	};
> +	int cc =3D uv_call(0, (u64)&uvcb);

empty line.

> +	*rc =3D uvcb.header.rc;

[...]

> +int kvm_s390_pv_unpack(struct kvm *kvm, unsigned long addr, unsigned l=
ong size,
> +		       unsigned long tweak, u16 *rc, u16 *rrc)
> +{
> +	u64 offset =3D 0;
> +	int ret =3D 0;
> +
> +	if (addr & ~PAGE_MASK || !size || size & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: start addr %lx size %lx",
> +		     addr, size);
> +
> +	while (offset < size) {
> +		ret =3D unpack_one(kvm, addr, tweak, offset, rc, rrc);
> +		if (ret =3D=3D -EAGAIN) {
> +			cond_resched();
> +			if (fatal_signal_pending(current))
> +				break;
> +			continue;
> +		}
> +		if (ret)
> +			break;
> +		addr +=3D PAGE_SIZE;
> +		offset +=3D PAGE_SIZE;
> +	}

Much better :)


--=20
Thanks,

David / dhildenb
