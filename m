Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727423AbfKOOIP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 Nov 2019 09:08:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDt50u094609
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 09:08:14 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9nsjs53m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 15 Nov 2019 09:08:14 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 15 Nov 2019 14:08:12 -0000
Subject: Re: [RFC 32/37] KVM: s390: protvirt: UV calls diag308 0, 1
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-33-frankja@linux.ibm.com>
 <6fb6b03f-5a33-34ec-53e6-d960ac7bbae6@redhat.com>
 <302337a3-5a1f-4ee9-2ee8-a10b7fe17479@linux.ibm.com>
 <76e04877-93c5-0785-290e-4d8739b4c4b8@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 15 Nov 2019 15:08:06 +0100
MIME-Version: 1.0
In-Reply-To: <76e04877-93c5-0785-290e-4d8739b4c4b8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CPmz1e8ItJrBNcHxfq8kHxKu5dJ1kIE68"
Message-Id: <e7bef954-6244-7a04-10ff-422490603f36@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CPmz1e8ItJrBNcHxfq8kHxKu5dJ1kIE68
Content-Type: multipart/mixed; boundary="lUA5fxpMNikueqjutFFqm3ZOFu8fsy5wY"

--lUA5fxpMNikueqjutFFqm3ZOFu8fsy5wY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/15/19 2:30 PM, Thomas Huth wrote:
> On 15/11/2019 12.39, Janosch Frank wrote:
>> On 11/15/19 11:07 AM, Thomas Huth wrote:
>>> On 24/10/2019 13.40, Janosch Frank wrote:
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  arch/s390/include/asm/uv.h | 25 +++++++++++++++++++++++++
>>>>  arch/s390/kvm/diag.c       |  1 +
>>>>  arch/s390/kvm/kvm-s390.c   | 20 ++++++++++++++++++++
>>>>  arch/s390/kvm/kvm-s390.h   |  2 ++
>>>>  arch/s390/kvm/pv.c         | 19 +++++++++++++++++++
>>>>  include/uapi/linux/kvm.h   |  2 ++
>>>>  6 files changed, 69 insertions(+)
>>>
>>> Add at least a short patch description what this patch is all about?
>>>
>>>  Thomas
>>>
>>
>> I'm thinking about taking out the set cpu state changes and move it in=
to
>> a later patch.
>>
>>
>> How about:
>> diag 308 subcode 0 and 1 require KVM and Ultravisor interaction, since=

>> the cpus have to be set into multiple reset states.
>>
>> * All cpus need to be stopped
>> * The unshare all UVC needs to be executed
>> * The perform reset UVC needs to be executed
>> * The cpus need to be reset via the set cpu state UVC
>> * The issuing cpu needs to set state 5 via set cpu state
>=20
> Could you put the UVC names into quotes? Like:
>=20
> * The "unshare all" UVC needs to be executed
>=20
> ... I first had to read the sentence three times to really understand i=
t.
>=20
>  Thomas
>=20

Sure, just did


--lUA5fxpMNikueqjutFFqm3ZOFu8fsy5wY--

--CPmz1e8ItJrBNcHxfq8kHxKu5dJ1kIE68
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3OsUYACgkQ41TmuOI4
ufhZlhAA1aG5W3aYZTV6zFy8rhFBSK3FyfNQFtWhS+nLwZd247Loit4uxbLwiCAm
NoFErkJ++3Dr/V20yw+BQ3Y81CtM5rOzDb6/2h2JBqkUbLiAuaMdo+/NfFFov5uO
QKBcgsnasZO9Ss+B4JxnojNruCkYxgtrFL45h8J1MBp1ubqvSlbBRW65Gd4FqDv3
vk46aHlRwkDCQD7HiS5Qw1jnsBM79Mi72X+VhWaQysM1HcioqzVi3WmkRM9lzKeJ
ABmLyjsFGQRhkUagaveIst4bnS9J7qFXAT/4iVlw28svpRm6P1ME52NkobJbovRE
2wnpR5vP5fyLdKzEQiivjxNm/0beMw1yquveTwrJVbVcsQDkwO0ZXlW+ITCHHC8N
7vYx9v41zzldw5yVp90yqVJ7raD+e42MruJ1U5aIiYqZ425B6MIk3P4ZVywSTGP3
AIOs4C1thQxjwo4xme8BcfmSjzuGy1TE2EMAdhptWrlAnxoWqM+A73aLQPJaSGC+
pz+Ig1o7qI8pumdFeykYr/GqlkC34yctQnc7QfC2RRzumQzr2cCI7BNkTG9s9Y6L
fsD9DG8eXJ009ht65xx2yvqew5/j8Ml2yqPrelHG77G6ojk9Oq73dMcovqtDRbYZ
+tWOFpjPPGxfFVJDSEOLzdLC5FdtG7ryiR26Op+uNahEGeIE5rk=
=uj5w
-----END PGP SIGNATURE-----

--CPmz1e8ItJrBNcHxfq8kHxKu5dJ1kIE68--
