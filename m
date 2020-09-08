Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730783AbgIHP5M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 11:57:12 -0400
Subject: Re: [PATCH v3] s390x: Add 3f program exception handler
References: <20200908075337.GA9170@osiris>
 <20200908130504.24641-1-frankja@linux.ibm.com>
 <20200908130655.GF14136@osiris>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <6551fde1-e19c-3b97-7a53-5a4dcb97f7bc@linux.ibm.com>
Date: Tue, 8 Sep 2020 15:09:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200908130655.GF14136@osiris>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2lqS40GK3SRE5oMpi6hZDXIojnrMFwXIo"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, david@redhat.com, cohuck@redhat.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lqS40GK3SRE5oMpi6hZDXIojnrMFwXIo
Content-Type: multipart/mixed; boundary="sBopP0Ojt78REKHyuYgq7QGiWQqZqEZQY"

--sBopP0Ojt78REKHyuYgq7QGiWQqZqEZQY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/8/20 3:06 PM, Heiko Carstens wrote:
> On Tue, Sep 08, 2020 at 09:05:04AM -0400, Janosch Frank wrote:
>> Program exception 3f (secure storage violation) can only be detected
>> when the CPU is running in SIE with a format 4 state description,
>> e.g. running a protected guest. Because of this and because user
>> space partly controls the guest memory mapping and can trigger this
>> exception, we want to send a SIGSEGV to the process running the guest
>> and not panic the kernel.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> CC: <stable@vger.kernel.org> # 5.7+
>> Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions =
handlers")
>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kernel/entry.h     |  1 +
>>  arch/s390/kernel/pgm_check.S |  2 +-
>>  arch/s390/mm/fault.c         | 20 ++++++++++++++++++++
>>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20
> I guess this should go upstream via the s390 tree?

Christian asked the exact same question.
I think we picked the secure/non-secure exception handlers via the s390
tree so bringing these in via s390 would be in line with that.

> Should I pick this up?

That would be nice


--sBopP0Ojt78REKHyuYgq7QGiWQqZqEZQY--

--2lqS40GK3SRE5oMpi6hZDXIojnrMFwXIo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl9XgoMACgkQ41TmuOI4
ufjLEg//QaXlmq2b+cwVWGYcuZonyMlyfKMSfdzv+f60wjq2J9j6/UdWtq6QG0DV
bJoyAnnEFX8OSZpx2/87RiNJa6fWoZ2QOyX1DJnHudeI8LNvoVCuvxDaboFMMVg4
2jUMTsfbHXVywi0POxz3NmzYNDWSfVAMAzNz3V02vJxQaPvukM/Ye2qR+V7gStQq
DguEQejBKZbQKm/Bi6/uKHG/ODT72L0i0e2ZykYLIT7GerY+aGTqq4opXK68Vgi/
0mz48D8XMTes/B8qcFJRC7xqRyifdoh3ZzE7cI9NoS0OOyht4noOjCURittL/9ky
a17J6c7vQK8lxQ6VWS1bETSQIGhNxbf8p/ccUgr9HfCymCTdBzYdfwF2jSSUfusN
jYwtlcTqDHUtPwf+9TAY5Sj572fEUH1pnPYeE/myEl7KzIprVXOWfW2BqbQI2dGa
Ahbol6Y8pmOQLPMpAXXBHxj1IwgwqXQeVBy4IpE1kcz1OQaUAFmx4XvOTIidtV2m
xVsjpF+58irASInatosQuLWtcygx87vrnWI16V+J/ESiB344HLmxhkEwOhbOv62W
1rSZGjM1ugfHuv9b0j+33/BTNOXKmehts7afRcfdsYaKzwQ+PMuSnWRYpk7/yFJm
HZ3RFPawJBN9yY6lgwkNYUNRDYqy63xrF4v+/Iqjo0lFBqBqodg=
=ZzRB
-----END PGP SIGNATURE-----

--2lqS40GK3SRE5oMpi6hZDXIojnrMFwXIo--
