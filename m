From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 03 Jan 2019 13:45:53 +0000
Subject: Re: [kvm-unit-tests PATCH v4 07/13] s390x: Use interrupts in SCLP
Message-Id: <3f76c8a8-9dbd-42ee-768f-27e49dfbbfea@linux.ibm.com>
In-Reply-To: <b26c6e02-f8f2-8cc2-6c32-dc9fd482fd8b@redhat.com>
References: <b26c6e02-f8f2-8cc2-6c32-dc9fd482fd8b@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--7jFipCo2KqfTtYv8MwWjuwLR8ib3xzFwn"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7jFipCo2KqfTtYv8MwWjuwLR8ib3xzFwn
Content-Type: multipart/mixed; boundary="ISkjhD7WY84SaOxRdeo6R5QwfsdvHejui";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <3f76c8a8-9dbd-42ee-768f-27e49dfbbfea@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v4 07/13] s390x: Use interrupts in SCLP
References: <20190103100806.9039-1-frankja@linux.ibm.com>
 <20190103100806.9039-8-frankja@linux.ibm.com>
 <1c33a6e1-2815-91dd-78d2-fd248156f27c@redhat.com>
 <f3f89e26-cd6c-8526-a657-071485f636d7@linux.ibm.com>
 <d95af1bd-7954-bda5-cafb-db6fa081d9f8@redhat.com>
 <12a84109-c80d-d6c2-b36a-128481561634@linux.ibm.com>
 <142b60d2-92ac-9163-014f-4ce131f6dd34@redhat.com>
 <b26c6e02-f8f2-8cc2-6c32-dc9fd482fd8b@redhat.com>
In-Reply-To: <b26c6e02-f8f2-8cc2-6c32-dc9fd482fd8b@redhat.com>

--ISkjhD7WY84SaOxRdeo6R5QwfsdvHejui
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.01.19 14:37, Thomas Huth wrote:
> On 2019-01-03 14:33, Thomas Huth wrote:
>> On 2019-01-03 14:23, Janosch Frank wrote:
>>> On 03.01.19 14:15, Thomas Huth wrote:
>>>> On 2019-01-03 14:13, Janosch Frank wrote:
>>>>> On 03.01.19 13:58, Thomas Huth wrote:
>>>>>> On 2019-01-03 11:08, Janosch Frank wrote:
>>>>>>> We need to properly implement interrupt handling for SCLP, becaus=
e on
>>>>>>> z/VM and LPAR SCLP calls are not synchronous!
>>>>>>>
>>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> [...]
>>>>>>> +
>>>>>>>  static void sclp_read_scp_info(ReadInfo *ri, int length)
>>>>>>>  {
>>>>>>>  	unsigned int commands[] =3D { SCLP_CMDW_READ_SCP_INFO_FORCED,
>>>>>>>  				    SCLP_CMDW_READ_SCP_INFO };
>>>>>>> -	int i;
>>>>>>> +	int i, cc;
>>>>>>> =20
>>>>>>>  	for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>>>>>>>  		memset(&ri->h, 0, sizeof(ri->h));
>>>>>>>  		ri->h.length =3D length;
>>>>>>> =20
>>>>>>> -		if (sclp_service_call(commands[i], ri))
>>>>>>> +		sclp_mark_busy();
>>>>>>> +		cc =3D sclp_service_call(commands[i], ri);
>>>>>>> +		sclp_wait_busy();
>>>>>>
>>>>>> You already do the sclp_wait_busy() in sclp_service_call now, so I=
 think
>>>>>> you don't need the sclp_wait_busy() here anymore?
>>>>>
>>>>> Yeah, that has to go.
>>>>>
>>>>>>
>>>>>> Also, what about moving the sclp_mark_busy() calls to the beginnin=
g of
>>>>>> sclp_service_call() instead?
>>>>>
>>>>> Wouldn't that create a race on the data of __sccb and we could end =
with
>>>>> garbled scb commands?
>>>>
>>>> Since there is a sclp_wait_busy in sclp_service_call already, you ca=
n be
>>>> sure that the previous command already finished, can't you?
>>>
>>> I mean before calling sclp_service_call.
>>> That's only a problem for smp, but before calling sclp, we prepare th=
e
>>> data in the shared __sccb page and that is currently protected by the=

>>> busy mark. If it's not, then two threads could write to __sccb at the=

>>> same time and the first that succeeds to call sclp will get a mix of
>>> data of both threads.
>>
>> But in that case, you also need to do a sclp_wait_busy() before callin=
g
>> sclp_mark_busy() in all locations - otherwise the code is also not
>> thread-safe in its current shape, is it?
>=20
> Ah, never mind, now I had a look at patch 11/13, and now it makes sense=
=2E
> So maybe fold patch 11 into this one, to make this clear right from the=

> start?
>=20
>  Thomas
>=20

Already done :)



--ISkjhD7WY84SaOxRdeo6R5QwfsdvHejui--

--7jFipCo2KqfTtYv8MwWjuwLR8ib3xzFwn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcLhIRAAoJEONU5rjiOLn4rLkQAKeAiP6OD9xZFPGwAFF99fm+
OJA8L1Pw91kt67y10AFVf/SOE7j/hZkwbvVEZjkkem/jBRyW2/72DS6gawcy74wc
yaSOxSazp91bL9a0gzrRdO54kkDHkZy0Vtww59BTkPOwkxollXsoVCO2R2YVTQGY
jc7j8JDT92+hhm7CiOGvgfaYzNFwRXzaBCFPMOiaWGqJ3rVKoCW3Yop4cqXvN2PM
sulst/pNbbtYQNJMOhLmjjFvepcE7oUK9YFjlMHzMfwlL2iun9QnhItmjINP3t4B
nhigy18cIeQUTna6h2YsTPrDjCVNjw81feyLLyZTLVFIu6S4xN3fUaP7boa3oRd/
OhcCHC55FfW4TKCab5pEVUUSk4WAC1wjaRsAqJVfOd49QvCChieDcyZ/O71lMd59
f6bSgzLEVdG/vuCf6ZC2Ie9Y4rA8mJw7aNpn1mgTv/FeqrB+P2xVOQ9rRU9Op5YF
ofAFOS+yVrslrfUBNqQgtIZSzmngco0/YpClDJEMEKU5taE0OSPUaKJGl+6E4997
D86SC7x4k3Uvbigqr1D4Cx2E7TfWSYXSLzj2oChpqSQgWAH93QsEKjLSO60g2xqx
EBWeFFD/QrkcF9fZkfg9h+fPQ3OsJ9Hcpq8tX86o+vkmUwaETPetINwLj5br7NAf
Ho2H566+PDB4wmVyZvh/
=j7vc
-----END PGP SIGNATURE-----

--7jFipCo2KqfTtYv8MwWjuwLR8ib3xzFwn--
