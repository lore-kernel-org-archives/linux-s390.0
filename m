Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728774AbgHJP1p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Aug 2020 11:27:45 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Ultravisor guest API test
References: <20200807111555.11169-1-frankja@linux.ibm.com>
 <20200807111555.11169-4-frankja@linux.ibm.com>
 <20200810165004.02c4b5bf.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <2b5634bf-c39b-13db-924a-5efcbaddb238@linux.ibm.com>
Date: Mon, 10 Aug 2020 17:27:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200810165004.02c4b5bf.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XR1DH96nZb7EDCNVcSd8ZdymTl13ebfqI"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XR1DH96nZb7EDCNVcSd8ZdymTl13ebfqI
Content-Type: multipart/mixed; boundary="2Fh9l8zg6hqA8XpM0Gcac9IqiXAdmBFrF"

--2Fh9l8zg6hqA8XpM0Gcac9IqiXAdmBFrF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/10/20 4:50 PM, Cornelia Huck wrote:
> On Fri,  7 Aug 2020 07:15:55 -0400
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Test the error conditions of guest 2 Ultravisor calls, namely:
>>      * Query Ultravisor information
>>      * Set shared access
>>      * Remove shared access
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> ---
>>  lib/s390x/asm/uv.h  |  74 ++++++++++++++++++++
>>  s390x/Makefile      |   1 +
>>  s390x/unittests.cfg |   3 +
>>  s390x/uv-guest.c    | 162 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  4 files changed, 240 insertions(+)
>>  create mode 100644 lib/s390x/asm/uv.h
>>  create mode 100644 s390x/uv-guest.c
>=20
> (...)
>=20
>> +static inline int uv_call(unsigned long r1, unsigned long r2)
>> +{
>> +	int cc;
>> +
>> +	/*
>> +	 * The brc instruction will take care of the cc 2/3 case where
>> +	 * we need to continue the execution because we were
>> +	 * interrupted. The inline assembly will only return on
>> +	 * success/error i.e. cc 0/1.
>> +	*/
>=20
> Thanks, that is helpful.
>=20
>> +	asm volatile(
>> +		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>> +		"		brc	3,0b\n"
>> +		"		ipm	%[cc]\n"
>> +		"		srl	%[cc],28\n"
>> +		: [cc] "=3Dd" (cc)
>> +		: [r1] "a" (r1), [r2] "a" (r2)
>> +		: "memory", "cc");
>> +	return cc;
>> +}
>> +
>> +#endif
>=20
> (...)
>=20
>> diff --git a/s390x/uv-guest.c b/s390x/uv-guest.c
>> new file mode 100644
>> index 0000000..1aaf7ca
>> --- /dev/null
>> +++ b/s390x/uv-guest.c
>> @@ -0,0 +1,162 @@
>> +/*
>> + * Guest Ultravisor Call tests
>> + *
>> + * Copyright (c) 2020 IBM Corp
>> + *
>> + * Authors:
>> + *  Janosch Frank <frankja@linux.ibm.com>
>> + *
>> + * This code is free software; you can redistribute it and/or modify =
it
>> + * under the terms of the GNU General Public License version 2.
>> + */
>> +
>> +#include <libcflat.h>
>> +#include <alloc_page.h>
>> +#include <asm/page.h>
>> +#include <asm/asm-offsets.h>
>> +#include <asm/interrupt.h>
>> +#include <asm/facility.h>
>> +#include <asm/uv.h>
>> +
>> +static unsigned long page;
>> +
>> +static inline int share(unsigned long addr, u16 cmd)
>> +{
>> +	struct uv_cb_share uvcb =3D {
>> +		.header.cmd =3D cmd,
>> +		.header.len =3D sizeof(uvcb),
>> +		.paddr =3D addr
>> +	};
>> +
>> +	uv_call(0, (u64)&uvcb);
>> +	return uvcb.header.rc;
>=20
> Any reason why you're not checking rc and cc here...

Well, this is a helper function not a test function.
Since I can only return one value and since I'm lazy, I chose to ignore
the CC and went for the uvcb rc. That's basically also the answer for
your following questions.


Alright, I'll remove the helpers and execute those tests the hard way.

>=20
>> +}
>> +
>> +static inline int uv_set_shared(unsigned long addr)
>> +{
>> +	return share(addr, UVC_CMD_SET_SHARED_ACCESS);
>> +}
>> +
>> +static inline int uv_remove_shared(unsigned long addr)
>> +{
>> +	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
>> +}
>=20
> (...)
>=20
>> +static void test_sharing(void)
>> +{
>> +	struct uv_cb_share uvcb =3D {
>> +		.header.cmd =3D UVC_CMD_SET_SHARED_ACCESS,
>> +		.header.len =3D sizeof(uvcb) - 8,
>> +	};
>> +	int cc;
>> +
>> +	report_prefix_push("share");
>> +	cc =3D uv_call(0, (u64)&uvcb);
>> +	report(cc =3D=3D 1 && uvcb.header.rc =3D=3D UVC_RC_INV_LEN, "length"=
);
>=20
> ...while you do it for this command (as for all the others)?
>=20
>> +	report(uv_set_shared(page) =3D=3D UVC_RC_EXECUTED, "share");
>=20
> So, is that one of the cases where something is actually indicated in
> rc on success? Or does cc=3D0/1 have a different meaning for these call=
s?
>=20
>> +	report_prefix_pop();
>> +
>> +	report_prefix_push("unshare");
>> +	uvcb.header.cmd =3D UVC_CMD_REMOVE_SHARED_ACCESS;
>> +	cc =3D uv_call(0, (u64)&uvcb);
>> +	report(cc =3D=3D 1 && uvcb.header.rc =3D=3D UVC_RC_INV_LEN, "length"=
);
>> +	report(uv_remove_shared(page) =3D=3D UVC_RC_EXECUTED, "unshare");
>> +	report_prefix_pop();
>> +
>> +	report_prefix_pop();
>> +}
>=20
> (...)
>=20



--2Fh9l8zg6hqA8XpM0Gcac9IqiXAdmBFrF--

--XR1DH96nZb7EDCNVcSd8ZdymTl13ebfqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8xZ2gACgkQ41TmuOI4
ufgqXRAAhgnFVP+qfwdn134ONC6Oxhq4xHN6tooSsGKZ3E+XBaAS7R8nH9xVYk/1
5XEoV590p8U85JIjjWmntWwBQkhhgoSO+1ngr0TvcMfECnA2+9401JNsRWintvRM
YpVHP+RiJsCBMuIBM5keq/dG8A4od4XUbYbAsFaweR03TghleILQ6YnDRiT6PV5f
XMNgVZNzpe2ZMjnM12rE6H08n2MKQLME1Md7gO48xyk7MDDpH1WEHuuQO9HxrDQS
JFBvfLQKRO8QY50FS0E89oHrSBPiPw3Jt7T0FQ6CkelZPlS0I66gmRgEAIHO55xl
bbuR4pWGQVp21YATHEWn50U+Vlxt48r3esIfVpoM5ytVF587S7tEK+DbpFjcGByL
bZqRjXR1EkPyVyk15ar7m+FKNojc6J/FfBvmq5zlyX01/QlvNr0aEfRyX/DGAbHW
cqndC4B4uKmkUXcV3mZ7J6kQFFRYkyVcPmEtDQbOgb50P9F4tNiwUjoAwRl2CClW
RSBVZWG7q+zL4UsYVYxnLX0gpZVFuLQYdDI73FmSE75eM64O4+VAE5oBc+bqDAyC
cyVfwCJ40d5e7G/kSXIMJeL+mVKCD443C7Ck1WkuKqefA36aYaoqX2K6xjsDyvZS
jANbYANomFWAfkoGcF5al2AffBM4Gke1aT9oLTkQvWQZLoQWdzc=
=HxVR
-----END PGP SIGNATURE-----

--XR1DH96nZb7EDCNVcSd8ZdymTl13ebfqI--
