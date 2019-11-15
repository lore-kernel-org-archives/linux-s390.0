Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727122AbfKOLji (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 06:39:38 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFBWuKq087702
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:39:37 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w9nsfmf8p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 06:39:36 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 11:39:35 -0000
Subject: Re: [RFC 32/37] KVM: s390: protvirt: UV calls diag308 0, 1
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-33-frankja@linux.ibm.com>
 <6fb6b03f-5a33-34ec-53e6-d960ac7bbae6@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 12:39:29 +0100
MIME-Version: 1.0
In-Reply-To: <6fb6b03f-5a33-34ec-53e6-d960ac7bbae6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3bQ82cVqhvsl99zb1c8ikaBauLUWIlF3H"
Message-Id: <302337a3-5a1f-4ee9-2ee8-a10b7fe17479@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3bQ82cVqhvsl99zb1c8ikaBauLUWIlF3H
Content-Type: multipart/mixed; boundary="uDCDXCOpyalrvDHubmqFlnTYSk3CvC9sq"

--uDCDXCOpyalrvDHubmqFlnTYSk3CvC9sq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 11:07 AM, Thomas Huth wrote:
> On 24/10/2019 13.40, Janosch Frank wrote:
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>  arch/s390/include/asm/uv.h | 25 +++++++++++++++++++++++++
>>  arch/s390/kvm/diag.c       |  1 +
>>  arch/s390/kvm/kvm-s390.c   | 20 ++++++++++++++++++++
>>  arch/s390/kvm/kvm-s390.h   |  2 ++
>>  arch/s390/kvm/pv.c         | 19 +++++++++++++++++++
>>  include/uapi/linux/kvm.h   |  2 ++
>>  6 files changed, 69 insertions(+)
>=20
> Add at least a short patch description what this patch is all about?
>=20
>  Thomas
>=20

I'm thinking about taking out the set cpu state changes and move it into
a later patch.


How about:
diag 308 subcode 0 and 1 require KVM and Ultravisor interaction, since
the cpus have to be set into multiple reset states.

* All cpus need to be stopped
* The unshare all UVC needs to be executed
* The perform reset UVC needs to be executed
* The cpus need to be reset via the set cpu state UVC
* The issuing cpu needs to set state 5 via set cpu state


--uDCDXCOpyalrvDHubmqFlnTYSk3CvC9sq--

--3bQ82cVqhvsl99zb1c8ikaBauLUWIlF3H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OjnIACgkQ41TmuOI4
ufglfQ//XXyHr6b1BC6mRlVGms5WFZZJjTXYbGCisgRv8uefNE/brwSGkrhxAFZR
PNIzVY72RNGeuRqR26UlWojNzD8mmFSiHjnrkoZ5yBn0QZ+18odbiQUG7oZDKL66
qHkqnVfRmh+BDXblmnL+DHDNKPEFN5a8JLaLbU4Iay7TwJHTnfIgwAmqyMsCZOeG
8grufuG1YlBM2OfOzSfTiZkwdTaLYNiRQf9fk68ngY1vTqQTTJUd4LE3Te5vxAYi
50+KlU5s55FmduEQPySG0vQysqc2+z5ImiVBXOTKuM2s9blgbHqGfUcXsfJfpPzJ
ODv4LqPKPc2LmQFvSOzRwFnChZdqpy8izFg9NNf4ue+anQQmZmfArrrT9hPt3+gi
x8guIJksq29Gaq/QA4H+ESsSifQFWzWpcqCPwieorkLNTl1BeYfl2gJW8P4KQOOc
M8Xpmo5B43jc/ByI8OQ4n4dugYtMIhE0VLDhOEUdJJPyiwQ63f5fsDc5h+9hSq4y
Nc3U7e/ZFQuOPxzwW+DWZ1YvAAp4PzxkyUDYUaNaeM9+EmgB879gxK/GmtLBVfeX
TQFxDnFuQB2aD3+eUU3zytR+rhBDuoFwyqxJ3tCCONcmmN+A8PP8kX6BgfsCOq7B
miBukRDBeB42l95GBuXM9IqruN/EGuKlB6fRNnkI5V15EkKVk3k=
=NI/M
-----END PGP SIGNATURE-----

--3bQ82cVqhvsl99zb1c8ikaBauLUWIlF3H--
