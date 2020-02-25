Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31251 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729663AbgBYISL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 Feb 2020 03:18:11 -0500
Subject: Re: [PATCH v4 18/36] KVM: S390: protvirt: Introduce instruction data
 area bounce buffer
References: <20200224114107.4646-1-borntraeger@de.ibm.com>
 <20200224114107.4646-19-borntraeger@de.ibm.com>
 <3db82b2d-ad79-8178-e027-c19889d96558@redhat.com>
 <f8d7321e-400e-ed82-471e-166a2d18ede6@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <74359acb-6694-8cae-e2ae-9eda54fa12a4@redhat.com>
Date: Tue, 25 Feb 2020 09:18:01 +0100
MIME-Version: 1.0
In-Reply-To: <f8d7321e-400e-ed82-471e-166a2d18ede6@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 25.02.20 08:50, Christian Borntraeger wrote:
>=20
>=20
> On 24.02.20 20:13, David Hildenbrand wrote:
>> On 24.02.20 12:40, Christian Borntraeger wrote:
>>> From: Janosch Frank <frankja@linux.ibm.com>
>>>
>>> Now that we can't access guest memory anymore, we have a dedicated
>>> satellite block that's a bounce buffer for instruction data.
>>>
>>> We re-use the memop interface to copy the instruction data to / from
>>> userspace. This lets us re-use a lot of QEMU code which used that
>>> interface to make logical guest memory accesses which are not possibl=
e
>>> anymore in protected mode anyway.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> [...]
>>
>>> +
>>>  long kvm_arch_vcpu_async_ioctl(struct file *filp,
>>>  			       unsigned int ioctl, unsigned long arg)
>>>  {
>>> @@ -4683,7 +4732,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>>>  		struct kvm_s390_mem_op mem_op;
>>> =20
>>>  		if (copy_from_user(&mem_op, argp, sizeof(mem_op)) =3D=3D 0)
>>> -			r =3D kvm_s390_guest_mem_op(vcpu, &mem_op);
>>> +			r =3D kvm_s390_guest_memsida_op(vcpu, &mem_op);
>>>  		else
>>>  			r =3D -EFAULT;
>>>  		break;
>>> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
>>> index 014e53a41ead..cd81a58349a9 100644
>>> --- a/arch/s390/kvm/pv.c
>>> +++ b/arch/s390/kvm/pv.c
>>> @@ -33,10 +33,13 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu=
, u16 *rc, u16 *rrc)
>>>  	if (!cc)
>>>  		free_pages(vcpu->arch.pv.stor_base,
>>>  			   get_order(uv_info.guest_cpu_stor_len));
>>> +
>>> +	free_page(sida_origin(vcpu->arch.sie_block));
>>>  	vcpu->arch.sie_block->pv_handle_cpu =3D 0;
>>>  	vcpu->arch.sie_block->pv_handle_config =3D 0;
>>>  	memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
>>>  	vcpu->arch.sie_block->sdf =3D 0;
>>> +	vcpu->arch.sie_block->gbea =3D 1;
>>
>> I am very confused why gbea is set to 1 when destroying the CPU. It's
>> otherwise never set (always 0). What's the meaning of this?
>=20
> This is the guest breaking event address. So a guest (and QEMU) can rea=
d it.
> It is kind of overlaid sida and gbea. Something like this:
>=20
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index cd81a58349a9..055bf0ec8fbb 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -39,6 +39,11 @@ int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u=
16 *rc, u16 *rrc)
>         vcpu->arch.sie_block->pv_handle_config =3D 0;
>         memset(&vcpu->arch.pv, 0, sizeof(vcpu->arch.pv));
>         vcpu->arch.sie_block->sdf =3D 0;
> +       /*
> +        * the sidad field (for sdf =3D=3D 2) is now the gbea field (fo=
r sdf =3D=3D 0).
> +        * Use the reset value of gbea to not leak the kernel pointer o=
f the
> +        * just free sida

"freed sida."

I guess I would have set the sidad to NULL in addition before the
"vcpu->arch.sie_block->sdf =3D 0", so access to the sidad becomes actuall=
y
grep-able.


Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb
