Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39140 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbgAPNEp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 08:04:45 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GD2QXa028254
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:04:44 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhfer2j9s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 08:04:43 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 13:04:41 -0000
Subject: Re: [kvm-unit-tests PATCH v2 3/7] s390x: Add cpu id to interrupt
 error prints
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-4-frankja@linux.ibm.com>
 <1bf32ccd-4047-7676-2ef4-a3327bf3995f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Jan 2020 14:04:37 +0100
MIME-Version: 1.0
In-Reply-To: <1bf32ccd-4047-7676-2ef4-a3327bf3995f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1EIMA5zOdNR3WrE45vaiaflsfcihjlQs3"
Message-Id: <95c0a6af-7334-1825-226e-5973a639035a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1EIMA5zOdNR3WrE45vaiaflsfcihjlQs3
Content-Type: multipart/mixed; boundary="HkNbuUB7EFq4VChJCVCmTB7lbaCxR4ims"

--HkNbuUB7EFq4VChJCVCmTB7lbaCxR4ims
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/16/20 1:17 PM, David Hildenbrand wrote:
> On 16.01.20 13:05, Janosch Frank wrote:
>> It's good to know which cpu broke the test.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/interrupt.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
>> index 05f30be..773752a 100644
>> --- a/lib/s390x/interrupt.c
>> +++ b/lib/s390x/interrupt.c
>> @@ -107,8 +107,8 @@ static void fixup_pgm_int(void)
>>  void handle_pgm_int(void)
>>  {
>>  	if (!pgm_int_expected)
>> -		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",=

>> -			     lc->pgm_int_code, lc->pgm_old_psw.addr,
>> +		report_abort("Unexpected program interrupt: %d on cpu %d at %#lx, i=
len %d\n",
>> +			     lc->pgm_int_code, stap(), lc->pgm_old_psw.addr,
>>  			     lc->pgm_int_id);
>=20
> nit: "cpu: %d"
>=20
>> =20
>>  	pgm_int_expected =3D false;
>> @@ -119,8 +119,8 @@ void handle_ext_int(void)
>>  {
>>  	if (!ext_int_expected &&
>>  	    lc->ext_int_code !=3D EXT_IRQ_SERVICE_SIG) {
>> -		report_abort("Unexpected external call interrupt (code %#x): at %#l=
x",
>> -			     lc->ext_int_code, lc->ext_old_psw.addr);
>> +		report_abort("Unexpected external call interrupt (code %#x): on cpu=
 %d at %#lx",
>> +			     stap(), lc->ext_int_code, lc->ext_old_psw.addr);
>=20
> nit: "(code %#x) on cpu: %d" ...

So, should I move the old : or add a second one?

>=20
> Same comment for the ones below
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20
>>  		return;
>>  	}
>> =20
>> @@ -137,18 +137,18 @@ void handle_ext_int(void)
>> =20
>>  void handle_mcck_int(void)
>>  {
>> -	report_abort("Unexpected machine check interrupt: at %#lx",
>> -		     lc->mcck_old_psw.addr);
>> +	report_abort("Unexpected machine check interrupt: on cpu %d at %#lx"=
,
>> +		     stap(), lc->mcck_old_psw.addr);
>>  }
>> =20
>>  void handle_io_int(void)
>>  {
>> -	report_abort("Unexpected io interrupt: at %#lx",
>> -		     lc->io_old_psw.addr);
>> +	report_abort("Unexpected io interrupt: on cpu %d at %#lx",
>> +		     stap(), lc->io_old_psw.addr);
>>  }
>> =20
>>  void handle_svc_int(void)
>>  {
>> -	report_abort("Unexpected supervisor call interrupt: at %#lx",
>> -		     lc->svc_old_psw.addr);
>> +	report_abort("Unexpected supervisor call interrupt: on cpu %d at %#l=
x",
>> +		     stap(), lc->svc_old_psw.addr);
>>  }
>>
>=20



--HkNbuUB7EFq4VChJCVCmTB7lbaCxR4ims--

--1EIMA5zOdNR3WrE45vaiaflsfcihjlQs3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4gX2UACgkQ41TmuOI4
ufjJfw//ZmW6d3TfJG9vmT0VnjupaIzWsXGfU8pc3Vr72kIw+bLYk3N7R4qnIxfU
Z2GzIEkXKhlZeHMER4UUM7KUzK3O3TuskjXF/AfKYQ27TFoyrsE00mk6041/jbI6
1t1AGlnRoo8Da+DOs9Zgtfqv42r5Sjs1BvuKsCDjji9GXzKeVNMSclA3Yr4Inu/y
hYgqrYIYnDO6qBLtvBqCPdeRdp1OjpEEDXoVCfkifuSjLo98u1EExzkN0hPJS1EQ
1/6/ZyO0CG4M0JCh77r6ShLKSfEMwSiuhwxC05wPm6Gkc7OS8kEq6qvJVwy+1lyy
wyQ278MWVMjS+SpPcD9BLGLPSA0nlvlZ3xLDKoMCl6ZoJderOlrqty3MvQajiNB9
1WMi4YrRuUZS4rGZ1r3kbBDWo8JA7hFT7DAYI2SrcsFHkik+XSyQSwq3b948JcWc
rNUbDJ4znZoVb+8RrYZep/fPSFFdFTair46CFdn30YkJvDZtSB4OsBFGmKpo2Wr2
Gfc5DE/XzA60s4iTVsC00gnlejyMTcLWQTiK5okzRWYDZyzdeiWfplofHao0bBIx
uE0yXvltdy4cq2YJUmp+Kn/rckkkBtwPTBM5sPY0/NcJ4EyRmKxR7y5Wd7/5oe0V
KZgvpAnXjzPKBWRmJemGYk2Mw0kmuv45qFWPpqDvIqTAPEiH744=
=XxUq
-----END PGP SIGNATURE-----

--1EIMA5zOdNR3WrE45vaiaflsfcihjlQs3--
