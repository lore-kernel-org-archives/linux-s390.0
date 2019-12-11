Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64548 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729255AbfLKMh2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 11 Dec 2019 07:37:28 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBCYRdf129532
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 07:37:27 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc29pgk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 11 Dec 2019 07:37:26 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 11 Dec 2019 12:37:25 -0000
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: smp: Setup CRs from cpu 0
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-3-frankja@linux.ibm.com>
 <75eadbf8-1159-1c3f-12c4-bda518adb2ef@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 11 Dec 2019 13:37:20 +0100
MIME-Version: 1.0
In-Reply-To: <75eadbf8-1159-1c3f-12c4-bda518adb2ef@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aJcP21YyZphwg8MoH3DjiGgQIPxGKKRwr"
Message-Id: <15cd9f10-a56b-949d-dc0f-2d5aa175222a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aJcP21YyZphwg8MoH3DjiGgQIPxGKKRwr
Content-Type: multipart/mixed; boundary="pvzVCQyYO9xvCrYZFOMFM6cjot25DfdiL"

--pvzVCQyYO9xvCrYZFOMFM6cjot25DfdiL
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 1:32 PM, David Hildenbrand wrote:
> On 11.12.19 12:59, Janosch Frank wrote:
>> Grab the CRs (currently only 0, 1, 7, 13) from cpu 0, so we can
>> bringup the new cpu in DAT mode or set other control options.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/smp.c  | 5 ++++-
>>  s390x/cstart64.S | 2 +-
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>> index e17751a..4dfe7c6 100644
>> --- a/lib/s390x/smp.c
>> +++ b/lib/s390x/smp.c
>> @@ -191,7 +191,10 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>>  	cpu->lowcore->sw_int_grs[15] =3D (uint64_t)cpu->stack + (PAGE_SIZE *=
 4);
>>  	lc->restart_new_psw.mask =3D 0x0000000180000000UL;
>>  	lc->restart_new_psw.addr =3D (uint64_t)smp_cpu_setup_state;
>> -	lc->sw_int_crs[0] =3D 0x0000000000040000UL;
>> +	lc->sw_int_crs[0] =3D stctg(0);
>> +	lc->sw_int_crs[1] =3D stctg(1);
>> +	lc->sw_int_crs[7] =3D stctg(7);
>> +	lc->sw_int_crs[13] =3D stctg(13);
>=20
> Wouldn't it be better to also be able to specify the CRs explicitly her=
e?
>=20

Yes, but currently there are no users for something like that and it
would mean that we might need to add more code to support it.

As I said in the cover letter, this is a good first step to allow DAT on
additional cpus without any real setup needed in a test. Later we could
add a function to specify the CRs explicitly.


--pvzVCQyYO9xvCrYZFOMFM6cjot25DfdiL--

--aJcP21YyZphwg8MoH3DjiGgQIPxGKKRwr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3w4wAACgkQ41TmuOI4
ufgtExAAtrg3hHfo/dUwjv3cRUefXkcDs3Ta1w3MKEozD3r1Yf/9vLwYXMEAdhQA
juA1bnFKrHGIkk06ntPgexRzezWFWc1I4zfm7ha5LvC0OHS97dMAzBsk3sbmZA1a
ffl38Xptm0Y+VqS90tulY1zor+8uhheCnLK59fdYW2KHy/RP/Aa31J9UxvxmxgFx
VJRPNF/b2hRF7icYwFR7dPD7cAbyxFkrzYauQ2YEg6VQBl9sSEXACfacoJNhTQPK
9NQo33gLi2EKRCNrSweGapUk/DycWEmVVIqkv60a5eUiaqz9thDw0iss4wngVZ/4
rFFCfpFbFdA9ns7rGtk0Hn+T4tufzpTCfP6x659p6gB13gRWxGb78tDxCdHmILEP
zDe6kIDgKubOVI2PllxGmKJ7OR8oaG7qIen/uwEOwWvEUeDZNbGaw8HkfR03loNN
VsdJ/5ijBDRW6FTNLZXmq9KirlZ7h7j/XkupfvT9iuz+FMDNu7ZpwPhicpac7cNW
r1xzIoN20f9phZllW5ec4VEB4sv4U88kqLU/xJHWG1gDr+D8D+Qs2/qSSuDa7gCE
XbCfJ1prZb75GobJVz46225xLQEfxOJdmJPzTyOc0vzHsPJtWVqjPLgY0vAfOj1f
liP72Q+DHILMOIsXCBwmCfobFbjbEwYSrv/uHT6tGkbbmBQ69FY=
=7DdQ
-----END PGP SIGNATURE-----

--aJcP21YyZphwg8MoH3DjiGgQIPxGKKRwr--
