Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726928AbfKKQ4j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Nov 2019 11:56:39 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xABGsJYX126903
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 11:56:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w79mgpm6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 11 Nov 2019 11:56:38 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 11 Nov 2019 16:56:35 -0000
Subject: Re: [RFC 06/37] s390: UV: Add import and export to UV library
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-7-frankja@linux.ibm.com>
 <20191111174039.608f53fb.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 11 Nov 2019 17:56:30 +0100
MIME-Version: 1.0
In-Reply-To: <20191111174039.608f53fb.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0nTGA8CHE8faN0oyoJiSW5szDC9RLyPTi"
Message-Id: <ab6770e6-ac73-5f39-e7fd-3edc92de740e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0nTGA8CHE8faN0oyoJiSW5szDC9RLyPTi
Content-Type: multipart/mixed; boundary="5WgNiv6Tw8pPL0mTJ83PVrl33ENyuIVdH"

--5WgNiv6Tw8pPL0mTJ83PVrl33ENyuIVdH
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/11/19 5:40 PM, Cornelia Huck wrote:
> On Thu, 24 Oct 2019 07:40:28 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
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
>> +	return -EINVAL;
>=20
> No possibility for other return codes here (e.g. -EFAULT)? (Asking
> because you look at a rc in the control block in the reverse function.)=


Notice the "paddr" variable?
We work on physical memory for this UV call, all error codes that are
defined are either input errors (not possible via the exception
handlers), a KVM management error or an attack on the VM.

>=20
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
>=20



--5WgNiv6Tw8pPL0mTJ83PVrl33ENyuIVdH--

--0nTGA8CHE8faN0oyoJiSW5szDC9RLyPTi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3Jkr4ACgkQ41TmuOI4
ufiEfQ/+P+6yIyw4Q5NdNUelojjFpQIKL1U0ecCYSnsRVazQhSihM2KJhKYJXI3p
+BJXvA1tcygaXY8ridIn98/Lw60SoAtgMi3p/plbRL5uv+c1E98irlMpX6V3uc3Z
fk3kBPaTecJMDDTcZQ7JiuCNqhIA7GjLb2hsKgZFYt28IgsBk2eMyxBDEEyynOc7
k51ZSfKvIlOhKoLL1f2o2PbZXgFimdeb+Ve1ZXXLrPp3CHLZ+96WnShA4LbLMuu2
4H6tUcRpm+mUcN8CyS8xfC3zpWB7RC9wsAm5zJAcWWld3k+pAqBI922ypN3feAKa
u1tB7Lwoaoa6XQFOR90pfWuc+7LFV1R96fTca+mxMywOPPh9ip/4/5BYCia+9ynd
97Mw8Y2ktG7Jk34uNzXjSolRr5Qen4PsmlIqjtTaawWi+4RIxYUpbY0l6IwRZrb8
p+Pdp/x/jByaT11SJDJUXEf49dc5GYo40Qg7wNgMn2nRYomWFv+eIChB+XwwDUjx
nYd5GSCU2W0tAwLKmkSQsgKXvYLLBjGVUvOnbEExTCZ4Kp6HL2iQCMCdS4FZFRx1
vYa8sq+DMjzDeNNMX/LBaBc34+FaHjYdIpA6dsKDnDEhO64fDrMk+pPNRnAuKSdQ
XmX4610Ag+nxPssDvTPUMYGkvywzVdTLur1B9VC0wvY+k3hb81Y=
=+gWa
-----END PGP SIGNATURE-----

--0nTGA8CHE8faN0oyoJiSW5szDC9RLyPTi--
