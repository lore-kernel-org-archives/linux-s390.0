Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbgGWMUH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Jul 2020 08:20:07 -0400
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: skrf: Add exception new skey
 test and add test to unittests.cfg
References: <20200717145813.62573-1-frankja@linux.ibm.com>
 <20200717145813.62573-3-frankja@linux.ibm.com>
 <78da93f7-118d-2c1d-582a-092232f36108@redhat.com>
 <032c1103-3020-9deb-a307-70ded3bdb55e@linux.ibm.com>
 <1aa0a21c-90c9-0214-1869-87cc60a46548@redhat.com>
 <acc2a56c-6157-32e1-f305-48bf5a2a285d@linux.ibm.com>
 <20200723141043.7efadd30.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <3be78ac2-6d75-2d4b-850d-e1744fbce9ef@linux.ibm.com>
Date: Thu, 23 Jul 2020 14:19:58 +0200
MIME-Version: 1.0
In-Reply-To: <20200723141043.7efadd30.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SRqyTEwNZ0CQDdb3VjJyo7I5PZzlbGYKq"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SRqyTEwNZ0CQDdb3VjJyo7I5PZzlbGYKq
Content-Type: multipart/mixed; boundary="YVDuruXzugb6H4LdH7oEFFGyMXkIG3sJc"

--YVDuruXzugb6H4LdH7oEFFGyMXkIG3sJc
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/23/20 2:10 PM, Cornelia Huck wrote:
> On Tue, 21 Jul 2020 17:03:10 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 7/21/20 4:28 PM, Thomas Huth wrote:
>>> On 21/07/2020 10.52, Janosch Frank wrote: =20
>>>> On 7/21/20 9:28 AM, Thomas Huth wrote: =20
>>>>> On 17/07/2020 16.58, Janosch Frank wrote: =20
>>>>>> If a exception new psw mask contains a key a specification excepti=
on
>>>>>> instead of a special operation exception is presented. =20
>>>>>
>>>>> I have troubles parsing that sentence... could you write that diffe=
rently?
>>>>> (and: "s/a exception/an exception/") =20
>>>>
>>>> How about:
>>>>
>>>> When an exception psw new with a storage key in its mask is loaded f=
rom
>>>> lowcore a specification exception is raised instead of the special
>>>> operation exception that is normally presented when skrf is active. =
=20
>>>
>>> Still a huge beast of a sentence. Could you maybe make two sentences =
out
>>> of it? For example:
>>>
>>> " ... is raised. This differs from the normal case where ..." =20
>>
>> When an exception psw new with a storage key in its mask is loaded fro=
m
>> lowcore a specification exception is raised. This behavior differs fro=
m
>> the one that is presented when trying to execute skey related
>> instructions which will raise special operation exceptions.
>=20
> s/psw new/new psw/ ?

Yeah that would align the naming with the pop one.

>=20
> (And probably a comma after 'lowcore'.)
>=20
> "This differs from the behaviour when trying to execute skey related
> instructions, which will result in special operation exceptions."
>=20
> ?

Sure



--YVDuruXzugb6H4LdH7oEFFGyMXkIG3sJc--

--SRqyTEwNZ0CQDdb3VjJyo7I5PZzlbGYKq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8ZgG8ACgkQ41TmuOI4
ufiEwBAAk028kn/8hdqCRF7fCbsaNujQ4M11Sx40Wa7xaOXXAoos2rC4lyQu0WmE
+J8tzHs8IvCPOezaocRAt8nrGMsUsg5RUHjY1YSlWjgF8JhNjvN7jziUXcf6l320
du0KbK/URXJVdUE5eut4QmCPQc2r+S1/kmUoUlAVLsUlyrxQvIJ40GZ1iQMzzW0y
FX0iQKb+0oxUpjlnS+FN5vsJV24aB0/fMe3WvkAKkLk7GJbAINpjEBuEb9r/18au
/q6Lx4KkcTuhIbeMik1mcfU6f6lwcn5F+KLIiwfGt0L5K9DnRxqFho+0nniG2hLv
+vurNnEwD6SvSDqWBysI5QFDcfzlehqhRptGW8C8wdtgn07nio2eWA7rBg9cXjKg
3E/Tz3crAysin7acndVvWdiY26Ht2LhGOzQXuUoyktnWuEzi3xd0cUYKxFLJwtUm
bOlr0eGVe5Vbw17MTPLiOcvCAznH+1ObyL6EcWHnsF1kaNWT7UKpi/eDvmW+VO4g
Q2p+U/KvOAAKAMKKN1tAGj0QncXMV4cuBc97G5OD5HeX4bxmeUZ6tHUU02iITjoz
xCMgDEooZAIn2UthO1OPLxnBYmmcU8TkxeFRF8Bq/cszbu8jSKXGIEXnjDFPSBOX
9brTpKYqFu2r3ZfMW/TZB7i3KSA5RTp5M3vGLk7lmJbLxi4nf+w=
=04UE
-----END PGP SIGNATURE-----

--SRqyTEwNZ0CQDdb3VjJyo7I5PZzlbGYKq--
