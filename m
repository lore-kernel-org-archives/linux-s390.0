Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728915AbgAOH6m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jan 2020 02:58:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F7waKD122825
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 02:58:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xhbpse729-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 02:58:38 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 15 Jan 2020 07:57:33 -0000
Subject: Re: [kvm-unit-tests PATCH 3/4] s390x: smp: Test all CRs on initial
 reset
References: <20200114153054.77082-1-frankja@linux.ibm.com>
 <20200114153054.77082-4-frankja@linux.ibm.com>
 <2f190b0a-e403-51e6-27da-7f8f1f6289ac@de.ibm.com>
 <f120ad03-aab1-a863-636b-b11898d634f5@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 15 Jan 2020 08:57:28 +0100
MIME-Version: 1.0
In-Reply-To: <f120ad03-aab1-a863-636b-b11898d634f5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vBBbXmGcok3QF50FuB84aEgrJ7w3XsN9e"
Message-Id: <3ee92240-56dc-69af-4fca-a4a2156e7749@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vBBbXmGcok3QF50FuB84aEgrJ7w3XsN9e
Content-Type: multipart/mixed; boundary="AFAUkDHrXccdbAl0TboW8fxUjDYvGY1Q1"

--AFAUkDHrXccdbAl0TboW8fxUjDYvGY1Q1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/15/20 7:17 AM, Thomas Huth wrote:
> On 14/01/2020 19.42, Christian Borntraeger wrote:
>>
>>
>> On 14.01.20 16:30, Janosch Frank wrote:
>>> All CRs are set to 0 and CRs 0 and 14 are set to pre-defined values,
>>> so we also need to test 1-13 and 15 for 0.
>>>
>>> And while we're at it, let's also set some values to cr 1, 7 and 13, =
so
>>> we can actually be sure that they will be zeroed.
>>
>> While it does not hurt to have it here, I think the register check for=
 the reset
>> would be better in a kselftest. This allows to check userspace AND gue=
st at the
>> same time.
>=20
> Agreed. Especially it also allows to test the kernel ioctl on its own,
> without QEMU in between (which might also clear some registers), so for=

> getting the new reset ioctls right, the selftests are certainly the
> better place.

Selftests are in development and will be up for discussion this week if
all goes well...

While the selftest leaves QEMU out of the picture, we're still using
kernel APIs to fetch and reset data, so actually getting guests'
register values requires some fiddling in the guest code. So I rather
have a test that tells me if KVM + QEMU are correct at the beginning of
testing, since that's what most people are using anyways.



--AFAUkDHrXccdbAl0TboW8fxUjDYvGY1Q1--

--vBBbXmGcok3QF50FuB84aEgrJ7w3XsN9e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4exegACgkQ41TmuOI4
ufjYLA/+NNuT0cVRCYpHl1I5cZ9RScsSBF7Nwg5DlhFADBp2wmnAiJ3cBWuKxPA7
J1vb1HVI2KGjAw7xbLMbxh0cZRkogM/6oJG7wfnBPwYxCHD/K4uYiuaEdAQ/9C7a
Y+0TUVJM0fpvZourC1s7QooQTIsoLXwdexYEhlfVjYRfAJDJ0bCUJvk2R2W7LdeF
8qBdB0mb8UNqhlKvZw/Ey4hfykOEgAfrNLc/cGmg1UWtpYr8M0p5Z6W7Df96zBVG
Y3zIiBOX5gFLpdz5LLey0wdWtu5c3mNrAoR+6EN3s+nwmxBm0ueIrxCSKL288vAK
hNXto970AZgiN4I3yvOzvgvFg6PXK57CPbjO1T+enXpsLouwgNPWz9a1Cz7wKRrv
JNClvOmJ09Jy4liFC9ZcDP1Fi32+yWGaYzznV52sXDOMHFjouxH3L0V9MO5nHSCL
5RqbsDGdWam8m4/cZtah3FA6BEgeHBoFg8erCVFHagiyYJGTwujEyp8rGOEyteHD
VqDRbyp6QHWLmF70gNeXqSpzYxVs6NJ1xpOhBGRXR8Ki8aYPjhQbAR1AfLSSF7PA
UDD7WAfwks9cjGIYQMuXzwc2E0POk0B8giJCpoP4xOUTpqWgCBDAb1gyAk6/XqjS
Lwq9XYvkfAH6s0vxSM+x2t9gezIuB0rjJ7F8pCUeHclNdlYo46w=
=4inW
-----END PGP SIGNATURE-----

--vBBbXmGcok3QF50FuB84aEgrJ7w3XsN9e--
