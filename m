Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731859AbgEZKmU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 06:42:20 -0400
Subject: Re: [kvm-unit-tests PATCH v7 10/12] s390x: define function to wait
 for interrupt
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-11-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <23933f4c-490c-0c16-c8b6-84a7630130f7@linux.ibm.com>
Date: Tue, 26 May 2020 12:42:13 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-11-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yK5YDiyeqFmfuidpbCvDtZAseF9L2xpDw"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yK5YDiyeqFmfuidpbCvDtZAseF9L2xpDw
Content-Type: multipart/mixed; boundary="bqJW5babBlSQOyVbsnwE1GuFSqghh2302"

--bqJW5babBlSQOyVbsnwE1GuFSqghh2302
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/18/20 6:07 PM, Pierre Morel wrote:
> Allow the program to wait for an interrupt.
>=20
> The interrupt handler is in charge to remove the WAIT bit
> when it finished handling the interrupt.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  lib/s390x/asm/arch_def.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 54ffd0b..f200e28 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,9 +10,11 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
> =20
> +#define PSW_MASK_IO			0x0200000000000000UL
>  #define PSW_MASK_EXT			0x0100000000000000UL
>  #define PSW_MASK_DAT			0x0400000000000000UL
>  #define PSW_MASK_SHORT_PSW		0x0008000000000000UL
> +#define PSW_MASK_WAIT			0x0002000000000000UL
>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>  #define PSW_MASK_BA			0x0000000080000000UL
>  #define PSW_MASK_EA			0x0000000100000000UL
> @@ -253,6 +255,18 @@ static inline void load_psw_mask(uint64_t mask)
>  		: "+r" (tmp) :  "a" (&psw) : "memory", "cc" );
>  }
> =20
> +static inline void wait_for_interrupt(uint64_t irq_mask)
> +{
> +	uint64_t psw_mask =3D extract_psw_mask();
> +
> +	load_psw_mask(psw_mask | irq_mask | PSW_MASK_WAIT);
> +	/*
> +	 * After being woken and having processed the interrupt, let's restor=
e
> +	 * the PSW mask.
> +	 */
> +	load_psw_mask(psw_mask);
> +}
> +
>  static inline void enter_pstate(void)
>  {
>  	uint64_t mask;
>=20



--bqJW5babBlSQOyVbsnwE1GuFSqghh2302--

--yK5YDiyeqFmfuidpbCvDtZAseF9L2xpDw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7M8oUACgkQ41TmuOI4
ufgOmg//XuStg+2IytwlY4I/rasxInlO8iF6gqiHLHGeDyJyjijXiwLgxJrpz1hA
vDf7nTw36HvJ4IpQNQJ1hGYptgyKQqMgYNRck+rFmV2cd/BVkdNUBSUG0YUqUqDU
How62G8/oexYRFp/E7t1Zt1APgV+l95i/gQVCuBgjiO7RmFDfAZT8c0kxxLngBWr
vhf1TMXzCgNRNroxv/xdA8MbRlYi84SjEvFDaWfiYZp2Fe++gwsKvuy0BFNbKR9C
DBenIKYBD3mPBR+McUpyX36cuKvr7sdcqah8vgVkuArqvcBHxmBXnCfw0QEtrcKX
3LBOgDENLsu6GXZ8TRCNeTyWHKPYB2Rk3r+fnzer9JDekY+UquiXqFJgaZgznCk5
VpILTE0T8KlUj/lpq/myBez2iS2L0uAj8maGGJu5bvFBHWudC+Qzstmtoxmea9ZW
chQ5aM2vmMI2/WF3TQyDH5WAgiA8bTr5/CkrrE+YrjSu1BkjUWfONH0Yku1d71PF
N75GU2ANdVLrtPTdCpit7RiZoAB2gVf2U3xmUzi8vjCDU0okL/5VYdDKW98fdUHu
oduUP6OkK+85riRwcoF7JUlcgXRDnsgwBwG5BnNOxzd7WTQp3+0TfH8QTADGw5AD
faJD7uA0O6REKqZeYCD4fYgI0nm3WdWdHYagFxUbVDAf56hFHJM=
=AKtk
-----END PGP SIGNATURE-----

--yK5YDiyeqFmfuidpbCvDtZAseF9L2xpDw--
