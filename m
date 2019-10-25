Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404179AbfJYIj4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 04:39:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P8bSXw130135
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:39:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vuvsp9y8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:39:54 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 25 Oct 2019 09:39:52 +0100
Subject: Re: [RFC 06/37] s390: UV: Add import and export to UV library
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-7-frankja@linux.ibm.com>
 <32166470-43c1-f454-440f-3f660b995ca2@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 25 Oct 2019 10:39:48 +0200
MIME-Version: 1.0
In-Reply-To: <32166470-43c1-f454-440f-3f660b995ca2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TczTK0Vgqy3AOR2BpjNqBOZDwNj0wUGR7"
Message-Id: <ed8860e6-176a-64dd-e697-5ed80dd3c872@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TczTK0Vgqy3AOR2BpjNqBOZDwNj0wUGR7
Content-Type: multipart/mixed; boundary="SN5pJkUObv1QcUB9Q0ONMh8kufdpmZ21N"

--SN5pJkUObv1QcUB9Q0ONMh8kufdpmZ21N
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/25/19 10:31 AM, David Hildenbrand wrote:
> On 24.10.19 13:40, Janosch Frank wrote:
>> The convert to/from secure (or also "import/export") ultravisor calls
>> are need for page management, i.e. paging, of secure execution VM.
>>
>> Export encrypts a secure guest's page and makes it accessible to the
>> guest for paging.
>=20
> How does paging play along with pinning the pages (from=20
> uv_convert_to_secure() -> kvm_s390_pv_pin_page()) in a follow up patch?=
=20
> Can you paint me the bigger picture?

That's a stale comment I should have removed before sending...
The current patches do not support paging.

>=20
> Just so I understand:
>=20
> When a page is "secure", it is actually unencrypted but only the guest =

> can access it. If the host accesses it, there is an exception.
>=20
> When a page is "not secure", it is encrypted but only the host can read=
=20
> it. If the guest accesses it, there is an exception.
>=20
> Based on these exceptions, you are able to request to convert back and =

> forth.

Yes
Shared pages are the exception, because they are accessible to both parti=
es.

>=20
>=20
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
>>   arch/s390/include/asm/uv.h | 51 ++++++++++++++++++++++++++++++++++++=
++
>>   1 file changed, 51 insertions(+)
>>
>> diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
>> index 0bfbafcca136..99cdd2034503 100644
>> --- a/arch/s390/include/asm/uv.h
>> +++ b/arch/s390/include/asm/uv.h
>> @@ -15,6 +15,7 @@
>>   #include <linux/errno.h>
>>   #include <linux/bug.h>
>>   #include <asm/page.h>
>> +#include <asm/gmap.h>
>>  =20
>>   #define UVC_RC_EXECUTED		0x0001
>>   #define UVC_RC_INV_CMD		0x0002
>> @@ -279,6 +280,54 @@ static inline int uv_cmd_nodata(u64 handle, u16 c=
md, u32 *ret)
>>   	return rc ? -EINVAL : 0;
>>   }
>>  =20
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
>> +	return -EINVAL;
>> +}
>> +
>>   void setup_uv(void);
>>   void adjust_to_uv_max(unsigned long *vmax);
>>   #else
>> @@ -286,6 +335,8 @@ void adjust_to_uv_max(unsigned long *vmax);
>>   static inline void setup_uv(void) {}
>>   static inline void adjust_to_uv_max(unsigned long *vmax) {}
>>   static inline int uv_cmd_nodata(u64 handle, u16 cmd, u32 *ret) { ret=
urn 0; }
>> +static inline int uv_convert_from_secure(unsigned long paddr) { retur=
n 0; }
>> +static inline int uv_convert_to_secure(unsigned long handle, unsigned=
 long gaddr) { return 0; }
>>   #endif
>>  =20
>>   #if defined(CONFIG_PROTECTED_VIRTUALIZATION_GUEST) ||               =
           \
>>
>=20
>=20



--SN5pJkUObv1QcUB9Q0ONMh8kufdpmZ21N--

--TczTK0Vgqy3AOR2BpjNqBOZDwNj0wUGR7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2ytNQACgkQ41TmuOI4
ufikyhAAtDivoT8s8vpUdQbwSKbW2WbmmWgM8A6k90UJJtYevktH9pwn8Wx3tN5n
BXZOChAOKzdgS9PYOUMNAZzArl60FMHwM0R89Mmvsqt60FblV9wDe7OKqqcvbqlf
fhuJSImEqqxcy0Zrjj6IrKSnN7QcBWK2yuNzjMU9iXtbHPKh0MvE+76t6KuA+XXG
OZryagF04kzaJkOC8AFrDfJNdsmtXwYzAMRArkGSkHvUoS7lNwT2xhtuCrxNUTm8
mpOeucwDi1uwoWyZlw3tmn80jnUpasRr/PkMo/s0izRrx45KD4+GErJ/SnnpqRqG
+o3omZUbAa+bboCIpyyh4VoaUAMvpfuwVU5V155hdw2KymGm4ZxRhXDh968mgqNT
MfCiP/c31o9JQ/VMcZPgY1YSuge9DIAc4l6N06mguEZHVtv6WGsqpKs5UH/YbNFe
1Zxk6G6Ti+c4X5GQOenuedxZDPYP6IKu5S5fyJvTg4kCSsxRRg4FdYRX5ZAG+uWP
zkh8MEKAY9CSIUqPYVyKYYl4DDOp2i1P9Qy417x9wDMK7LRWbgAnSG4c1TNoeENY
Zk4eVk7IA41CtXPR9JsJEhxjzMYWD+Br8y2eL3QFoOKLirMMEgST9mZ64cBuHUo9
XMOdhLFxeQs3ICzZJN99WylAKPJ3tNYGps/1DLb3HnUXNqbzIfY=
=C4qy
-----END PGP SIGNATURE-----

--TczTK0Vgqy3AOR2BpjNqBOZDwNj0wUGR7--
