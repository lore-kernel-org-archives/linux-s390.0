Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
References: <20190829105356.27805-1-thuth@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 29 Aug 2019 13:15:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190829105356.27805-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0wMEEuqhbJM6ARrQtEPnARPnQfbHNCfZS"
Message-Id: <870234c7-47ed-6a96-0edf-66d9c2cd7ac0@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0wMEEuqhbJM6ARrQtEPnARPnQfbHNCfZS
Content-Type: multipart/mixed; boundary="kr7wVFxveKPw9mhIE2rkSExATSXlaTJsY";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <870234c7-47ed-6a96-0edf-66d9c2cd7ac0@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: Test for bad access register at the start of
 S390_MEM_OP
References: <20190829105356.27805-1-thuth@redhat.com>
In-Reply-To: <20190829105356.27805-1-thuth@redhat.com>

--kr7wVFxveKPw9mhIE2rkSExATSXlaTJsY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/29/19 12:53 PM, Thomas Huth wrote:
> If the KVM_S390_MEM_OP ioctl is called with an access register >=3D 16,=

> then there is certainly a bug in the calling userspace application.
> We check for wrong access registers, but only if the vCPU was already
> in the access register mode before (i.e. the SIE block has recorded
> it). The check is also buried somewhere deep in the calling chain (in
> the function ar_translation()), so this is somewhat hard to find.
>=20
> It's better to always report an error to the userspace in case this
> field is set wrong, and it's safer in the KVM code if we block wrong
> values here early instead of relying on a check somewhere deep down
> the calling chain, so let's add another check to kvm_s390_guest_mem_op(=
)
> directly.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index f329dcb3f44c..725690853cbd 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4255,7 +4255,7 @@ static long kvm_s390_guest_mem_op(struct kvm_vcpu=
 *vcpu,
>  	const u64 supported_flags =3D KVM_S390_MEMOP_F_INJECT_EXCEPTION
>  				    | KVM_S390_MEMOP_F_CHECK_ONLY;
> =20
> -	if (mop->flags & ~supported_flags)
> +	if (mop->flags & ~supported_flags || mop->ar >=3D NUM_ACRS)
>  		return -EINVAL;
> =20
>  	if (mop->size > MEM_OP_MAX_SIZE)
>=20

By the way, I think we want to check mop->size for 0 before giving it to
vmalloc and working with it.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--kr7wVFxveKPw9mhIE2rkSExATSXlaTJsY--

--0wMEEuqhbJM6ARrQtEPnARPnQfbHNCfZS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1ns94ACgkQ41TmuOI4
ufhrLA/9GkOaq8w1UWqsMsIFnjxWsvD/mIWtID7sM/k7BJx8MqAdgST72JPKKi72
/Z7OQCVDqkIGTMF5AJW/RhxaoG5E8yHJ4Z5P0fhy1xim3A/Ws3SOecAC2h9Tm6cN
6QVao4T6k7USa9sNt5MSwmCD+Lpj6gltOgDzLwUnpT7sj+1hg9aML3yYwwI0Kdxe
+EK4l4u36Sgd8ff60hEMnujOgcyQnNcORFLDNdoLzsbU0lssGXoH7/M2EfgkBkZA
CF/SF1liJZLh/+zfub7c3CSlz7rSBnWSCeiI5yty76GPVmn93shmysNEJsD2e5A3
2iWLbkhHYkv766RBJiNB5m+v9QrRFdn21skXRibB9t4Me1QjjBetjdx7mRPzrpI1
/UHWGuWcTKdsD66SSw+ms9W7TaBwwKF13P52ujiOfag4X3IHzmFFxQP7W6l5L+TI
gZqSQjss3FNMGB0FUaf5SX9opcCKU49SQ4TEqfslFeCCXynnQICnFnGfX9rBVCnO
ZWZySLeDYCWJc7o1mNFylywpmchCpDjqcL5vWrV61UzciQr/h5uRmAjhRfV+nWtN
52KrhYlxkQU3Z451P3ZhGYi15fqH17xXfoO8r+vxQpJshomsH0vpBqlBZpWbEneO
fvGOflYVecaba2hqT+tFLUDKVnmgu13RGX587uBJoO9EjPzjn9U=
=W++1
-----END PGP SIGNATURE-----

--0wMEEuqhbJM6ARrQtEPnARPnQfbHNCfZS--
