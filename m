Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729076AbgBQPAg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 10:00:36 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01HEnGhH145036
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:00:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y6af35u00-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 10:00:35 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 17 Feb 2020 15:00:33 -0000
Subject: Re: [PATCH 2/2] merge vm/cpu create
References: <c77dbb1b-0f4b-e40a-52a4-7110aec75e32@redhat.com>
 <20200217145302.19085-1-borntraeger@de.ibm.com>
 <20200217145302.19085-3-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 17 Feb 2020 16:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <20200217145302.19085-3-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="opHh495dNbr5zNDaGqk492TywDzNckW4e"
Message-Id: <5c0b4baa-4113-d183-5bc6-c1e7b1f3032c@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, david@redhat.com
Cc: Ulrich.Weigand@de.ibm.com, cohuck@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--opHh495dNbr5zNDaGqk492TywDzNckW4e
Content-Type: multipart/mixed; boundary="7U3dZrw8iMZ2XlITEFJGdRT8ciCVUpoBk"

--7U3dZrw8iMZ2XlITEFJGdRT8ciCVUpoBk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/17/20 3:53 PM, Christian Borntraeger wrote:
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 55 +++++++++++++++++++++++++++++-----------=

>  1 file changed, 40 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index a095d9695f18..10b20e17a7fe 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2171,9 +2171,41 @@ static int kvm_s390_set_cmma_bits(struct kvm *kv=
m,
>  	return r;
>  }
> =20
> +static int kvm_s390_switch_from_pv(struct kvm *kvm, u16 *rc, u16 *rrc)=

> +{
> +	int i, r =3D 0;
> +
> +	struct kvm_vcpu *vcpu;
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		r =3D kvm_s390_pv_destroy_cpu(vcpu, rc, rrc);
> +		if (r)
> +			break;
> +	}
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
> +		r =3D kvm_s390_pv_create_cpu(vcpu, rc, rrc);
> +		if (r)
> +			break;
> +	}
> +	if (r)
> +		kvm_s390_switch_from_pv(kvm,&dummy, &dummy);
> +	return r;
> +}

Why does that only affect the cpus?
If we have a switch function it should do VM and VCPUs, no?

> +
>  static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)=

>  {
>  	int r =3D 0;
> +	u16 dummy;
>  	void __user *argp =3D (void __user *)cmd->data;
> =20
>  	switch (cmd->cmd) {
> @@ -2204,6 +2236,11 @@ static int kvm_s390_handle_pv(struct kvm *kvm, s=
truct kvm_pv_cmd *cmd)
>  			break;
>  		}
>  		r =3D kvm_s390_pv_create_vm(kvm, &cmd->rc, &cmd->rrc);
> +		if (!r)
> +			r =3D kvm_s390_switch_to_pv(kvm, &cmd->rc, &cmd->rrc);
> +		if (r)
> +			kvm_s390_pv_destroy_vm(kvm, &dummy, &dummy);
> +
>  		kvm_s390_vcpu_unblock_all(kvm);
>  		/* we need to block service interrupts from now on */
>  		set_bit(IRQ_PEND_EXT_SERVICE, &kvm->arch.float_int.masked_irqs);
> @@ -2215,7 +2252,9 @@ static int kvm_s390_handle_pv(struct kvm *kvm, st=
ruct kvm_pv_cmd *cmd)
>  			break;
> =20
>  		kvm_s390_vcpu_block_all(kvm);
> -		r =3D kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
> +		r =3D kvm_s390_switch_from_pv(kvm, &cmd->rc, &cmd->rrc);
> +		if (!r)
> +			r =3D kvm_s390_pv_destroy_vm(kvm, &cmd->rc, &cmd->rrc);
>  		if (!r)
>  			kvm_s390_pv_dealloc_vm(kvm);
>  		kvm_s390_vcpu_unblock_all(kvm);
> @@ -4660,20 +4699,6 @@ static int kvm_s390_handle_pv_vcpu(struct kvm_vc=
pu *vcpu,
>  		return -EINVAL;
> =20
>  	switch (cmd->cmd) {
> -	case KVM_PV_VCPU_CREATE: {
> -		if (kvm_s390_pv_handle_cpu(vcpu))
> -			return -EINVAL;
> -
> -		r =3D kvm_s390_pv_create_cpu(vcpu, &cmd->rc, &cmd->rrc);
> -		break;
> -	}
> -	case KVM_PV_VCPU_DESTROY: {
> -		if (!kvm_s390_pv_handle_cpu(vcpu))
> -			return -EINVAL;
> -
> -		r =3D kvm_s390_pv_destroy_cpu(vcpu, &cmd->rc, &cmd->rrc);
> -		break;
> -	}
>  	case KVM_PV_VCPU_SET_IPL_PSW: {
>  		if (!kvm_s390_pv_handle_cpu(vcpu))
>  			return -EINVAL;
>=20



--7U3dZrw8iMZ2XlITEFJGdRT8ciCVUpoBk--

--opHh495dNbr5zNDaGqk492TywDzNckW4e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5KqocACgkQ41TmuOI4
ufiI8BAAoJ2QKJXrtHOE6mP66YN4euIaJRbUsWA+tWAkgAZ838vKmGdHzLituTlm
sTFIgD3/dHwaRw4geZSlAGU4nt3ItDJPEaBQLwLRJ3eBQSbrB3lTnYUBen/t7nSC
0Iv7TMXWua677v3mqMiJbEXSmmoBLAKzWMqWV7v1Z/qzJXmEKf3HCbGNosIWT/ZX
ZhYQuGMBSFHgbSHnBW7IRE0bWiTHdTNBvAnFzveVaU3xfa3RAU5HUhUmksdLRafU
Vx6DHXfOz3W90YPWLjQmVczwwUO7IIblORNX+/qFLYRPjwyVmeqUV7Us6OpQyBuM
66g+tuD8s5sKb5X0sEtKP73Xpl1sbXz7kxdaiiGLy4MMCLAL5XsTp4nUVuGDM4Kh
LHoEsNp7ZCxbUMWOZ9MnKqgPH+I0Zuv/Sh6Ww6mNllpqGAFpmgdqlI2A0lgC7mLX
CUu7d4ys1U7VNBjVoDyzbdbkIxiqENdJgA58T3ncsVAFW/FP/sEWt0OF1lhx/dAw
62UX/70FD71gOdOn3YxdV9mqjN3OgApgcQd1YGkfSuFAFfuCad2D2J4nJbuBVEHG
4cA/ts2FG5VONltw62m+mXrnK3+EblmkrCBdbg+hSQVAdib6JtMpGufT72BpI7Sl
PkJKNzwRkCLBb4rYy2UxjQrG2aDDGpvSM7OPC44cfhPef/CN0NM=
=eqy7
-----END PGP SIGNATURE-----

--opHh495dNbr5zNDaGqk492TywDzNckW4e--
