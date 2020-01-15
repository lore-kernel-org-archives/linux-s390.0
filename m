Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgAONDW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 08:03:22 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FD2ehs099003
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 08:03:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhfey6nxb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 08:03:21 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 15 Jan 2020 13:03:19 -0000
Subject: Re: [kvm-unit-tests PATCH 0/4] s390x: smp: Improve smp code and reset
 checks
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <cd2fd0eb-13fa-ae3e-df3b-15131cc02df5@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 15 Jan 2020 14:03:13 +0100
MIME-Version: 1.0
In-Reply-To: <cd2fd0eb-13fa-ae3e-df3b-15131cc02df5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f4FDjorcFy9buTFo4uxplKCJXH7Cqh7TH"
Message-Id: <a7e84601-5cbd-5bf1-2e37-1c8e19217c43@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f4FDjorcFy9buTFo4uxplKCJXH7Cqh7TH
Content-Type: multipart/mixed; boundary="3ZUJK08hYINwYBGs5Lyq7r56plQooqjSz"

--3ZUJK08hYINwYBGs5Lyq7r56plQooqjSz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/15/20 11:47 AM, David Hildenbrand wrote:
> On 14.01.20 16:30, Janosch Frank wrote:
>> The first two patches are badly needed cleanup for smp.c.
>> The last two improve initial reset testing.
>>
>> Janosch Frank (4):
>>   s390x: smp: Cleanup smp.c
>>   s390x: smp: Only use smp_cpu_setup once
>>   s390x: smp: Test all CRs on initial reset
>>   s390x: smp: Dirty fpc before initial reset test
>>
>>  s390x/smp.c | 84 ++++++++++++++++++++++++++++++++++++----------------=
-
>>  1 file changed, 58 insertions(+), 26 deletions(-)
>>
>=20
> I assume you will resend, right? So I'll wait with queuing.
>=20

Yes, please wait


--3ZUJK08hYINwYBGs5Lyq7r56plQooqjSz--

--f4FDjorcFy9buTFo4uxplKCJXH7Cqh7TH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4fDZEACgkQ41TmuOI4
ufj/dg/9E+1VOFQxnt5A5NdtYODy4Wypd1JmZKIvWasbbMBRFTpMf5LSzjsjPRAT
sUBLgMxzdntS1fSNaOTSNCKj6gNU4xlTfW0ywQxvSXB1XdjC1+swISQeIkkQksXo
7Thbv3WYzWHtpqxvcZmu5vE0Mqg8Jfyd2YOg39p2sNKDwTouBiy6Q9aJBhFwNmTK
96BDpu9qD9N/IKOOxGWCBXb0LLzEKM6KvZ4/0LTtkKKbOvzf5b/YIT4cBqFsVRMm
BRHSKAOTATCnIDSKYeqysXE0pxT7JXM7aksEsJt776KGbnGC/kdUiqexQ7JsvrB4
2RPxuJ1hcGz90o42XFRJPSRjsggQqjQAh6Qq72T7s/05byDBXRp7jyOpmGMvWiNI
VGeNHCTGU05yltz6Ohb/L/m3n39vzF6lLc8ss5aL3rx6v7EBniT+IxkwWAsDzTfW
whjTc5ye/0SzYUL/1rEZhGl6cwAZTF+/CsZGNaHTIfu/J8xkRRDTzgaWOzkWItt2
ygosqxxBH2ly3hQO5GIoIrH/R3bblxzAEHdHyQk2MiJB5O0FwxkXavzciDVoW8ly
X0Bb/rZlEFnt8hJPzGj/Yk6yUvST5u0KJv98/IJf2k0VGUv8AJbcjchQoeT3cy4i
uzSnHbmmi4OF8dttpO72fTlvaoU9P7MqVBmeY/WrdG5RehooRKo=
=aLHo
-----END PGP SIGNATURE-----

--f4FDjorcFy9buTFo4uxplKCJXH7Cqh7TH--
