Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52072 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728267AbfILH57 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Sep 2019 03:57:59 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8C7r70I057271
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 03:57:57 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxcvfdm6r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 03:57:56 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Sep 2019 08:57:52 +0100
Subject: Re: [PATCH] KVM: s390: Remove unused parameter from
 __inject_sigp_restart()
References: <20190912070250.15131-1-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Sep 2019 09:57:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190912070250.15131-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="887L4odkJZ4Sdyy1OaRsoXAos47dwrLlF"
Message-Id: <66e216e7-fd1f-b9af-5195-cee4f8a1fa90@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--887L4odkJZ4Sdyy1OaRsoXAos47dwrLlF
Content-Type: multipart/mixed; boundary="WI4tt6jyBf2qP911xCAkOoHm2qQSAlJUy";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <66e216e7-fd1f-b9af-5195-cee4f8a1fa90@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: Remove unused parameter from
 __inject_sigp_restart()
References: <20190912070250.15131-1-thuth@redhat.com>
In-Reply-To: <20190912070250.15131-1-thuth@redhat.com>

--WI4tt6jyBf2qP911xCAkOoHm2qQSAlJUy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 9:02 AM, Thomas Huth wrote:
> It's not required, so drop it to make it clear that this interrupt
> does not have any extra parameters.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Well there's no real use for any other parameter than the target cpu, so:=

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index b5fd6e85657c..3e7efdd9228a 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1477,8 +1477,7 @@ static int __inject_sigp_stop(struct kvm_vcpu *vc=
pu, struct kvm_s390_irq *irq)
>  	return 0;
>  }
> =20
> -static int __inject_sigp_restart(struct kvm_vcpu *vcpu,
> -				 struct kvm_s390_irq *irq)
> +static int __inject_sigp_restart(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_s390_local_interrupt *li =3D &vcpu->arch.local_int;
> =20
> @@ -1997,7 +1996,7 @@ static int do_inject_vcpu(struct kvm_vcpu *vcpu, =
struct kvm_s390_irq *irq)
>  		rc =3D __inject_sigp_stop(vcpu, irq);
>  		break;
>  	case KVM_S390_RESTART:
> -		rc =3D __inject_sigp_restart(vcpu, irq);
> +		rc =3D __inject_sigp_restart(vcpu);
>  		break;
>  	case KVM_S390_INT_CLOCK_COMP:
>  		rc =3D __inject_ckc(vcpu);
>=20



--WI4tt6jyBf2qP911xCAkOoHm2qQSAlJUy--

--887L4odkJZ4Sdyy1OaRsoXAos47dwrLlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl15+nsACgkQ41TmuOI4
ufidgxAAs6KRHVlfwL48M7CQUlwmNpqS5FnS3Y2DOFrDn4YflWoKs+XDXCpQWu4w
LJLOLIybbSIzkNUNEC7rg84xhJ7wTICYojlH23W/+qYZ3ZikPyaHb/KmcaqQpnVU
igBNW68hDvQFXEbxua6kR2ARldrDiS5vpsjFIOFTuI0Z0IalCFOqqeAnCbExoAEm
4m2Xyr72ocmGo04QXr2sxXy5levJj3/rxbxP33rw78rvrdN0UJkD2zEnatkm6X1U
Oi6fNWkOIOq+s9t7bpVTkNbykE/yKDr0QdAmLgPLUyJy3maCz4DkiEYo0btiEtxR
oIdkV25KbuvWSIggiSH8xlIoang9JLGTCDnj6g4Q8fF2PYn+SOWASYjLhUTIUhdx
a0FjjpX7of08r1M9oXDiNRHomrgGq3M901DrkTUQhkvuToY+Pcr5bThZ+yXSUugn
J58DHjsbbzajLowkAH+mE8m4S7gaq8HXTlVb7XbplV18oksnOa6G0u87zHTOGbFP
H1fBDFmg6EKBz7aVLBBoC978M0f2a9Ure10m8sXSE7DzKMHuwHUyxonronR/UwWS
XgPsIZ1e7v5ODT/LMU/7FIp1Swfnnf13UylxjM703EJOKbNDLEVUZVzGYxXJ4vBW
Z7G2X8oNuto2/C3/qucTsfBEFo9TrsL1/9vvjYCVXfYO8YRL+r8=
=mOo6
-----END PGP SIGNATURE-----

--887L4odkJZ4Sdyy1OaRsoXAos47dwrLlF--
