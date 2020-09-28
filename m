Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbgI1IWt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 28 Sep 2020 04:22:49 -0400
Subject: Re: [PATCH v1 2/4] s390x: pv: implement routine to share/unshare
 memory
References: <1601049764-11784-1-git-send-email-pmorel@linux.ibm.com>
 <1601049764-11784-3-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <6c87a0ef-63ef-a0b8-58ff-d60e58bdb223@linux.ibm.com>
Date: Mon, 28 Sep 2020 10:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <1601049764-11784-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wlCwQ6Ss9n5G0nlWIqOLmcEv41lkqv5Og"
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wlCwQ6Ss9n5G0nlWIqOLmcEv41lkqv5Og
Content-Type: multipart/mixed; boundary="Rzxd9G4bNo0gXEvb26jVDBGQpEComrMrA"

--Rzxd9G4bNo0gXEvb26jVDBGQpEComrMrA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/25/20 6:02 PM, Pierre Morel wrote:
> When communicating with the host we need to share part of
> the memory.
>=20
> Let's implement the ultravisor calls for this.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Suggested-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 4c2fc48..19019e4 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -71,4 +71,37 @@ static inline int uv_call(unsigned long r1, unsigned=
 long r2)
>  	return cc;
>  }
> =20
> +static inline int share(unsigned long addr, u16 cmd)
> +{
> +	struct uv_cb_share uvcb =3D {
> +		.header.cmd =3D cmd,
> +		.header.len =3D sizeof(uvcb),
> +		.paddr =3D addr
> +	};
> +
> +	uv_call(0, (u64)&uvcb);
> +	return uvcb.header.rc;

That's not a great idea, rc is > 1 for error codes...
In the kernel we check for the cc instead since uv_call() has only 0/1
as possible cc return values.

> +}
> +
> +/*
> + * Guest 2 request to the Ultravisor to make a page shared with the
> + * hypervisor for IO.
> + *
> + * @addr: Real or absolute address of the page to be shared
> + */
> +static inline int uv_set_shared(unsigned long addr)
> +{
> +	return share(addr, UVC_CMD_SET_SHARED_ACCESS);
> +}
> +
> +/*
> + * Guest 2 request to the Ultravisor to make a page unshared.
> + *
> + * @addr: Real or absolute address of the page to be unshared
> + */
> +static inline int uv_remove_shared(unsigned long addr)
> +{
> +	return share(addr, UVC_CMD_REMOVE_SHARED_ACCESS);
> +}
> +
>  #endif
>=20



--Rzxd9G4bNo0gXEvb26jVDBGQpEComrMrA--

--wlCwQ6Ss9n5G0nlWIqOLmcEv41lkqv5Og
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9xnVEACgkQ41TmuOI4
ufgrNg//SZGk2WtnjZ6BsyX9qY3dtFy4pt6J3yxgwnNMOAUPUbQ17nyRdXoTI20G
1XW9IyXC/R5cijZ43ih6jcd4oz+l4HfbMIRIPZdEX32GMTjDGxbbmEqxfL9uHz1h
1NXwJ5M8hE5GasyyZG50jlrp+awGgZ45K1/jDfuef2Okfa3+EjJWjgQ3mUrjxblC
EctRzteBXQPGxy2nUP45CvESt0Q/bTOQsQZkCqWQpRcM6IvKDlNMAwdEZ2i00qb0
wmIix5bEFfVPspd6vCJ/t1EQK1+FOef2BPafaL0ldadgQdS38KHYjtEgaPSkDlEE
jlifaQJNvS1m2xN4oSRzXZEUJxmogAjyHy8Dv943YZJiOnPrBhavaEnas5jauojf
dGVGOzYNUy7Tz2YYyLPIWaYKcY0pJJ+/DsH0jSoHQKY2Tiz8MIV2L0rugDQQzlVN
QcHl2+FOvJ+crCKHUAhgTRvXJmjn5s2qqdnv2Fz6VJxEy4W6JM4Ey+E8ejimo2qt
OGgPrgcMGmhTNDcm5hHvSJX1T10U1A+temW4jT9OsYKvLR1aPKOrDeM+3JOz8Zx6
Sc56Kf1cTfvZs0VBj9FipsKn68KDlEGU9JafE/1iUcdJWsSbSOcIARdA82mVT+Br
E6g5qEOKWhn0zUcp3aV8SMHJT1IvyqEH/QcvUF4F9bkFY6Fuwds=
=Offx
-----END PGP SIGNATURE-----

--wlCwQ6Ss9n5G0nlWIqOLmcEv41lkqv5Og--
