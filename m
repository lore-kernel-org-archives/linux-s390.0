Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbgD0M7Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 08:59:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03RCVrl3030808
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2020 08:59:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30me43qsjm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2020 08:59:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 27 Apr 2020 13:58:54 +0100
Subject: Re: [kvm-unit-tests PATCH v6 08/10] s390x: define wfi: wait for
 interrupt
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-9-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 27 Apr 2020 14:59:15 +0200
MIME-Version: 1.0
In-Reply-To: <1587725152-25569-9-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mycbVbn5uu8M1vWxaCunLpYhu3ubA0Y3w"
Message-Id: <4cc33b1c-7fa2-0775-f176-08bb31b7e68e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mycbVbn5uu8M1vWxaCunLpYhu3ubA0Y3w
Content-Type: multipart/mixed; boundary="lbduyF0MwG5HewJENdIo9eOj9Xs9ORyDe"

--lbduyF0MwG5HewJENdIo9eOj9Xs9ORyDe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 12:45 PM, Pierre Morel wrote:
> wfi(irq_mask) allows the programm to wait for an interrupt.

s/programm/program/

> The interrupt handler is in charge to remove the WAIT bit
> when it finished handling interrupt.

=2E..finished handling the interrupt.

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index a0d2362..e04866c 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -13,6 +13,7 @@
>  #define PSW_MASK_EXT			0x0100000000000000UL
>  #define PSW_MASK_DAT			0x0400000000000000UL
>  #define PSW_MASK_SHORT_PSW		0x0008000000000000UL
> +#define PSW_MASK_WAIT			0x0002000000000000UL
>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>  #define PSW_MASK_BA			0x0000000080000000UL
>  #define PSW_MASK_EA			0x0000000100000000UL
> @@ -254,6 +255,16 @@ static inline void load_psw_mask(uint64_t mask)
>  		: "+r" (tmp) :  "a" (&psw) : "memory", "cc" );
>  }
> =20
> +static inline void wfi(uint64_t irq_mask)

enabled_wait()

> +{
> +	uint64_t psw_mask;

You can directly initialize this variable.

> +
> +	psw_mask =3D extract_psw_mask();
> +	load_psw_mask(psw_mask | irq_mask | PSW_MASK_WAIT);

Maybe add a comment here:

/*
 * After being woken and having processed the interrupt, let's restore
the PSW mask.
*/

> +	load_psw_mask(psw_mask);
> +}
> +
> +
>  static inline void enter_pstate(void)
>  {
>  	uint64_t mask;
>=20



--lbduyF0MwG5HewJENdIo9eOj9Xs9ORyDe--

--mycbVbn5uu8M1vWxaCunLpYhu3ubA0Y3w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6m1yQACgkQ41TmuOI4
ufigsw/5Ac+eGbJ2JtbVvHuSKnEB1eYHOzaRiMaK5ysc/ipzYUOY2aNBxn4hhneU
18Q97gbzPTZbIx8/RlXBXPIj6vZbyeJhbdqCUF3LbDQ/NoEToXyukrww7bM7PDsT
j5OpJgPbHzuw+7hJdCjk88wCw4yiMVIRGlvfjrW6QsM2YaC740ZfsjDUELfltWZC
XeqtOgq2YzmNZO6uwKbQ7ceXRBd7D9yskqwodkrHi2lkcvitkRv6mFvFOGY3UaA6
UK8LoETczOaGW+eeWLFskzM5K74l+SGuyY5YZgdgJcdko4KJk85NtSs9NINK4hyu
wZPjN7LnJDghfyOD5oFlQ4w59gqXo21k0ZkxPwjVZHyVnV5w7x+nd9xPtK4Fijeu
3a9PwHMfwlL8meo5Rj8Ng+a8Msh3+2ukgpEg384+NFZdE9kyof7sQQ688CC9D6w2
a4h0PkE8Rqw/GkTMG47Fxs/TuFWXFk2IQ4YxybtQ4XOaUeeEolr5rjUUPJIBnrmw
3E2nKRXR8jtboHwZJRTESWNvcBu8JHnmf6EyCAUgFCmKOck+VaFl/jOlFLWKxa34
hjCtwp3mSv5ZRwvvHvWpKejDm+D4i1u9WxSjiLUZ1g6yxrH6AD2/jVrRBFTVyWzC
xhFeB+0N+B007jRj+AcaMvJPfh6dMwajgD1KB0a3FAsPZbDCexs=
=l8OX
-----END PGP SIGNATURE-----

--mycbVbn5uu8M1vWxaCunLpYhu3ubA0Y3w--
