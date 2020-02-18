Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55976 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgBRIfk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 03:35:40 -0500
Subject: Re: [PATCH v2 24/42] KVM: s390: protvirt: STSI handling
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-25-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <380a9214-ad1a-42a0-0d7b-49289a20ff37@redhat.com>
Date: Tue, 18 Feb 2020 09:35:29 +0100
MIME-Version: 1.0
In-Reply-To: <20200214222658.12946-25-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On 14.02.20 23:26, Christian Borntraeger wrote:
> From: Janosch Frank <frankja@linux.ibm.com>
>=20
> Save response to sidad and disable address checking for protected
> guests.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index ed52ffa8d5d4..b2de7dc5f58d 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -872,7 +872,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
> =20
>  	operand2 =3D kvm_s390_get_base_disp_s(vcpu, &ar);
> =20
> -	if (operand2 & 0xfff)
> +	if (!kvm_s390_pv_is_protected(vcpu->kvm) && (operand2 & 0xfff))
>  		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);

Why is that needed? I'd assume the hardware handles this for us and this
case can never happen for PV? (IOW, change is not necessary)

> =20
>  	switch (fc) {
> @@ -893,8 +893,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>  		handle_stsi_3_2_2(vcpu, (void *) mem);
>  		break;
>  	}
> -
> -	rc =3D write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
> +	if (kvm_s390_pv_is_protected(vcpu->kvm)) {
> +		memcpy((void *)sida_origin(vcpu->arch.sie_block), (void *)mem,
> +		       PAGE_SIZE);
> +		rc =3D 0;
> +	} else {
> +		rc =3D write_guest(vcpu, operand2, ar, (void *)mem, PAGE_SIZE);
> +	}
>  	if (rc) {
>  		rc =3D kvm_s390_inject_prog_cond(vcpu, rc);
>  		goto out;
>=20

I'd pull the interrupt injection into the else case, makes things clearer=
.

What about user_stsi? Will that still work? (I assume user space will
write to the sida and it should work just fine)

(I assume races regarding kvm_s390_pv_is_protected() will be dealt with
in your next series)

In general, looks good to me.

--=20
Thanks,

David / dhildenb
