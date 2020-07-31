Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1910 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731818AbgGaJGe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 05:06:34 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Ultravisor guest API test
References: <20200727095415.494318-1-frankja@linux.ibm.com>
 <20200727095415.494318-4-frankja@linux.ibm.com>
 <20200730131617.7f7d5e5f.cohuck@redhat.com>
 <1a407971-0b43-879e-0aac-65c7f9e29606@redhat.com>
 <d9333547-b93e-629b-e004-53f1b581914f@linux.ibm.com>
 <20200731104205.37add810.cohuck@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <16eee269-d773-26df-a517-08f2265318c4@linux.ibm.com>
Date: Fri, 31 Jul 2020 11:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200731104205.37add810.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="A70HuUQvq2qG9s6fjygJ0okS4JtmJJliV"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A70HuUQvq2qG9s6fjygJ0okS4JtmJJliV
Content-Type: multipart/mixed; boundary="X026MUpz8UTN0wCuU8m9I4QwoaXZ1wqxa"

--X026MUpz8UTN0wCuU8m9I4QwoaXZ1wqxa
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/20 10:42 AM, Cornelia Huck wrote:
> On Fri, 31 Jul 2020 09:34:41 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
>=20
>> On 7/30/20 5:58 PM, Thomas Huth wrote:
>>> On 30/07/2020 13.16, Cornelia Huck wrote: =20
>>>> On Mon, 27 Jul 2020 05:54:15 -0400
>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>>> =20
>>>>> Test the error conditions of guest 2 Ultravisor calls, namely:
>>>>>      * Query Ultravisor information
>>>>>      * Set shared access
>>>>>      * Remove shared access
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>>> ---
>>>>>  lib/s390x/asm/uv.h  |  68 +++++++++++++++++++
>>>>>  s390x/Makefile      |   1 +
>>>>>  s390x/unittests.cfg |   3 +
>>>>>  s390x/uv-guest.c    | 159 ++++++++++++++++++++++++++++++++++++++++=
++++
>>>>>  4 files changed, 231 insertions(+)
>>>>>  create mode 100644 lib/s390x/asm/uv.h
>>>>>  create mode 100644 s390x/uv-guest.c
>>>>> =20
>>>>
>>>> (...)
>>>> =20
>>>>> +static inline int uv_call(unsigned long r1, unsigned long r2)
>>>>> +{
>>>>> +	int cc;
>>>>> +
>>>>> +	asm volatile(
>>>>> +		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>>>>> +		"		brc	3,0b\n"
>>>>> +		"		ipm	%[cc]\n"
>>>>> +		"		srl	%[cc],28\n"
>>>>> +		: [cc] "=3Dd" (cc)
>>>>> +		: [r1] "a" (r1), [r2] "a" (r2)
>>>>> +		: "memory", "cc");
>>>>> +	return cc;
>>>>> +} =20
>>>>
>>>> This returns the condition code, but no caller seems to check it
>>>> (instead, they look at header.rc, which is presumably only set if th=
e
>>>> instruction executed successfully in some way?)
>>>>
>>>> Looking at the kernel, it retries for cc > 1 (presumably busy
>>>> conditions), and cc !=3D 0 seems to be considered a failure. Do we w=
ant
>>>> to look at the cc here as well? =20
>>>
>>> It's there - but here it's in the assembly code, the "brc 3,0b". =20
>=20
> Ah yes, I missed that.
>=20
>>
>> Yes, we needed to factor that out in KVM because we sometimes need to
>> schedule and then it looks nicer handling that in C code. The branch o=
n
>> condition will jump back for cc 2 and 3. cc 0 and 1 are success and
>> error respectively and only then the rc and rrc in the UV header are s=
et.
>=20
> Yeah, it's a bit surprising that rc/rrc are also set with cc 1.

Is it?
The (r)rc *only* contain meaningful information on CC 1.
On CC 0 they will simply say everything is fine which CC 0 states
already anyway.

>=20
> (Can you add a comment? Just so that it is clear that callers never
> need to check the cc, as rc/rrc already contain more information than
> that.)

I'd rather fix my test code and also check the CC.
I did check it for my other UV tests so I've no idea why I didn't do it
here...


How about adding a comment for the cc 2/3 case?
"The brc instruction will take care of the cc 2/3 case where we need to
continue the execution because we were interrupted.
The inline assembly will only return on success/error i.e. cc 0/1."

>=20
>>
>>>
>>> Patch looks ok to me (but I didn't do a full review):
>>>
>>> Acked-by: Thomas Huth <thuth@redhat.com>
>>>  =20
>>
>>
>=20



--X026MUpz8UTN0wCuU8m9I4QwoaXZ1wqxa--

--A70HuUQvq2qG9s6fjygJ0okS4JtmJJliV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8j3xEACgkQ41TmuOI4
ufjjTA/8DbmGDl+NKT3CiHOO2bK2AX5wwmWxmD3SD5RAHlLQa8pf7zBA1NJKtk1Z
WhyOYlVGF24akHC0A9+4SpVwpXcbax/jn/jTywebg8tFm8LrR13pXo4eFW2aagqu
RjG95kxm3BrVUjhSzThGPXORd4Kxu2P4cb+d/E0LFOw6AaAzAMEw7GjCuUK9sArQ
KNIikE6SzBaNSnhUDKnVt6Ui8pioTTDSMAuW+uNDmo+O/d3hwGYVpQz3oeHUdbDE
0Ml2ycmlMhSVYf/OJf2hlfvsvo4TUZJ/IOBOhJDv01QjA86W4xHcFEmgcAQFcfy7
LGSqu/PG81PpuQLScBpEBfN3i3Ak6RGwI5HpcvfVk2GD+XKPFKWEXCVcaoxH6e/m
to8rPbFfxKu8FALHL1lkYH1PBstBHnmpjxmT5towr1Lq7lEIfvtFHK1ZnR2wtGOa
i+tLPhJ8PHmo/g7vYxdF24KA1w++8PSuZPBkN90yDjLnU34wZlTxfCGWmXe9/s1S
KD90nETKhcWGEAaqWTYijWxUUXnuxoSeD/CtKo9kSGluTOoy9QOxmqn85YDjKRQR
1q7CAd+EqA0WqN3wUfKcIdR1jp0RUb3lLLSDuAcGsm/+Yx6tUbncmaZDJ33kFQZE
P3zHWDfpOFISBw4NIlq5nk7jVbB2H1jTs5VxevFmsUDgtLxYe8E=
=nxo7
-----END PGP SIGNATURE-----

--A70HuUQvq2qG9s6fjygJ0okS4JtmJJliV--
