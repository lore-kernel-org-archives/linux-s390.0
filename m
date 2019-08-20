Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729707AbfHTLtR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 07:49:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KBlUa0050817
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 07:49:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugg74r9we-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 07:49:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 20 Aug 2019 12:49:14 +0100
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <cc5291cd-0bd8-73aa-dfdc-f0cf9de4f405@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 20 Aug 2019 13:49:09 +0200
MIME-Version: 1.0
In-Reply-To: <cc5291cd-0bd8-73aa-dfdc-f0cf9de4f405@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="M99FZaYYGJU8BNewfv04iLvxa4mqMb1GY"
Message-Id: <0f6187b2-9ff1-c645-9d64-5e3384999306@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M99FZaYYGJU8BNewfv04iLvxa4mqMb1GY
Content-Type: multipart/mixed; boundary="BcuBR1rCJGFE5Yoic7kElnlTvUCqllWco";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com
Message-ID: <0f6187b2-9ff1-c645-9d64-5e3384999306@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
 <cc5291cd-0bd8-73aa-dfdc-f0cf9de4f405@redhat.com>
In-Reply-To: <cc5291cd-0bd8-73aa-dfdc-f0cf9de4f405@redhat.com>

--BcuBR1rCJGFE5Yoic7kElnlTvUCqllWco
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 1:11 PM, David Hildenbrand wrote:
> On 20.08.19 12:55, Janosch Frank wrote:
>> The first patch allows for CECSIM booting via PSW restart.
>> The other ones add diag288 and STSI tests.
>>
>> I chose to start with these since they are low controversy. My queue
>> still contains the sclp patches and a simple smp library with
>> tests. They will follow later.
>>
>> Janosch Frank (3):
>>   s390x: Support PSW restart boot
>>   s390x: Diag288 test
>>   s390x: STSI tests
>>
>>  s390x/Makefile      |   2 +
>>  s390x/diag288.c     | 111 +++++++++++++++++++++++++++++++++++++++
>>  s390x/flat.lds      |  14 +++--
>>  s390x/stsi.c        | 123 +++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |   7 +++
>>  5 files changed, 252 insertions(+), 5 deletions(-)
>>  create mode 100644 s390x/diag288.c
>>  create mode 100644 s390x/stsi.c
>>
>=20
> Just wondering, did you try them with TCG as well? (or do I have to tes=
t)
>=20

No, they are also pending for z/VM and LPAR testing (well at least for
STSI).
They have been running with a fmt2 and a fmt4 SIE description though.

I'll speak with the CI people here to add a TCG test.


--BcuBR1rCJGFE5Yoic7kElnlTvUCqllWco--

--M99FZaYYGJU8BNewfv04iLvxa4mqMb1GY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl1b3jUACgkQ41TmuOI4
ufinuA//fObB7Gdszy9q12aONuQupTKA4MlIT34Vq/Lz2/M2qgPWXaQQVHCaSLSx
xtkYwfibMw7mdOYU1IbBPZEsEDiznqjLiKJHFwVCM+DosPPoqSjvpclYqYYFvoHW
nheJpUpcujFFhTj1HP2HZ6nKF92E1b0lu7a16/F/7dKPmMouVzQDBY3eQaVXlkD0
bukuOl7DwZg5aXvbHdj8SpyNdw+oH1rI/YrpguZ7rtSmEWlKyll7AAtKi2MYVLQG
ZqokRofDc0gjD/mPNqRU/PKHUWkonou0i/ymRCF1S3qJ92lz46husI0luxzUFJ6X
HzwneS6FaR6Eb7QFAC/tocT0CT4ouwhi55/VfRK6fkx7zqe2hAvfV11ftRy+FD1Y
9nXEHG4MW5mfK5dZ95ZwaGiwHVN0kthtZK06cjwxgO/Y7+Co51ExiE5UeP+Fn9S1
MA+JDwzla2ANZpKZcfglLRSbEzVkwwsO+0JU3F+GmzOjZ/3LnSF++ntZ49+3CUD9
Q8ZalgL02XIscJ7Xrs4DXWntctgd5vczaDhwfj8aNCmFtCTRDjJQz5UNFXzOLLlp
ouauT1l0HMOod+q5iiOj686jc4yNl0iw1wTzjuXvLyYtpJFyxOOLm2+Sup2loY+l
UCqOWPeqbAFDw0lWqZ4UZH/nT7/A9aORxcyUlAWchNecxdVIbVg=
=Vvpw
-----END PGP SIGNATURE-----

--M99FZaYYGJU8BNewfv04iLvxa4mqMb1GY--
