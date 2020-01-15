Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgAOJAg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 04:00:36 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F8s0wG139086
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 04:00:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfaw0yvgh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 04:00:34 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 15 Jan 2020 09:00:31 -0000
Subject: Re: [kvm-unit-tests PATCH 2/4] s390x: smp: Only use smp_cpu_setup
 once
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-3-frankja@linux.ibm.com>
 <20200114184411.24909aae.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 15 Jan 2020 10:00:27 +0100
MIME-Version: 1.0
In-Reply-To: <20200114184411.24909aae.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="acuBhQRdI63FpCNTcRcqRnyKNvYaO86yE"
Message-Id: <059bd7a8-506f-306d-3287-1735979d622f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--acuBhQRdI63FpCNTcRcqRnyKNvYaO86yE
Content-Type: multipart/mixed; boundary="vvo2Ta3iSBUT2sNLpGZTrrdz3Y2TUboq1"

--vvo2Ta3iSBUT2sNLpGZTrrdz3Y2TUboq1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/14/20 6:44 PM, Cornelia Huck wrote:
> On Tue, 14 Jan 2020 10:30:51 -0500
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> Let's stop and start instead of using setup to run a function on a
>> cpu.
>=20
> Looking at the code, we only support active =3D=3D operating state and
> !active =3D=3D stopped state anyway, right?

Yes, although I think it might make sense to go over the active tracking
in the future and rather make it a setup tracking. We can always ask via
sigp run if the cpu is running. More stuff to add to the todo...

>=20
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  s390x/smp.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>=20



--vvo2Ta3iSBUT2sNLpGZTrrdz3Y2TUboq1--

--acuBhQRdI63FpCNTcRcqRnyKNvYaO86yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4e1KsACgkQ41TmuOI4
ufjWshAAxkdqN2YJiKHFUKQJevg8ZXo0UEdEGGgltjOkr/et3FTib6FpBj25PMnK
esqakbi7UE0iP6eOxjo/zKkxTOhENHCXsugdQPZukZIc0UUNU+sL915jM0s2RXCZ
u8xWSBIy/JKALN3qPGD0FORpmQ9RYFay5xk5SEEK4egs9894XbJBdV+1VHE+TZe9
aP/g0B1rlDB7/vPgcDtEIeT7SZ8kTNmlAbJ99qICsTb3ewxqZSlYldbg4L85av8P
jmP7VPv/K+Xx1vmR5hzld9Pmr3ouS33THJRrBd5Azx8XlRtihDou7PpcLfOziZMJ
uCXrTX2EcrW4RssibScQTatoDrVeXJ1iDFtjkn32tQi39lv6uWEq6Tx2+EZXOYTB
XIMI08qpJ3BZme4Gwh0gkgzqLCrBcfvNdaKT/BUbOhX4ZsD8a+j3wv84+eHOMImS
audmETN2Cg2pXypJqdoC/6i3oEgNViZbFVihuZEkrNNr3J/CMYROEVwMNlWXlXO8
3oLq8f7XChJbSe+dMjtayD/7NcQSW7RKuJBT84NBv5BhK3TFSteR6o8WEdR3D4bq
+neCJFR7bpVwuJDitXQ7RmPESdC7O1Y4jsbgIBdP7eRWFtADTKePZOgRXkF/utpC
FTNbmhtzQ0i1b1kIt/f40b4YCMmmGO54IUX+zbV/6GbfVgP0IKY=
=euXN
-----END PGP SIGNATURE-----

--acuBhQRdI63FpCNTcRcqRnyKNvYaO86yE--
