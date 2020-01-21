Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728898AbgAUMmq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 07:42:46 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LCRrbQ045948
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 07:42:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xp0s6smtm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 07:42:44 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 12:42:42 -0000
Subject: Re: [kvm-unit-tests PATCH v8 3/6] s390x: lib: fix stfl wrapper asm
References: <20200120184256.188698-1-imbrenda@linux.ibm.com>
 <20200120184256.188698-4-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 21 Jan 2020 13:42:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200120184256.188698-4-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="quuTmsiBH6EGIWg18aiIsx07wsRB3U10r"
Message-Id: <935179b9-1f06-18b9-1481-57cad01e4c8a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--quuTmsiBH6EGIWg18aiIsx07wsRB3U10r
Content-Type: multipart/mixed; boundary="qLpyjib2fOG3ywvbbscXu9cUwLiJsazD4"

--qLpyjib2fOG3ywvbbscXu9cUwLiJsazD4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/20/20 7:42 PM, Claudio Imbrenda wrote:
> the stfl wrapper in lib/s390x/asm/facility.h was lacking the "memory"
> clobber in the inline asm.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/asm/facility.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/s390x/asm/facility.h b/lib/s390x/asm/facility.h
> index 5103dd4..e34dc2c 100644
> --- a/lib/s390x/asm/facility.h
> +++ b/lib/s390x/asm/facility.h
> @@ -24,7 +24,7 @@ static inline bool test_facility(int nr)
> =20
>  static inline void stfl(void)
>  {
> -	asm volatile("	stfl	0(0)\n");
> +	asm volatile("	stfl	0(0)\n" : : : "memory");
>  }
> =20
>  static inline void stfle(uint8_t *fac, unsigned int len)
>=20

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>


--qLpyjib2fOG3ywvbbscXu9cUwLiJsazD4--

--quuTmsiBH6EGIWg18aiIsx07wsRB3U10r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4m8b0ACgkQ41TmuOI4
ufhmphAAvbCTR5yj2K8oNOQBQLM9WBEEZMYKhTx09aXThbqDl/E2YXQSxKQ0j3gj
mMcJHBYAN966H1XypnGhZC9ix0ANM0h3RZYZ5JX04yGvdLIEOBB4aJ7tYgxaxmqH
RxMMXgNr6u3w9wAa1iCnt68Gz2953XOUQEP2hzZAc7cRr+3EBFI1l/7wxtbDGK05
AiQ74skPKxdBrhwJjTfxBw7I/+g0gNwMnLxgKmuDmiA8TiZqRliRnUGvwS2Vf/5E
NZ8jWuvedkHNFPaserT0ofLJvBbkZ7F/lvu+2Y2l6B36bhfSLjH5Qf2G7uoLUDQe
zH7JIDPLR26uBRSJmLQj9oFc70J3FrXAdxQ6ClfhpjAwnBf+5JkrAkYGJwTaSepS
WzEeod2nrwMJ951koPWWi2dQvK3bL/3zNTQwjDxB0RHPP67gIzzSAskxUjH17Fot
UXtAta6fYNuJ1bgYpL+ZRCPSyVWlS/MlGl2BeLN7FsWefysRJroUkTm666/To8ov
vdM0u64nlnlLWeHIktnNf/oVSnJw1YJqy5HwunhBLRjL4z1xmvfJOo0l3kMdjKqI
LVwwAFtMmAIq7BxF8zGisAs1ewwnSiFJx5P8mhPrpnm/OXDtvLKRJvYBTyekLKeo
u7YGwmUek3TTi/QMzi0Kd2hcoxCFS2PQv3WoPYlgZqj19+UBp/8=
=FPfz
-----END PGP SIGNATURE-----

--quuTmsiBH6EGIWg18aiIsx07wsRB3U10r--
