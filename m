Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48388 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727247AbgBZI2K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 03:28:10 -0500
Subject: Re: [PATCH v4.5 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <20200225214822.3611-1-borntraeger@de.ibm.com>
 <a8bf1afc-8afe-a704-32f6-b20ed2f3a54c@redhat.com>
 <8ac08255-f830-934d-1e91-d26b2cbe99f5@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d77bba47-3292-4def-59d6-5d1c19fc5171@redhat.com>
Date: Wed, 26 Feb 2020 09:28:00 +0100
MIME-Version: 1.0
In-Reply-To: <8ac08255-f830-934d-1e91-d26b2cbe99f5@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

On 26.02.20 09:12, Christian Borntraeger wrote:
>=20
>=20
> On 25.02.20 23:37, David Hildenbrand wrote:
>>
>>> +static int kvm_s390_pv_alloc_vm(struct kvm *kvm)
>>> +{
>>> +	unsigned long base =3D uv_info.guest_base_stor_len;
>>> +	unsigned long virt =3D uv_info.guest_virt_var_stor_len;
>>> +	unsigned long npages =3D 0, vlen =3D 0;
>>> +	struct kvm_memory_slot *memslot;
>>> +
>>> +	kvm->arch.pv.stor_var =3D NULL;
>>> +	kvm->arch.pv.stor_base =3D __get_free_pages(GFP_KERNEL, get_order(b=
ase));
>>> +	if (!kvm->arch.pv.stor_base)
>>> +		return -ENOMEM;
>>> +
>>> +	/*
>>> +	 * Calculate current guest storage for allocation of the
>>> +	 * variable storage, which is based on the length in MB.
>>> +	 *
>>> +	 * Slots are sorted by GFN
>>> +	 */
>>> +	mutex_lock(&kvm->slots_lock);
>>> +	memslot =3D kvm_memslots(kvm)->memslots;
>>> +	npages =3D memslot->base_gfn + memslot->npages;
>>> +	mutex_unlock(&kvm->slots_lock);
>>
>> As discussed, I think we should just use mem_limit and check against
>> some hardcoded upper limit. But yeah, we can do that as an addon (in
>> which case memory hotplug will require special tweaks to detect this
>> from user space ... e.g., a new capability)
>>
>>
>> [...]
>>
>>> +int kvm_s390_pv_init_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
>>> +{
>>> +		struct uv_cb_cgc uvcb =3D {
>>> +		.header.cmd =3D UVC_CMD_CREATE_SEC_CONF,
>>> +		.header.len =3D sizeof(uvcb)
>>> +	};
>>> +	int cc, ret;
>>> +	u16 dummy;
>>> +
>>> +	ret =3D kvm_s390_pv_alloc_vm(kvm);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Inputs */
>>> +	uvcb.guest_stor_origin =3D 0; /* MSO is 0 for KVM */
>>> +	uvcb.guest_stor_len =3D kvm->arch.pv.guest_len;
>>> +	uvcb.guest_asce =3D kvm->arch.gmap->asce;
>>> +	uvcb.guest_sca =3D (unsigned long)kvm->arch.sca;
>>> +	uvcb.conf_base_stor_origin =3D (u64)kvm->arch.pv.stor_base;
>>> +	uvcb.conf_virt_stor_origin =3D (u64)kvm->arch.pv.stor_var;
>>> +
>>> +	cc =3D uv_call(0, (u64)&uvcb);
>>> +	*rc =3D uvcb.header.rc;
>>> +	*rrc =3D uvcb.header.rrc;
>>> +	KVM_UV_EVENT(kvm, 3, "PROTVIRT CREATE VM: handle %llx len %llx rc %=
x rrc %x",
>>> +		     uvcb.guest_handle, uvcb.guest_stor_len, *rc, *rrc);
>>> +
>>> +	/* Outputs */
>>> +	kvm->arch.pv.handle =3D uvcb.guest_handle;
>>> +
>>> +	if (cc) {
>>> +		if (uvcb.header.rc & UVC_RC_NEED_DESTROY)
>>> +			kvm_s390_pv_deinit_vm(kvm, &dummy, &dummy);
>>> +		else
>>> +			kvm_s390_pv_dealloc_vm(kvm);
>>> +		return -EIO;
>>
>> A lot easier to read :)
>>
>>
>> Fell free add my rb with or without the mem_limit change.
>=20
> I think I will keep the memslot logic. For hotplug we actually need
> to notify the ultravisor that the guest size has changed as only the
> ultravisor will be able to inject an addressing exception.

So holes in between memory slots won't be properly considered? What will
happen if a guest accesses such memory right now?

>=20
> Lets keep it simple for now=20
>=20

I double checked (virt/kvm/kvm_main.c:update_memslots()), and the slots
are definitely sorted "based on their GFN". I think, it's lowest GFN
first, so the code in here would be wrong with more than one slot.

Can you double check, because I might misinterpret the code.


--=20
Thanks,

David / dhildenb
