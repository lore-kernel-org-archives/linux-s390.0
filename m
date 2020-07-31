Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731669AbgGaHet (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 03:34:49 -0400
Subject: Re: [kvm-unit-tests PATCH v2 3/3] s390x: Ultravisor guest API test
References: <20200727095415.494318-1-frankja@linux.ibm.com>
 <20200727095415.494318-4-frankja@linux.ibm.com>
 <20200730131617.7f7d5e5f.cohuck@redhat.com>
 <1a407971-0b43-879e-0aac-65c7f9e29606@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <d9333547-b93e-629b-e004-53f1b581914f@linux.ibm.com>
Date: Fri, 31 Jul 2020 09:34:41 +0200
MIME-Version: 1.0
In-Reply-To: <1a407971-0b43-879e-0aac-65c7f9e29606@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gzOEqjHdnFoYeLi4AgG4RU5cJTaj1yabA"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gzOEqjHdnFoYeLi4AgG4RU5cJTaj1yabA
Content-Type: multipart/mixed; boundary="MYUINQtcUh4NQZUeoDgasgx3U0Vw7km82"

--MYUINQtcUh4NQZUeoDgasgx3U0Vw7km82
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/30/20 5:58 PM, Thomas Huth wrote:
> On 30/07/2020 13.16, Cornelia Huck wrote:
>> On Mon, 27 Jul 2020 05:54:15 -0400
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> Test the error conditions of guest 2 Ultravisor calls, namely:
>>>      * Query Ultravisor information
>>>      * Set shared access
>>>      * Remove shared access
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> ---
>>>  lib/s390x/asm/uv.h  |  68 +++++++++++++++++++
>>>  s390x/Makefile      |   1 +
>>>  s390x/unittests.cfg |   3 +
>>>  s390x/uv-guest.c    | 159 ++++++++++++++++++++++++++++++++++++++++++=
++
>>>  4 files changed, 231 insertions(+)
>>>  create mode 100644 lib/s390x/asm/uv.h
>>>  create mode 100644 s390x/uv-guest.c
>>>
>>
>> (...)
>>
>>> +static inline int uv_call(unsigned long r1, unsigned long r2)
>>> +{
>>> +	int cc;
>>> +
>>> +	asm volatile(
>>> +		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>>> +		"		brc	3,0b\n"
>>> +		"		ipm	%[cc]\n"
>>> +		"		srl	%[cc],28\n"
>>> +		: [cc] "=3Dd" (cc)
>>> +		: [r1] "a" (r1), [r2] "a" (r2)
>>> +		: "memory", "cc");
>>> +	return cc;
>>> +}
>>
>> This returns the condition code, but no caller seems to check it
>> (instead, they look at header.rc, which is presumably only set if the
>> instruction executed successfully in some way?)
>>
>> Looking at the kernel, it retries for cc > 1 (presumably busy
>> conditions), and cc !=3D 0 seems to be considered a failure. Do we wan=
t
>> to look at the cc here as well?
>=20
> It's there - but here it's in the assembly code, the "brc 3,0b".

Yes, we needed to factor that out in KVM because we sometimes need to
schedule and then it looks nicer handling that in C code. The branch on
condition will jump back for cc 2 and 3. cc 0 and 1 are success and
error respectively and only then the rc and rrc in the UV header are set.=


>=20
> Patch looks ok to me (but I didn't do a full review):
>=20
> Acked-by: Thomas Huth <thuth@redhat.com>
>=20



--MYUINQtcUh4NQZUeoDgasgx3U0Vw7km82--

--gzOEqjHdnFoYeLi4AgG4RU5cJTaj1yabA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8jyZIACgkQ41TmuOI4
ufhmbw/8C367vtevYJ1CEEz5mNWY6MVMo+0TdXx1XAOkfn/pEAmAH6UJk6zt8Fve
8u9KKlYyTgKWhUDaDelWwdEs3TTI/4RtN/ABKuVUPyDX+zth8G4SqKYRHbmJ2Ta/
Xr4ISoBO1oOsGM0QOZjMoFjctTy+kKMe2OVjY0y4M6YK7SamfxB1zuLGbEoxGVDq
CunpfWPORun0QUZUkYIFxj6yIBTU45zvLOetuioqjDS7zt9vk/XsFJUujrLWj/Hi
tF+OPcSPT8mVSBdSSXHEYy9j+YdVUCD52QvgwkbXIQ3FKLCXJ3k2zGhUv0k+EPc7
+CtXP4OS6ek7Wvybj3xX/X5JCcJSbm3htIecNJDAvpwjHAcMgqQ+yrdmJMyPI8Q+
y+ewvrUfjtIbsAjP/xZrkRjIxbYrn/AU/+SKJCqaly6pz6wWGXqj4LrLSbUoxJ9L
5UD/v1ssRRe6pteQRcqwQoBpo+l3K4qzHETvP7hNlLQzL7HVywJTci923Xael3yz
C/NClKWaykbA4WOP4DKg3KrL4uFKpR16zWYRhKDkNhcyeSPHrI/xeo3DV2gw5RxF
VRWOER1+HMpLLfK/zsuDnqSHFDMWk2Iy25dUDS+30XsC98P6A5kDHQqq6GGAOHf4
QTFj5K+Wf8Cp1q1OR8gPqZVutmq5JyNZQKWgqRA/WQyoDJvSBQM=
=qSXU
-----END PGP SIGNATURE-----

--gzOEqjHdnFoYeLi4AgG4RU5cJTaj1yabA--
