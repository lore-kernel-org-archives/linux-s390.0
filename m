Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21126 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390159AbgFYHHz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 03:07:55 -0400
Subject: Re: [PATCH 2/2] docs: kvm: fix rst formatting
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-3-walling@linux.ibm.com>
 <20200625083423.2ee75bb1.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <22b7d435-480e-ac7f-de4f-b992df6c9ebb@linux.ibm.com>
Date: Thu, 25 Jun 2020 09:07:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200625083423.2ee75bb1.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r8PQzRBMtvHxMhJquyO2vgoicXXzFnx6J"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r8PQzRBMtvHxMhJquyO2vgoicXXzFnx6J
Content-Type: multipart/mixed; boundary="zziIhm2JXBOZYIejBv8fhBMMiik0t30Mj"

--zziIhm2JXBOZYIejBv8fhBMMiik0t30Mj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/25/20 8:34 AM, Cornelia Huck wrote:
> On Wed, 24 Jun 2020 16:22:00 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
>=20
>> KVM_CAP_S390_VCPU_RESETS and KVM_CAP_S390_PROTECTED needed
>> just a little bit of rst touch-up
>>
>=20
> Fixes: 7de3f1423ff9 ("KVM: s390: Add new reset vcpu API")
> Fixes: 04ed89dc4aeb ("KVM: s390: protvirt: Add KVM api documentation")

Do we really do that for documentation changes?


>=20
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  Documentation/virt/kvm/api.rst | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/a=
pi.rst
>> index 056608e8f243..2d1572d92616 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -6134,16 +6134,17 @@ in CPUID and only exposes Hyper-V identificati=
on. In this case, guest
>>  thinks it's running on Hyper-V and only use Hyper-V hypercalls.
>> =20
>>  8.22 KVM_CAP_S390_VCPU_RESETS
>> +-----------------------------
>> =20
>> -Architectures: s390
>> +:Architectures: s390
>> =20
>>  This capability indicates that the KVM_S390_NORMAL_RESET and
>>  KVM_S390_CLEAR_RESET ioctls are available.
>> =20
>>  8.23 KVM_CAP_S390_PROTECTED
>> +---------------------------
>> =20
>> -Architecture: s390
>> -
>> +:Architecture: s390
>> =20
>>  This capability indicates that the Ultravisor has been initialized an=
d
>>  KVM can therefore start protected VMs.
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>=20



--zziIhm2JXBOZYIejBv8fhBMMiik0t30Mj--

--r8PQzRBMtvHxMhJquyO2vgoicXXzFnx6J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl70TT8ACgkQ41TmuOI4
ufhqcw/9E1ANIy0CCWrofIiqj8bQBbjT7uEmPNQ3YhmU9yphY21f+XDLxXKv4Ax5
pgz5eCqwrf7ZFN5aniYnNF6Kac2oPcZK67yLXInTLYlBXP/yUJLWKKpsoc+B5XQx
tnC/87JQ0yLhKIGoUlbiNwc+2+IX49WOOY7SE4CBmrgYUDGl6AISlCBOPbJHYVBK
KaXkBYqlsyKRCy+KiTK9H8BSScMA2hyP48eimV7Ffjvn3BxBJCSGbXL8+lhO2tGf
iTYLSHAPtrRB9UEn3eb8Zaa1DrA+f252JRH7qMxpvvQBo0/fKZwPBNEPCeBwKGrG
uXusk9WJTxK5qMM4An2HyxAWO9i4mGSrbVw/L+NonHuEg+ak5VcGfmjZKXdDyHh9
C4A+FsnRshniFDGP19EwGNvY5MiN1ztMyeXgbb0v1vEIABRiCzpE2eGrPwg5N+R+
W9Zw7aoL9xXrQjiaXzV7P9TonTyv61untUUYOzBhYfTK3dHCczLmRUcwk0cGWALm
x5eBvcfpN/sGlIX502cnYYMFm0bLl68o1WS3flQaid4j9khEumYkVUDeib4JmG1N
mVSMgXu/vbOEswu4TumciLU3GVUV/lKGZW5LfROYsoCAPuypAGoJY7m9aKlsXXUZ
HFIKv44rYECPZJchLWp1ThySD8rS309TaMF3itb6f4bVvVeCSpg=
=jGyM
-----END PGP SIGNATURE-----

--r8PQzRBMtvHxMhJquyO2vgoicXXzFnx6J--
