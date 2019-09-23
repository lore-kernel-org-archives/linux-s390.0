Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40136 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407478AbfIWKAM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 06:00:12 -0400
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix stsi unaligned test and add
 selector tests
References: <20190920075020.1698-1-frankja@linux.ibm.com>
 <9dd9362d-f8e2-a573-3833-376039dbc570@redhat.com>
 <97e39625-6675-6d01-b1da-dd6d0758c943@redhat.com>
 <b78fcfa7-7c80-b1c2-aecb-e72b6df91dbc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <db5878e4-96a6-0937-852d-b7b98f40e77c@redhat.com>
Date: Mon, 23 Sep 2019 11:59:57 +0200
MIME-Version: 1.0
In-Reply-To: <b78fcfa7-7c80-b1c2-aecb-e72b6df91dbc@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ldgZ45SAN2yODzH2ORLoxHZtVps224aLj"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ldgZ45SAN2yODzH2ORLoxHZtVps224aLj
Content-Type: multipart/mixed; boundary="clfnqYnxDuNN2lgCgKy4li4dBro6hvCwQ";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Message-ID: <db5878e4-96a6-0937-852d-b7b98f40e77c@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix stsi unaligned test and add
 selector tests
References: <20190920075020.1698-1-frankja@linux.ibm.com>
 <9dd9362d-f8e2-a573-3833-376039dbc570@redhat.com>
 <97e39625-6675-6d01-b1da-dd6d0758c943@redhat.com>
 <b78fcfa7-7c80-b1c2-aecb-e72b6df91dbc@linux.ibm.com>
In-Reply-To: <b78fcfa7-7c80-b1c2-aecb-e72b6df91dbc@linux.ibm.com>

--clfnqYnxDuNN2lgCgKy4li4dBro6hvCwQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23/09/2019 11.48, Janosch Frank wrote:
> On 9/23/19 10:10 AM, Thomas Huth wrote:
>> On 20/09/2019 10.10, David Hildenbrand wrote:
>>> On 20.09.19 09:50, Janosch Frank wrote:
>>>> Alignment and selectors test order is not specified and so, if you
>>>> have an unaligned address and invalid selectors it's up to the
>>>> hypervisor to decide which error is presented.
>>>>
>>>> Let's add valid selectors to the unaligned test and add selector
>>>> tests.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  s390x/stsi.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>>>> index 7232cb0..c5bd0a2 100644
>>>> --- a/s390x/stsi.c
>>>> +++ b/s390x/stsi.c
>>>> @@ -35,7 +35,7 @@ static void test_specs(void)
>>>> =20
>>>>  	report_prefix_push("unaligned");
>>>>  	expect_pgm_int();
>>>> -	stsi(pagebuf + 42, 1, 0, 0);
>>>> +	stsi(pagebuf + 42, 1, 1, 1);
>>>>  	check_pgm_int_code(PGM_INT_CODE_SPECIFICATION);
>>>>  	report_prefix_pop();
>>>> =20
>>>> @@ -71,6 +71,8 @@ static inline unsigned long stsi_get_fc(void *addr=
)
>>>>  static void test_fc(void)
>>>>  {
>>>>  	report("invalid fc",  stsi(pagebuf, 7, 0, 0) =3D=3D 3);
>>
>> While you're at it, wouldn't it be better to use "(pagebuf, 7, 1, 1)" =
here?
>=20
> The selectors depend on the command, so they need to be checked after
> the command. I don't think it would make much sense to change the zeroe=
s
> here.

OK, fair. Patche queued.

 Thomas


--clfnqYnxDuNN2lgCgKy4li4dBro6hvCwQ--

--ldgZ45SAN2yODzH2ORLoxHZtVps224aLj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2Il6IACgkQLtnXdP5w
LbUSmBAAoWevoCJxjRUxD4eXfO0J5ZslKukVj3NSYhh0yBdRmwjRNQnF3AeGVDTv
hAnzpFB69kFfiR1IlMpf2szliyeOFqbfq10miEzlN5oom0pRt6Jk6T+aV1iHRTaV
olEiBTay37O+mTlmjPokc22DHHyMc9bRIwS7PAA2hCHcWDbZvBqYkuEMxdcL0QyC
7r5T7Q7eg1+qWt1+a7k1OrlzGqrqXM+p0ltZFFUbA5Z3KrA2uCwtDxhsSFIP8o56
YEhsoCD8FOC5jsUqhzYivo7hM4ol5pOl/yMFeeaCgVmK/VK9VfdUVRNj8imk2kfR
m8mPkzcN8hzNF/uBOagNFW9gc66rdZBr6eWVCkKFSyoZaUsN+AjfwYhkGqyuLFLw
Hx6mCHLryDr+oajOtmPO/Tm723zubBqSj9IXxYb+IJy4TPsqBPdnYA0URvVHLBxH
Eozkx89t0BsfLQ6/WOlbVVheUkwBXDwSRSKYQ7cyKhUpEBKYck04jVL7cRDDxtnd
UP2+nxvr1ILWcRhNYT9bs1TAt71cf2jiyp/jyp2kednCnKNNuwRGTOITd9NtLc+j
ne15RPO2cX2lCGVt+01IDSwqZks6mu3TOwOpoF7R58YRokPAqKZ0BI5VYaMvFf9j
fv01MoibPD7W+F3vIFkP2ATd2mAmtOLvbZvC1yPiHPqDi45+/Pc=
=/T/G
-----END PGP SIGNATURE-----

--ldgZ45SAN2yODzH2ORLoxHZtVps224aLj--
