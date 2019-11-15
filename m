Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43172 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727135AbfKOL3X (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 06:29:23 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFBIXFw081031
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:29:22 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9ntp26qx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:29:22 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 11:29:21 -0000
Subject: Re: [RFC 31/37] KVM: s390: protvirt: Add diag 308 subcode 8 - 10
 handling
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-32-frankja@linux.ibm.com>
 <a1c263ff-954e-a7c3-28b4-e9bd866eb35f@redhat.com>
 <f9ecf949-3f0d-fb64-cc77-44974a71625e@linux.ibm.com>
 <e8e80d38-ef63-c394-0e5d-9dbfdfc5241f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 12:29:17 +0100
MIME-Version: 1.0
In-Reply-To: <e8e80d38-ef63-c394-0e5d-9dbfdfc5241f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jB3xc5ru6Joy6ApSC1UgSyEyV90vV5YLH"
Message-Id: <e0c5be8d-098b-757b-a16f-518f9f2babce@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jB3xc5ru6Joy6ApSC1UgSyEyV90vV5YLH
Content-Type: multipart/mixed; boundary="nsmLRT3e0diBm61H0p7aqVJhYtEVplJnG"

--nsmLRT3e0diBm61H0p7aqVJhYtEVplJnG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 11:27 AM, Thomas Huth wrote:
> On 15/11/2019 11.20, Janosch Frank wrote:
>> On 11/15/19 11:04 AM, Thomas Huth wrote:
>>> On 24/10/2019 13.40, Janosch Frank wrote:
>>>> If the host initialized the Ultravisor, we can set stfle bit 161
>>>> (protected virtual IPL enhancements facility), which indicates, that=

>>>> the IPL subcodes 8, 9 and are valid. These subcodes are used by a
>>>> normal guest to set/retrieve a IPIB of type 5 and transition into
>>>> protected mode.
>>>>
>>>> Once in protected mode, the VM will loose the facility bit, as each
>>>
>>> So should the bit be cleared in the host code again? ... I don't see
>>> this happening in this patch?
>>>
>>>  Thomas
>>
>> No, KVM doesn't report stfle facilities in protected mode and we would=

>> need to add it again in normal mode so just clearing it would be
>> pointless. In protected mode 8-10 do not intercept, so there's nothing=

>> we need to do.
>=20
> Ah, ok, that's what I've missed. Maybe replace "the VM will loose the
> facility bit" with "the ultravisor will conceal the facility bit" ?
>=20
>  Thomas
>=20


Sure


--nsmLRT3e0diBm61H0p7aqVJhYtEVplJnG--

--jB3xc5ru6Joy6ApSC1UgSyEyV90vV5YLH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OjA0ACgkQ41TmuOI4
ufh5Ig/9H7AjtYgpl1363tWmKonMGds+RIqETYgGcNd23xQ4zRYgXdZpPBw5fJxw
GVO4iDx3s4Am2IEqHLIvbzoFqywH9YeTHIu+moOxL091usM1UMUb+NIkg5Ny09o9
hANHMzsbKo5OiPXy+OO+T0L93skU6RVlqXiXj/QIbXoeAI2Apm27vgoBWVHDcjNl
k7UTUIb8hMqTa32xjImOTHomhiohYyHYSVGoPgI33rA7nl3iFgkB0WaidwfvSaOZ
7q0/uQrYXe5+/Bd68nhhLiF+Ak+yC6P/pRo/7dt/EBZg7rnQRsEDwxx234mBGAw9
QKDPMes742RjIckuLc4octH4ZiC2Ses0ltkYjPaW3nPqMcByf4YLPExlZXdtNr8D
E0VOpbDMSxfGZ0nH9mjuQcwXSpuKWwh2nl8U+5JH8QooNn0l0EPA+CafvFDASZN1
OgtqbDq8FG6D8cC3FxJ2M7kgYsikrg1cVGJa7qBrdfmXFEtE/GeP3VKWpY/TnwlK
NrPK3gFX07tSiH3iMhivku5NLXSutBDb3yX+2O0RP8vSxLtOxj9UxOCwbfQP6OAf
WK1N1gsZCFMFohvOHRo9udVjaNqE01DHs9JAFdu1LbKqwNRLPee3+gyo7Smm2Hkm
htoRMUdKPMleuvFl2GF/ZegGe9wc5ra5uSUH98KIPY+Ce4lHfUM=
=2s8H
-----END PGP SIGNATURE-----

--jB3xc5ru6Joy6ApSC1UgSyEyV90vV5YLH--
