Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407252AbfIWJsd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 05:48:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8N9lFYc128747
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 05:48:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v6sjgn4as-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 05:48:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 23 Sep 2019 10:48:30 +0100
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix stsi unaligned test and add
 selector tests
References: <20190920075020.1698-1-frankja@linux.ibm.com>
 <9dd9362d-f8e2-a573-3833-376039dbc570@redhat.com>
 <97e39625-6675-6d01-b1da-dd6d0758c943@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 23 Sep 2019 11:48:25 +0200
MIME-Version: 1.0
In-Reply-To: <97e39625-6675-6d01-b1da-dd6d0758c943@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tg1FfXXdLA1URLzSi8EjVp6EkD41og7gw"
Message-Id: <b78fcfa7-7c80-b1c2-aecb-e72b6df91dbc@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tg1FfXXdLA1URLzSi8EjVp6EkD41og7gw
Content-Type: multipart/mixed; boundary="4AwPXWZOg9PjidYx5fqxLgjTbBMIMHY9o";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Message-ID: <b78fcfa7-7c80-b1c2-aecb-e72b6df91dbc@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix stsi unaligned test and add
 selector tests
References: <20190920075020.1698-1-frankja@linux.ibm.com>
 <9dd9362d-f8e2-a573-3833-376039dbc570@redhat.com>
 <97e39625-6675-6d01-b1da-dd6d0758c943@redhat.com>
In-Reply-To: <97e39625-6675-6d01-b1da-dd6d0758c943@redhat.com>

--4AwPXWZOg9PjidYx5fqxLgjTbBMIMHY9o
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/23/19 10:10 AM, Thomas Huth wrote:
> On 20/09/2019 10.10, David Hildenbrand wrote:
>> On 20.09.19 09:50, Janosch Frank wrote:
>>> Alignment and selectors test order is not specified and so, if you
>>> have an unaligned address and invalid selectors it's up to the
>>> hypervisor to decide which error is presented.
>>>
>>> Let's add valid selectors to the unaligned test and add selector
>>> tests.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  s390x/stsi.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>>> index 7232cb0..c5bd0a2 100644
>>> --- a/s390x/stsi.c
>>> +++ b/s390x/stsi.c
>>> @@ -35,7 +35,7 @@ static void test_specs(void)
>>> =20
>>>  	report_prefix_push("unaligned");
>>>  	expect_pgm_int();
>>> -	stsi(pagebuf + 42, 1, 0, 0);
>>> +	stsi(pagebuf + 42, 1, 1, 1);
>>>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>>  	report_prefix_pop();
>>> =20
>>> @@ -71,6 +71,8 @@ static inline unsigned long stsi_get_fc(void *addr)=

>>>  static void test_fc(void)
>>>  {
>>>  	report("invalid fc",  stsi(pagebuf, 7, 0, 0) =3D=3D 3);
>=20
> While you're at it, wouldn't it be better to use "(pagebuf, 7, 1, 1)" h=
ere?

The selectors depend on the command, so they need to be checked after
the command. I don't think it would make much sense to change the zeroes
here.

>=20
>  Thomas
>=20
>=20
>>> +	report("invalid selector 1", stsi(pagebuf, 1, 0, 1) =3D=3D 3);
>>> +	report("invalid selector 2", stsi(pagebuf, 1, 1, 0) =3D=3D 3);
>>>  	report("query fc >=3D 2",  stsi_get_fc(pagebuf) >=3D 2);
>>>  }
>>> =20
>>>
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>=20



--4AwPXWZOg9PjidYx5fqxLgjTbBMIMHY9o--

--tg1FfXXdLA1URLzSi8EjVp6EkD41og7gw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2IlOkACgkQ41TmuOI4
ufiSDQ//RncgsRfuOc/O6oiD1uw2RDJQt72LnmSluNoxiD5T/4M8BLDhSn7rb21D
0LC9oj2ub2CW1kDzNZAN9t6cvtx5CQ70SuiQcmSv6WkfKZ2C41sK0RvnW3ZA5SAi
bnVeRjQT45ZZlbANClrSG9WJnK1OHIFbHAQfEWMaWxQKgcL2xAlRlZJd4+pN9jIv
Znzavbx+kG84N/90OwpmMqeNrHsgmfS41JrcDraFVc8LuAub1AeIVXj2Ubo8zu4b
wXo6bzVvhQGEg7uN+lP6Td6kSRdYT9DaYj5AF1Jz45sdyXuzPYvGl68XgWLhiH2a
yLDzx36MB2Cya46+pTOMzcSmcqHUmCerLTjd9Jt03wj4edssdk3RdVdGw6+0T2EY
F77JBzzW0KS5H53UDZEYzVv8fwAtbFOQhhKo2a/Y72ldRoeIjpLWiSbv0F4XdG5C
HjxSnet8RpeI+0xfnZFdKpQhQjnAEvrr6DIUXtBMAD9dVICoBlhUHZwHjjJvDQKu
lKDXpVZ9uho4igsA/VtnAiTSAx2I65PNMx3RF5MBUwmfrqi5M/uKs//FLoTg//QT
WIeFCkERn7vKlEjSPa/tSsADXnQhDaq7t1/3D554QTdFFZo0sZUzGGLWf4aYbVqw
/spDG/eh1yPF45HiRwiOp4gHFFtNys8InzXeCWAsxD8RvOrP/60=
=ABlo
-----END PGP SIGNATURE-----

--tg1FfXXdLA1URLzSi8EjVp6EkD41og7gw--
