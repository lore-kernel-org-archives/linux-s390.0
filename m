Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728668AbgAMJmK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 13 Jan 2020 04:42:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D9bfQJ036050
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 04:42:08 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvvadgx3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2020 04:42:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 13 Jan 2020 09:42:06 -0000
Subject: Re: [kvm-unit-tests PATCH v7 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
References: <20200110184050.191506-1-imbrenda@linux.ibm.com>
 <20200110184050.191506-4-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 13 Jan 2020 10:42:01 +0100
MIME-Version: 1.0
In-Reply-To: <20200110184050.191506-4-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gQCkLWppC3KO0jf0J0lgfemr3XWV3GSYm"
Message-Id: <656129b7-68f2-d3ab-7428-91999c896ca5@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gQCkLWppC3KO0jf0J0lgfemr3XWV3GSYm
Content-Type: multipart/mixed; boundary="DAyEugAIPJizDW2bOQCmPakqQDUW0EZDN"

--DAyEugAIPJizDW2bOQCmPakqQDUW0EZDN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/10/20 7:40 PM, Claudio Imbrenda wrote:
> Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
> use it instead of using inline assembly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> @@ -63,14 +60,10 @@ static void test_spx(void)
>  	 * some facility bits there ... at least some of them should be
>  	 * set in our buffer afterwards.
>  	 */
> -	asm volatile (
> -		" stpx	%0\n"
> -		" spx	%1\n"
> -		" stfl	0\n"
> -		" spx	%0\n"
> -		: "+Q"(old_prefix)
> -		: "Q"(new_prefix)
> -		: "memory");
> +	old_prefix =3D get_prefix();
> +	set_prefix(new_prefix);
> +	asm volatile("	stfl 0" : : : "memory");

Couldn't we also use stfl from facility.h here?
And do we need to add a memory clobber to it?

> +	set_prefix(old_prefix);
>  	report(pagebuf[GEN_LC_STFL] !=3D 0, "stfl to new prefix");
> =20
>  	expect_pgm_int();
>=20



--DAyEugAIPJizDW2bOQCmPakqQDUW0EZDN--

--gQCkLWppC3KO0jf0J0lgfemr3XWV3GSYm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4cO2kACgkQ41TmuOI4
ufjwew//ZLVywK4ZzLgVWt6js+wYNIOLMl2UT8dDMRJFLcP7TTrAhPJoYx02j2BC
UCpK1L15+opB1gzN2Lq4mZB2VOpF7ySAUQqdsVOXMEMwM8L70pcRgwfBgl5y0X00
Jwn/FJ83UAmS499droTda/vjHIby+Kz45YbUaOTa7HCgX0VTQ59rdqbhe/mMowqm
y0K2uOHRXsXd2+PAE0z5wmyYwsdRahCaObPO8i3r8pSWFPS3B6n1zTKa/c5EHDJd
VWFHtmvBN/vFTxgyyziHBJ6xVbxPrs/35YRjI4SK8ctHv4FE6qAZ0e8fYvAJCIvh
H7YcLfEVPXANa3UfjOHvtGfiyLuObqoFIbdD1EqvmTF/HRQHVURno9Epyu+U2TE0
oqydMLnk1gYKscOwj4g0EeB5rMmn3lYYyUtxa9NKdvu60Q4CKe2wDc6kTYOEIF0+
ioN0OtdoOfDH2DgruVvHg1Vud5PquDUPjdFPtm+R8bos+FT6x25MdRaODcZDpQq2
Cqp8xIeanweNfw+Q1HeT6jBhZ/wva9kUBg+ukppMXb/JNjC4UiMVnoG5JMcnmd2z
0IJedy9BBE+bOn8AC2GKo/3BfezqBwuXcyFx2X6B+8E68OZgqb3rx4qDy028+GVJ
yaySJk2q919mxtBOU+CunTMqgmCZTVmvBRlqnID3Gz7v6T6WJ08=
=tf7b
-----END PGP SIGNATURE-----

--gQCkLWppC3KO0jf0J0lgfemr3XWV3GSYm--
