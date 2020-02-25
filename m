Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56882 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726827AbgBYW3L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Feb 2020 17:29:11 -0500
Subject: Re: [PATCH v4 09/36] KVM: s390: protvirt: Add initial vm and cpu
 lifecycle handling
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-10-borntraeger@de.ibm.com>
 <f80a0b58-5ed2-33b7-5292-2c4899d765b7@redhat.com>
 <24689dd9-139d-3a0b-a57c-9f13ebda142b@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cff6dcbe-7028-c518-e218-426c2d26acb0@redhat.com>
Date: Tue, 25 Feb 2020 23:29:01 +0100
MIME-Version: 1.0
In-Reply-To: <24689dd9-139d-3a0b-a57c-9f13ebda142b@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

>>
>> The question will repeat a couple of times in the patch: Do we want to
>> convert that to a proper error (e.g., EBUSY, EINVAL, EWHATSOEVER)
>> instead of returning "1" to user space (whoch looks weird).
>=20
> Not sure about the right error code.=20
> -EIO for cc =3D=3D 1?

Makes sense.

[...]

>>> +	if (!cc)
>>> +		free_pages(vcpu->arch.pv.stor_base,
>>> +			   get_order(uv_info.guest_cpu_stor_len));
>>
>> Should we clear arch.pv.handle?
>=20
> this is done in the memset below

missed that, grepping betrayed me.

>>
>> Also, I do wonder if it makes sense to
>>
>> vcpu->arch.pv.stor_base =3D NULL;
>=20
> same. We could do 4 single assignments instead, but the memset is proba=
bly ok?

yes, it's only harder to review ;)

[...]

>>> +	mutex_lock(&kvm->slots_lock);
>>> +	memslot =3D kvm_memslots(kvm)->memslots;
>>> +	npages =3D memslot->base_gfn + memslot->npages;
>>
>> I remember I asked this question already, maybe I missed the reply :(
>>
>> 1. What if we have multiple slots?
>=20
> memslot 0 is the last one, so this should actually have the last memory=
 address
> so this should be ok.

I think I got it wrong (thought there would be some start and length -
but it's only a length, which makes sense).

>=20
>> 2. What is expected to happen if new slots are added (e.g., memory
>> hotplug in the future?)
>>
>> Shouldn't you bail out if there is more than one slot and make sure th=
at
>> no new ones can be added as long as pv is active (I remember the latte=
r
>> should be very easy from an arch callback)?
>=20
> Yes, that should be easy, something like the following I guess
>=20
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4744,6 +4744,9 @@ int kvm_arch_prepare_memory_region(struct kvm *kv=
m,
>         if (mem->guest_phys_addr + mem->memory_size > kvm->arch.mem_lim=
it)
>                 return -EINVAL;
> =20
> +       /* When we are protected we should not change the memory slots =
*/
> +       if (kvm_s390_pv_is_protected(kvm))
> +               return -EINVAL;
>         return 0;
>  }
> =20
>=20
>=20
>=20
> I think we can extend that later to actually use
> the memorysize from kvm->arch.mem_limit as long as this is reasonably s=
mall.
> This should then be done when we implement memory hotplug.

IMHO mem_limit would make a lot of sense and even make hotplug work out
of the box. I assume you can assume that user space properly sets this
up for all PV guests (KVM_S390_VM_MEM_LIMIT_SIZE).

So maybe use that directly and bail out if it's too big? (esp. if it's
KVM_S390_NO_MEM_LIMIT).

[...]

>> Similar to the VCPU path, should be set all pointers to NULL but skip
>> the freeing? With a similar comment /* Inteded memory leak ... */
>=20
> This is done in kvm_s390_pv_dealloc_vm. And I think it makes sense to k=
eep
> the VM thing linked to the KVM struct. This will prevent the user from =
doing
> another PV_ENABLE on this guest.


Makes sense.


--=20
Thanks,

David / dhildenb
