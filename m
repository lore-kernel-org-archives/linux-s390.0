Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgA3Mts (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jan 2020 07:49:48 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UCbn1B005751
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 07:49:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtfh1wumk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 30 Jan 2020 07:49:46 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 30 Jan 2020 12:49:45 -0000
Subject: Re: [PATCH v9 3/6] KVM: s390: Add new reset vcpu API
From: Janosch Frank <frankja@linux.ibm.com>
References: <20200130123434.68129-1-frankja@linux.ibm.com>
 <20200130123434.68129-4-frankja@linux.ibm.com>
Date: Thu, 30 Jan 2020 13:49:39 +0100
MIME-Version: 1.0
In-Reply-To: <20200130123434.68129-4-frankja@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bvvVmBDlp5cCx94shjEp2qrD3hTreMYOn"
Message-Id: <9d64917a-2a0a-46e7-0d78-da2f31eb01c4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bvvVmBDlp5cCx94shjEp2qrD3hTreMYOn
Content-Type: multipart/mixed; boundary="W0MvrVqfXCrGrxBJ7LKkkyqzFIZycrrsJ"

--W0MvrVqfXCrGrxBJ7LKkkyqzFIZycrrsJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/30/20 1:34 PM, Janosch Frank wrote:
> The architecture states that we need to reset local IRQs for all CPU
> resets. Because the old reset interface did not support the normal CPU
> reset we never did that on a normal reset.
>=20
> Let's implement an interface for the missing normal and clear resets
> and reset all local IRQs, registers and control structures as stated
> in the architecture.
>=20
> Userspace might already reset the registers via the vcpu run struct,
> but as we need the interface for the interrupt clearing part anyway,
> we implement the resets fully and don't rely on userspace to reset the
> rest.

My rebase conflict fix did miss the removal of the old initial reset
function...


--W0MvrVqfXCrGrxBJ7LKkkyqzFIZycrrsJ--

--bvvVmBDlp5cCx94shjEp2qrD3hTreMYOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4y0OMACgkQ41TmuOI4
ufi43g/9EMi2nUQRENk4kqnfL0bqFuuzuo4Fi11N6kpFg3E1Fjbw6gwVUzg+3E2I
Z+E/8QeUcTGkruVXr1MkjUJY8BZ4V5iPUKpGvk3KMmqt1BRniqUXB7uoYQnhuy6E
2k8yg9Yfl3KbZIros588BLtbQUnSYS7ORgTAl0oZhkhG9WvUof/EKTZWxt+k7rVS
S0nIXDQqEEmK8YPZTyrQwZesXET13aXE6cYYDQawYsxGwb6b3XhKStiGS/V8HoGF
12yEN/GL7XJEkLZgkvq1ihw4ffoeX9U8uc6cJbdBE+C9uaGUIbwiYwpk1M2vBLKk
EUmIPa9dCD4WYaoxbS3J6zsrmWNdiDmJ0E3EQJR+TPPSb3q24Tbq7uHSx3cZ5jO6
J7eCxbkbT5c3EydHxF+2Mzo8stxYn5ChwMND9yVerPtDWGFRQzDhyx5EaLUECiKe
xX4+6ftwVQnPCrQsQzvCQdx/mCgChjbUB3A7fNEfbG4NnxBJx1lwjoVD/UQ8PGWB
4MaQ+NR8GQJM3MRv2kEItqXleYXmb0h+FpSGPOFNgVWBwUHF39FkHeYLDZVgQldS
TTYdfqiMBJvyma+irhCtmSv8+4iuIDa4FCeFvoS8Jl5T6hOUs+3GROGgjsIkPieY
8o6d84seSrnU13BZmQQM1c9G/KipIvGYIJhaBZ2me80UEw2nTJI=
=kWUp
-----END PGP SIGNATURE-----

--bvvVmBDlp5cCx94shjEp2qrD3hTreMYOn--
