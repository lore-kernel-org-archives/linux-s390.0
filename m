Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgBKIsW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 03:48:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01B8j4BL173306
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 03:48:21 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3pqf4c6m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 03:48:21 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 11 Feb 2020 08:48:19 -0000
Subject: Re: [PATCH/RFC] KVM: s390: protvirt: pass-through rc and rrc
References: <62d5cd46-93d7-e272-f9bb-d4ec3c7a1f71@de.ibm.com>
 <20200210114526.134769-1-borntraeger@de.ibm.com>
 <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
 <20200210135040.24f06b8e.cohuck@redhat.com>
 <b99afb71-c8cb-0608-6583-99ac482f8322@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 11 Feb 2020 09:48:12 +0100
MIME-Version: 1.0
In-Reply-To: <b99afb71-c8cb-0608-6583-99ac482f8322@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BQUqFhgX2rlYL0SVPmKEYxwmTkwimyL3b"
Message-Id: <b1cef696-d5c6-a5f2-0635-99d8bc52fc7f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: thuth@redhat.com, Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BQUqFhgX2rlYL0SVPmKEYxwmTkwimyL3b
Content-Type: multipart/mixed; boundary="p1HaBuY7QJVQrcRmWIPbRV0Py0j1NCqak"

--p1HaBuY7QJVQrcRmWIPbRV0Py0j1NCqak
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/10/20 1:56 PM, Christian Borntraeger wrote:
>=20
>=20
> On 10.02.20 13:50, Cornelia Huck wrote:
>> On Mon, 10 Feb 2020 13:06:19 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> What about the following. I will rip out RC and RRC but add=20
>>> a 32bit flags field (which must be 0) and 3*64 bit reserved.
>>
>> Probably dumb question: How are these new fields supposed to be used?
>=20
> This was planned for error handling in QEMU. As we have no user of rc/r=
rc
> yet, I have ripped that out and added a flag field + 16 bytes of reserv=
ed.
> Usage is as usual flags must be 0. When flags!=3D0 the reserved fields =
will
> have a new meaning.=20
>=20

I want to have the rcs because right now we would only output the return
value of the ioctl and most UV error codes are mapped to -EINVAL. So if
an error occurs, admins would need to match up the crashed VM with the
UV debugfs files which might not even exist if debugfs is not mounted...

That's also one of the reasons I like having separate create calls for
VM and VCPUs.


--p1HaBuY7QJVQrcRmWIPbRV0Py0j1NCqak--

--BQUqFhgX2rlYL0SVPmKEYxwmTkwimyL3b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5CakwACgkQ41TmuOI4
ufgCrxAAzAMinYoB8+uxdkjA/EcRRdfXsZnrRdhg8dxlCUZnXR2DfK+j15lacENE
lDP2ndhtYYEVcizedeljEoaNw94AHw7eb8LafNX54ASAVwKxMVh0PexH1J240dAy
++LAn/pGQh92RkYQXPBeicHgioLiw3bmjC3VW+IHxF8oCMBb1+j/0y8lXleOaF2Q
V1CeaqMXnw2+FSxbyN1xHwyZsn4XCQYLveOB1CJMB31dn6IEe3Xwn5Y70rx3KZ2j
Z3wnt4YLq15aCccOD4uoRJOfm2Ru8RNT06QyXZkLhx0ySMco+E6gH90dLKHE5MUA
FmwZCrMFB10QwAyyJ5DD4ijECfBV+nOwo/5XAE0GRIsVDxCZum4ArympTIo5GDra
bQkp0VZC1RPlu1OrAqf2AHHXsZFLSH65ZwLTx40hMocri2sG19JF8f7Ai4daoY/G
dCmmGfSaYjGiCQ116x2t9KdVpGLF5ZlaWzQDkGpEAi6MMrVaN5/6w7gUsDzoQYWi
dwL8eH51D5d1lT6IP2KayAERORpsHauat+AjFr4PaFrp4EawyhO/MJXWqXkU6Y7W
mTz+6QqBqFCVXZTIniZYnRZrEA3/T/GlDgrLQ8xs3Sz1MvqpApMiuSe2bv4Djzxk
BguPdkxlPAAAUSnXpKh/8OiRWRh2hiKhYKGXKMF/NOFiibk7ASg=
=LV3H
-----END PGP SIGNATURE-----

--BQUqFhgX2rlYL0SVPmKEYxwmTkwimyL3b--
