Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727360AbgAUMq7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Jan 2020 07:46:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LCRL32049711
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 07:46:58 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xmgdkx4e8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 Jan 2020 07:46:58 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 21 Jan 2020 12:46:56 -0000
Subject: Re: [kvm-unit-tests PATCH v3 7/9] s390x: smp: Remove unneeded cpu
 loops
References: <20200117104640.1983-1-frankja@linux.ibm.com>
 <20200117104640.1983-8-frankja@linux.ibm.com>
 <20200120122956.6879d159.cohuck@redhat.com>
 <97f7f794-e0be-3984-99b2-ba229212fd3e@linux.ibm.com>
 <20200120171113.02a9b807.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 21 Jan 2020 13:46:51 +0100
MIME-Version: 1.0
In-Reply-To: <20200120171113.02a9b807.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W0FeYeQbJOc90i17tKgI0b0QtsLm6T50y"
Message-Id: <f0f17e60-29b6-12b1-6692-5da745cbe60a@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, thuth@redhat.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W0FeYeQbJOc90i17tKgI0b0QtsLm6T50y
Content-Type: multipart/mixed; boundary="2obZLeHEFGbIEYSJ5w5MORXo2z9xHzW9W"

--2obZLeHEFGbIEYSJ5w5MORXo2z9xHzW9W
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/20/20 5:11 PM, Cornelia Huck wrote:
> On Mon, 20 Jan 2020 15:41:52 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 1/20/20 12:29 PM, Cornelia Huck wrote:
>>> On Fri, 17 Jan 2020 05:46:38 -0500
>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>  =20
>>>> Now that we have a loop which is executed after we return from the
>>>> main function of a secondary cpu, we can remove the surplus loops.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> ---
>>>>  s390x/smp.c | 8 +-------
>>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>>
>>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>>> index 555ed72..c12a3db 100644
>>>> --- a/s390x/smp.c
>>>> +++ b/s390x/smp.c
>>>> @@ -29,15 +29,9 @@ static void wait_for_flag(void)
>>>>  	}
>>>>  }
>>>> =20
>>>> -static void cpu_loop(void)
>>>> -{
>>>> -	for (;;) {}
>>>> -}
>>>> -
>>>>  static void test_func(void)
>>>>  {
>>>>  	testflag =3D 1;
>>>> -	cpu_loop();
>>>>  }
>>>> =20
>>>>  static void test_start(void)
>>>> @@ -234,7 +228,7 @@ int main(void)
>>>> =20
>>>>  	/* Setting up the cpu to give it a stack and lowcore */
>>>>  	psw.mask =3D extract_psw_mask();
>>>> -	psw.addr =3D (unsigned long)cpu_loop;
>>>> +	psw.addr =3D (unsigned long)test_func; =20
>>>
>>> Before, you did not set testflag here... intended change? =20
>>
>> Yes
>> It is set to 0 before the first test, so it shouldn't matter.
>=20
> Hm... I got a bit lost in all those changes, so I checked your branch
> on github, and I don't see it being set to 0 before test_start() is
> called?

Well, that's because test_start doesn't care about the flag.
ecall and emcall are the first users, and they set it to 0 before using i=
t.

>=20
>>
>>>  =20
>>>>  	smp_cpu_setup(1, psw);
>>>>  	smp_cpu_stop(1);
>>>>   =20
>>>  =20
>>
>>
>=20



--2obZLeHEFGbIEYSJ5w5MORXo2z9xHzW9W--

--W0FeYeQbJOc90i17tKgI0b0QtsLm6T50y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4m8rsACgkQ41TmuOI4
ufjmEw/9EyUyYDgM0vPtUOVnW2hxoHPSwlfKZCRgqqdycxfNCtG9mlAhEXVywKGS
p5J6pygHIyjEHFVJT9wbQjjL6N26htl0h1FkMiSgYH9GmK76XbAUdw4u7fWe6w++
6ByxTeLkX6FRW+cRCMMIkFTlmA5UXcJB0sVwe0cDWaGuPLcGm0CUpjUtZ6xm1PyP
5MykTSDIiR3sjq5EZ3oVf7GPgnEtq81Kc1CajxQOn4oqZLTA/rZlKzWTWD33nFq4
KxaqT/JVxZngXfdJP/bF3LGc/VxOUJ6IoBf/OPjRfGi5G/KyPjkzP5xU/4cm1zR9
wqXF9SESqsy6CqvKwNePtGPU+fPAdQwHOZwtoesW5J1RbLFDTwduOnlfo7YYOdXG
FnF7rd2eyfu9+ujwJRnPxBYx8dQHKgjj2Tq3SZF7Gahe+8RRLWwDvtZrnGKDb9wv
kBNEwbSIR1aKJ97pq+P8hNhDv2p3Bnxel4a3ZBEpS96GESyoVJYtuHQhW0TsJ5wq
0UGhX0s2OyDJeagi0QwXsh+lOE153rD5F/wTpHFJN6442V+/HTNhrZhVaH7ythvv
R5mYyNYKSG88JTcaI7mXQRSM99NN6w5KmPKZD54zvg7uNkiyQFei0z8PeKCpqVFL
PhEngMfztW4zDH3byqjZGXKhnh8xgyL+3jN4qkKEUF7OnZdRQcc=
=S44S
-----END PGP SIGNATURE-----

--W0FeYeQbJOc90i17tKgI0b0QtsLm6T50y--
