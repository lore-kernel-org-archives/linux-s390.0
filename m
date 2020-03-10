Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731258AbgCJNVc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Mar 2020 09:21:32 -0400
Subject: Re: [PATCH v2] KVM: s390: Also reset registers in sync regs for
 initial cpu reset
References: <20200310131223.10287-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8bdef3aa-01b5-93a1-c54a-46768d47dfa4@redhat.com>
Date: Tue, 10 Mar 2020 14:21:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200310131223.10287-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, stable@vger.kernel.org

On 10.03.20 14:12, Christian Borntraeger wrote:
> When we do the initial CPU reset we must not only clear the registers
> in the internal data structures but also in kvm_run sync_regs. For
> modern userspace sync_regs is the only place that it looks at.
>=20
> Cc: stable@vger.kernel.org

# v?

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d7ff30e45589..c2e6d4ba4e23 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3268,7 +3268,10 @@ static void kvm_arch_vcpu_ioctl_initial_reset(st=
ruct kvm_vcpu *vcpu)
>  	/* Initial reset is a superset of the normal reset */
>  	kvm_arch_vcpu_ioctl_normal_reset(vcpu);
> =20
> -	/* this equals initial cpu reset in pop, but we don't switch to ESA *=
/
> +	/*
> +	 * This equals initial cpu reset in pop, but we don't switch to ESA.
> +	 * We do not only reset the internal data, but also ...
> +	 */
>  	vcpu->arch.sie_block->gpsw.mask =3D 0;
>  	vcpu->arch.sie_block->gpsw.addr =3D 0;
>  	kvm_s390_set_prefix(vcpu, 0);
> @@ -3278,6 +3281,19 @@ static void kvm_arch_vcpu_ioctl_initial_reset(st=
ruct kvm_vcpu *vcpu)
>  	memset(vcpu->arch.sie_block->gcr, 0, sizeof(vcpu->arch.sie_block->gcr=
));
>  	vcpu->arch.sie_block->gcr[0] =3D CR0_INITIAL_MASK;
>  	vcpu->arch.sie_block->gcr[14] =3D CR14_INITIAL_MASK;
> +
> +	/* ... the data in sync regs */
> +	memset(vcpu->run->s.regs.crs, 0, sizeof(vcpu->run->s.regs.crs));
> +	vcpu->run->s.regs.ckc =3D 0;
> +	vcpu->run->s.regs.crs[0] =3D CR0_INITIAL_MASK;
> +	vcpu->run->s.regs.crs[14] =3D CR14_INITIAL_MASK;
> +	vcpu->run->psw_addr =3D 0;
> +	vcpu->run->psw_mask =3D 0;
> +	vcpu->run->s.regs.todpr =3D 0;
> +	vcpu->run->s.regs.cputm =3D 0;
> +	vcpu->run->s.regs.ckc =3D 0;
> +	vcpu->run->s.regs.pp =3D 0;
> +	vcpu->run->s.regs.gbea =3D 1;
>  	vcpu->run->s.regs.fpc =3D 0;
>  	vcpu->arch.sie_block->gbea =3D 1;
>  	vcpu->arch.sie_block->pp =3D 0;
>=20

Acked-by: David Hildenbrand <david@redhat.com>

However, I do wonder if that ioctl *originally* was designed for that -
IOW if this is rally a stable patch or just some change that makes
sense. IIRC, userspace/QEMU always did the right thing, no? There was no
documentation about the guarantees AFAIK.

--=20
Thanks,

David / dhildenb
