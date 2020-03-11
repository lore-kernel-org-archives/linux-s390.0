Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729631AbgCKOD2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Mar 2020 10:03:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BDuPBs109973
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 10:03:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yq03vbsa5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Mar 2020 10:03:26 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Mar 2020 14:02:09 -0000
Subject: Re: [PATCH 1/2] selftests: KVM: s390: fixup fprintf format error in
 reset.c
References: <20200311131056.140016-1-borntraeger@de.ibm.com>
 <20200311131056.140016-2-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Mar 2020 15:02:04 +0100
MIME-Version: 1.0
In-Reply-To: <20200311131056.140016-2-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fo0t0DfbeVpeC9zpuJqATRHCpXN3qBNak"
Message-Id: <3e093eca-9786-8aff-707f-f8529e3affd8@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fo0t0DfbeVpeC9zpuJqATRHCpXN3qBNak
Content-Type: multipart/mixed; boundary="XgEqa889JImCvEvEcpyk7Ea08grLiJ5dc"

--XgEqa889JImCvEvEcpyk7Ea08grLiJ5dc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3/11/20 2:10 PM, Christian Borntraeger wrote:
> value is u64 and not string.
>=20
> Reported-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  tools/testing/selftests/kvm/s390x/resets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/kvm/s390x/resets.c b/tools/testing=
/selftests/kvm/s390x/resets.c
> index b567705f0d41..221e9c9a8bd2 100644
> --- a/tools/testing/selftests/kvm/s390x/resets.c
> +++ b/tools/testing/selftests/kvm/s390x/resets.c
> @@ -66,7 +66,7 @@ static void test_one_reg(uint64_t id, uint64_t value)=

>  	reg.addr =3D (uintptr_t)&eval_reg;
>  	reg.id =3D id;
>  	vcpu_get_reg(vm, VCPU_ID, &reg);
> -	TEST_ASSERT(eval_reg =3D=3D value, "value =3D=3D %s", value);
> +	TEST_ASSERT(eval_reg =3D=3D value, "value =3D=3D 0x%lx", value);
>  }
> =20
>  static void assert_noirq(void)
>=20



--XgEqa889JImCvEvEcpyk7Ea08grLiJ5dc--

--Fo0t0DfbeVpeC9zpuJqATRHCpXN3qBNak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5o71wACgkQ41TmuOI4
ufhqkg/8Cu8BbFntC8dZBW4kNgUa6LFnWghB7gYIq4Jo06uXBltyLlu+YcLPNTjD
K6vw/D7M5sYw0PvUEIfLsvib8qb7tBSGj9yw6lYvthgaYzJKUCrL0hsoeO5u+F/t
937TWVWXw3ajFPBPmkYa7pxs+3cLkTuH/MiugXMkpNERD64b8BQ6pNAFnFPm8TAQ
5VF4kOpH0sVcUM3lKoU1fqFtatr0XIOydVGFOFZ4C0fbtyex03Xb+q7P0ewHXNLr
1JS2lirJrs2NSgZd5DSA6gID2HDDfDPlkJNie2MUnP4Kk3I3mLoaAISkuuZwpZhL
StiJ29tb+kd9avZ6UD/73Q8H6mxEWAAmiEWOgsuLNr4OOSrC85J+1/zeabi/vMtk
/frCX6f2s+nQZAZ0Oet8othW4J9OX4Gnzfo6NnEQLrnE+zoBpXIwWLwifq1tWbMX
Lq+IR3mwbnUHGHsHRlAi4cKEOwuiijIhd00Wjg5YuyP7GoN5fIZPWoStTsN4rxxt
F0yVF8DsAa977+UFtuWkKe7lWDPJvFN4Z4g3/7eOG/r8fxLS4bjcCT/k4Xvk3bMb
XR5FW9xdZa3INcuOlaxyKgTGkxZdv0Tizn8uhqG8tmPVs52GwhfpCwu1olEHAagn
R8c+kiSIu/e43/uSqiiS7UppPs7jYtW2XLmpIpGSL76sXPzmlL8=
=sJJ1
-----END PGP SIGNATURE-----

--Fo0t0DfbeVpeC9zpuJqATRHCpXN3qBNak--
