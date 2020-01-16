Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgAPOLy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 09:11:54 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GE9woR112809
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 09:11:53 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xjmynh5u3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 16 Jan 2020 09:11:52 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 16 Jan 2020 14:11:51 -0000
Subject: Re: [kvm-unit-tests PATCH v2 3/7] s390x: Add cpu id to interrupt
 error prints
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-4-frankja@linux.ibm.com>
 <20200116145953.331ac8f5.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 16 Jan 2020 15:11:43 +0100
MIME-Version: 1.0
In-Reply-To: <20200116145953.331ac8f5.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="P1qfXPLVpx1Le0XPvaEzJWPq7AEC5rDS5"
Message-Id: <5c454b26-c888-04fe-70e1-6d4ee554dc00@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P1qfXPLVpx1Le0XPvaEzJWPq7AEC5rDS5
Content-Type: multipart/mixed; boundary="g5LdhQonT8DsnztcnOAWXIsWGin50Yrv8"

--g5LdhQonT8DsnztcnOAWXIsWGin50Yrv8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/16/20 2:59 PM, Cornelia Huck wrote:
> On Thu, 16 Jan 2020 07:05:09 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> It's good to know which cpu broke the test.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  lib/s390x/interrupt.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> With whatever formatting tweaks you choose:
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Thanks!


I think I might just stick with the old formatting.


--g5LdhQonT8DsnztcnOAWXIsWGin50Yrv8--

--P1qfXPLVpx1Le0XPvaEzJWPq7AEC5rDS5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4gbx8ACgkQ41TmuOI4
ufiOPRAAxNvKlIiHNenUy69c1Etb3H1041xAJSanhYCcsiEgOQv7d5FAel8H0qyj
odGDS4JxBVOWBcobG1EuCQjJ3vufGG46WVPKT5NlA2tWb89/nGAIPbbLnnn2a/4S
Ct93CYeksrZ89sNVFYKXOl1PuADhyX0SU3QQoAK2/M4tE1zwiMRd9VK2Sz9yXElv
vNDVz5N+RWlaerrlGfu9m8nB3R0+c1dzxBb/x1GtPBEg3Jz9XxjpZRUcovcjpgT2
2K4xWgWZEgY6OKq12j5/X8yPdFPR4NlGyiN6ZDZx6N//Jhwy8IFnSnwHglKrTKgs
BE/bB8CcnJFkSfiq/f+0qM3eWC7SISF2t28kgLrl/3YWK3WABuIEIvd1rlv8ChdK
oXo12ZmLivq9Qm1yIXiwDeQoth+bWhNxH2QEOx7Ix9ck/jZGnjuVMKnU44CcDNld
oEgVsEt1T2179O8qwyG3/MuzkC6GJgGST3HqEPDBJgroplzMW0MB5yu/HxRHdQ2/
CfGe8rVJ8BTlDkI3h3EO/4W9LxPPpCKE7kGHZiv0oqssR93NsUqLdAhNks/mPP/+
KFzFdK8eK+W/qWcdpPijZyc2DUUMli329imhC1ycqy1Dvygj1jthG3Xae1FnqRSO
ncRKxUtq/rLLsgyWYP+DbI3JHL6REenwWqqZOM87ORlebcnzwjk=
=OWRj
-----END PGP SIGNATURE-----

--P1qfXPLVpx1Le0XPvaEzJWPq7AEC5rDS5--
