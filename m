Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728446AbfLKNJQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 08:09:16 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBD99NB025004
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 08:09:14 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3qutwf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 08:09:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Dec 2019 13:09:00 -0000
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: smp: Setup CRs from cpu 0
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-3-frankja@linux.ibm.com>
 <75eadbf8-1159-1c3f-12c4-bda518adb2ef@redhat.com>
 <15cd9f10-a56b-949d-dc0f-2d5aa175222a@linux.ibm.com>
 <03e80db5-dee7-b646-dd01-f713cdecbc29@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Dec 2019 14:08:56 +0100
MIME-Version: 1.0
In-Reply-To: <03e80db5-dee7-b646-dd01-f713cdecbc29@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5AdeKdskgbCNGvsXtyiHzeKlh6FGkEngy"
Message-Id: <73296143-98cb-bb86-924d-400bcc027c34@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5AdeKdskgbCNGvsXtyiHzeKlh6FGkEngy
Content-Type: multipart/mixed; boundary="2LKov2h9EZmuhkaoS9txAJOKrO626NqHc"

--2LKov2h9EZmuhkaoS9txAJOKrO626NqHc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 1:54 PM, David Hildenbrand wrote:
> On 11.12.19 13:37, Janosch Frank wrote:
>> On 12/11/19 1:32 PM, David Hildenbrand wrote:
>>> On 11.12.19 12:59, Janosch Frank wrote:
>>>> Grab the CRs (currently only 0, 1, 7, 13) from cpu 0, so we can
>>>> bringup the new cpu in DAT mode or set other control options.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  lib/s390x/smp.c  | 5 ++++-
>>>>  s390x/cstart64.S | 2 +-
>>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>> index e17751a..4dfe7c6 100644
>>>> --- a/lib/s390x/smp.c
>>>> +++ b/lib/s390x/smp.c
>>>> @@ -191,7 +191,10 @@ int smp_cpu_setup(uint16_t addr, struct psw psw=
)
>>>>  	cpu->lowcore->sw_int_grs[15] =3D (uint64_t)cpu->stack + (PAGE_SIZE=
 * 4);
>>>>  	lc->restart_new_psw.mask =3D 0x0000000180000000UL;
>>>>  	lc->restart_new_psw.addr =3D (uint64_t)smp_cpu_setup_state;
>>>> -	lc->sw_int_crs[0] =3D 0x0000000000040000UL;
>>>> +	lc->sw_int_crs[0] =3D stctg(0);
>>>> +	lc->sw_int_crs[1] =3D stctg(1);
>>>> +	lc->sw_int_crs[7] =3D stctg(7);
>>>> +	lc->sw_int_crs[13] =3D stctg(13);
>>>
>>> Wouldn't it be better to also be able to specify the CRs explicitly h=
ere?
>>>
>>
>> Yes, but currently there are no users for something like that and it
>> would mean that we might need to add more code to support it.
>>
>> As I said in the cover letter, this is a good first step to allow DAT =
on
>> additional cpus without any real setup needed in a test. Later we coul=
d
>> add a function to specify the CRs explicitly.
>>
>=20
> Can you clarify why we need this patch now (e.g., DAT)? This patch
> sounds like it would make sense in the future only (it is easier to
> review with future changes IMHO).
>=20

Some G1 UV calls need the home space and therefore I added this patch to
my concurrency tests which are still in my queue. I thought these fixes
might make sense anyway and could be flushed from my queue before the UV
patches are ready.


--2LKov2h9EZmuhkaoS9txAJOKrO626NqHc--

--5AdeKdskgbCNGvsXtyiHzeKlh6FGkEngy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3w6mgACgkQ41TmuOI4
ufiGKw/7BYczcEjHKVRzLYXWZxUpiONJfT9FAbelFzyDQHMTRPbDF3CZTr2WCBZC
FrKSghQWhfE/SwFTpozgUz6eARxVmZQYIFH9pH+N8kYX4ITyhRstsHTAwNeXI2ux
5ioAg1wMrx1huGN6noXn2TcD0z/7sHeLNRuta1gfmv1F9HNUwiOyCskY4zKnc5A2
TvYMYZ9IS+DyjE62rMksQpOJHipIDcA3gyqkzFT27xRw683BX5Gv+gaDOTeIvxCx
q5zjuS1o5jrPrPgRHOkqu0WVKI4nCHGGN0j4gwQAQkPO+dYs+TjurjSQ2d8jbNpn
TtmIFWMqKyVybx1CuoiUqxTLFZqWg2cSB8RANY567hA0C+0D1DCuv2cVbkMfywUW
GpIdjV8s22Z3rtWNSCnry9wC1sfK8+aAwbMZwgzpHmF8Ti7QyKssR9+X+QcCcYPg
lyp8oPwHziO2B9lNtgA+5Qs37MhLCeJdieb52MTejVBJbBNrgw805N7t5f4fTrDB
5Vi88914OuLExnb1gUt5oQoQT8QYHs3vGgpnItR+ES0m6+32914RMeYYGNspkCzB
kbaUIL1rT5snQe7/VjdgIEXF9EmiPWxxcUXEqAbQfSyNfD22uDidPncpO86xydT2
bhsGTgYIfdOnC9dcGUOEd54cx13a+y+VI9PCpBapqDJoXCWe0eI=
=ZWA3
-----END PGP SIGNATURE-----

--5AdeKdskgbCNGvsXtyiHzeKlh6FGkEngy--
