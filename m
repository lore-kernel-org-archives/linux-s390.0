Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbfKDOg3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:36:29 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4EVWHK067878
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 09:36:28 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w15etsr09-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 09:36:28 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 4 Nov 2019 14:36:24 -0000
Subject: Re: [RFC v2] KVM: s390: protvirt: Secure memory is not mergeable
References: <20191024114059.102802-8-frankja@linux.ibm.com>
 <20191025082446.754-1-frankja@linux.ibm.com>
 <7918ea28-8f10-dc1c-e35b-c1b66631877e@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 4 Nov 2019 15:36:18 +0100
MIME-Version: 1.0
In-Reply-To: <7918ea28-8f10-dc1c-e35b-c1b66631877e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qlm6EqTf1dsO56djSTen44M5QaX8Tgz1V"
Message-Id: <12ddbeda-5abb-fffa-ad1b-c2f0397c8391@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qlm6EqTf1dsO56djSTen44M5QaX8Tgz1V
Content-Type: multipart/mixed; boundary="MyBNEmq6mVodxH5aFuWY2RPaUUmg3YhQn"

--MyBNEmq6mVodxH5aFuWY2RPaUUmg3YhQn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/4/19 3:32 PM, David Hildenbrand wrote:
> On 25.10.19 10:24, Janosch Frank wrote:
>> KSM will not work on secure pages, because when the kernel reads a
>> secure page, it will be encrypted and hence no two pages will look the=

>> same.
>>
>> Let's mark the guest pages as unmergeable when we transition to secure=

>> mode.
>=20
> Patch itself looks good to me, but I do wonder: Is this really needed=20
> when pinning all encrypted pages currently?
>=20
> Not sure about races between KSM and the pinning/encrypting thread,=20
> similar to paging, though ...
>=20

The pinning was added several months after I wrote the patch.
Now that we have it, we really need to have another proper look at the
whole topic.

Thanks for your review :-)


--MyBNEmq6mVodxH5aFuWY2RPaUUmg3YhQn--

--Qlm6EqTf1dsO56djSTen44M5QaX8Tgz1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3AN2IACgkQ41TmuOI4
ufibKxAAzWf2FfOnLK7XzV1pIfyfpgIZPE5e6LaTHoBrZ96FIRfHGcpMy9GoM5jR
oAW89+EBS00vLIZC9VZl1xVtnuW9XOc+CqVkizAE3BD26r/jZ4P3G7Xp4PiqrfSd
JfiNn4UlZdjiAJPc15UwnwlvPrT1jkt0h9siqLO01gF7G9Mhg2FvwxWguUp5H+zl
hIHWkQBhuYKbYij+xqV0/tDUCJwkxtG5QB//D3GmNLJfstRxBazh4uw97Ya3HZ3I
13lUdAtGsqJnQYceTcZJG+BkXOAluMUhZafWADLUwFiy6Bbph0vMzKXHonT69f9I
8H1UnmCfjyiIm/UC+uA+W0N1g7g4og6QrmTJmY0Hiom+fU51OdCXdpiKDUFx4DVS
eOMKNAa4/xfhwmAoJBLeKJaUvbaUl8+NqB7GsQveDJ/WCsFJjObCm6PmQ/bsvr9n
HZPCRYZueCB3am9AVz0/8+ft18pCiKuKQbrjx8v1JuD5d5nqkVwFjFYaCN6hvXQL
apaw+zpkiCO75eDVqM3EpiYWvUJq2KDGgrG2hi4gPqvUmkUYrxzj7YkIgL0O2qRe
1wwecz2SbFUtlc3CBzPWCy1ifTTi44UtDUfDTa1wCOnylYol1Wi06f1lZFrRx8ba
QLnj5dQPxbnPLTtH7TfZWZtWpaEHfTEf101K6hIMuXlEKd6Yg8w=
=qD/y
-----END PGP SIGNATURE-----

--Qlm6EqTf1dsO56djSTen44M5QaX8Tgz1V--
