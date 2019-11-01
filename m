Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726229AbfKAMZp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Nov 2019 08:25:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA1CDwD3066017
        for <linux-s390@vger.kernel.org>; Fri, 1 Nov 2019 08:25:44 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w0kjbtm6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 01 Nov 2019 08:25:43 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 1 Nov 2019 12:25:41 -0000
Subject: Re: [RFC 06/37] s390: UV: Add import and export to UV library
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-7-frankja@linux.ibm.com>
 <b7126f40-ff10-0123-4c5e-37f57d63c3cd@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 1 Nov 2019 13:25:36 +0100
MIME-Version: 1.0
In-Reply-To: <b7126f40-ff10-0123-4c5e-37f57d63c3cd@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cWZISPjpxVJzpqtW7ho2YUXufANqUKeCB"
Message-Id: <49b75b9c-9baa-40fd-c555-100c5afef0cd@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cWZISPjpxVJzpqtW7ho2YUXufANqUKeCB
Content-Type: multipart/mixed; boundary="i9T5P9ZU7ZdhJPEypK4dlSDzIhvmsFm3v"

--i9T5P9ZU7ZdhJPEypK4dlSDzIhvmsFm3v
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/1/19 12:26 PM, Christian Borntraeger wrote:
>=20
>=20
> On 24.10.19 13:40, Janosch Frank wrote:
>> The convert to/from secure (or also "import/export") ultravisor calls
>> are need for page management, i.e. paging, of secure execution VM.
>>
>> Export encrypts a secure guest's page and makes it accessible to the
>> guest for paging.
>>
>> Import makes a page accessible to a secure guest.
>> On the first import of that page, the page will be cleared by the
>> Ultravisor before it is given to the guest.
>>
>> All following imports will decrypt a exported page and verify
>> integrity before giving the page to the guest.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 51 +++++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 0bfbafcca136..99cdd2034503 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -15,6 +15,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/bug.h>
>>  #include <asm/page.h>
>> +#include <asm/gmap.h>
>> =20
>>  #define UVC_RC_EXECUTED		0x0001
>>  #define UVC_RC_INV_CMD		0x0002
>> @@ -279,6 +280,54 @@ static inline int uv_cmd_nodata(u64 handle, u16 c=
md, u32 *ret)
>>  	return rc ? -EINVAL : 0;
>>  }
>> =20
>> +/*
>> + * Requests the Ultravisor to encrypt a guest page and make it
>> + * accessible to the host for paging (export).
>> + *
>> + * @paddr: Absolute host address of page to be exported
>> + */
>> +static inline int uv_convert_from_secure(unsigned long paddr)
>> +{
>> +	struct uv_cb_cfs uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_CONV_FROM_SEC_STOR,
>> +		.header.len =3D sizeof(uvcb),
>> +		.paddr =3D paddr
>> +	};
>> +	if (!uv_call(0, (u64)&uvcb))
>> +		return 0;
>=20
> As discussed on the KVM forum. We should also check for
> uvcb.header.rc !=3D UVC_RC_EXECUTED
> I know, we cant really do much if this fails, but we certainly want to =
know.
>=20
>=20
>=20
>=20
>=20
>=20
>> +	return -EINVAL;
>> +}
>> +
>> +/*
>> + * Requests the Ultravisor to make a page accessible to a guest
>> + * (import). If it's brought in the first time, it will be cleared. I=
f
>> + * it has been exported before, it will be decrypted and integrity
>> + * checked.
>> + *
>> + * @handle: Ultravisor guest handle
>> + * @gaddr: Guest 2 absolute address to be imported
>> + */
>> +static inline int uv_convert_to_secure(struct gmap *gmap, unsigned lo=
ng gaddr)
>> +{
>> +	int cc;
>> +	struct uv_cb_cts uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_CONV_TO_SEC_STOR,
>> +		.header.len =3D sizeof(uvcb),
>> +		.guest_handle =3D gmap->se_handle,
>> +		.gaddr =3D gaddr
>> +	};
>> +
>> +	cc =3D uv_call(0, (u64)&uvcb);
>> +
>> +	if (!cc)
>> +		return 0;
>> +	if (uvcb.header.rc =3D=3D 0x104)
>> +		return -EEXIST;
>> +	if (uvcb.header.rc =3D=3D 0x10a)
>> +		return -EFAULT;
>=20
> again, we should probably check for rc !=3D UVC_RC_EXECUTED to detect a=
ny other problem.

That's handled by the CC and the return below.
CC =3D=3D 1 means error
cc =3D=3D 0 is success, that's why we return erly on cc =3D=3D 0

>=20
>> +	return -EINVAL;
>> +}
>> +
>>  void setup_uv(void);
>>  void adjust_to_uv_max(unsigned long *vmax);
>>  #else
>> @@ -286,6 +335,8 @@ void adjust_to_uv_max(unsigned long *vmax);
>>  static inline void setup_uv(void) {}
>>  static inline void adjust_to_uv_max(unsigned long *vmax) {}
>>  static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret) { retu=
rn 0; }
>> +static inline int uv_convert_from_secure(unsigned long paddr) { retur=
n 0; }
>> +static inline int uv_convert_to_secure(unsigned long handle, unsigned=
 long gaddr) { return 0; }
>>  #endif
>> =20
>>  #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||                =
          \
>>



--i9T5P9ZU7ZdhJPEypK4dlSDzIhvmsFm3v--

--cWZISPjpxVJzpqtW7ho2YUXufANqUKeCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl28JEAACgkQ41TmuOI4
ufiKOA//VcLaizyyXOGqUR4TW7tEHRBMCTUdg1o62TA1C/PQ3bCwhkQspsUspGiO
fJE4NwDXEjqRqa2h0SoKBV3P5RgQiOpmIAu+rvzh20mQUhdj6whk/mlRRW/1ToEh
LXdS5AHSKrEcUIP7VNrSipwQeBv41Ol5uiNECuBl0e0aGFcZpeDkHu+oNVaJWRVc
tQEhuEejJ44FRxF0zQFqpHtFQQqoijUBiT3Huv2SGFzcJ9rqVSTLWaP1BbqiUZcI
+Q2Cd1+dWf8CuTK5q+7Er2leSsnZngCe+setyFRc24nTjBcVj99IIp5gyeqjMm2D
ImaeqEHi2XpRF7wz37V7VnmaBz97l2i9v09ti1Jr+boH9bZvBeEarcfz5Nz6gCdH
I0SVO+E16owa9WAPx+d2HzA9anczMKwGJe1sfW/61w007FrDM3bDOuNXRFuT7Mjg
5eQ01LKQQl2uvHUTOIiNWzOLmiexxjMHBfj2S1QLagulsM5mDcL5jJZo+/ZhMHz2
cqVa6QI9JhLnRvklPhJL4ret5OIj7XY7/kffZsTSU8wO30n4xZerZzH3j9s9EPyV
BiKr2V8fGNsLhpmEYB1gO7XJjHA9OfzroKYbQ5uNRR+vTaFqOxmKJIvdjkni0g3W
e8jxcRbQcdVihS9Og3M3GH8AHbjpnQ0MK+7GU1aVomnAOSaKszc=
=3JCq
-----END PGP SIGNATURE-----

--cWZISPjpxVJzpqtW7ho2YUXufANqUKeCB--
