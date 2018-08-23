From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
Date: Thu, 23 Aug 2018 14:11:00 +0200
Message-ID: <91ccca7d-2c17-15ce-9450-439bcf797b9d@linux.ibm.com>
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
 <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
 <b77da080-fed2-6ef1-ed35-f648b25da95a@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MW1CpoAT4Q1oK77EUmv5jn1LEIM13W3K7"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b77da080-fed2-6ef1-ed35-f648b25da95a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MW1CpoAT4Q1oK77EUmv5jn1LEIM13W3K7
Content-Type: multipart/mixed; boundary="zPvFN7ypImUmEk1vUgiJV6bY8Bdf0jcrZ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, pmorel@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, cohuck@redhat.com,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, akrowiak@linux.ibm.com,
 borntraeger@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Message-ID: <91ccca7d-2c17-15ce-9450-439bcf797b9d@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
 <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
 <6fb830bb-0241-dd3c-6356-6b9d4ce676ee@linux.ibm.com>
 <b77da080-fed2-6ef1-ed35-f648b25da95a@redhat.com>
In-Reply-To: <b77da080-fed2-6ef1-ed35-f648b25da95a@redhat.com>

--zPvFN7ypImUmEk1vUgiJV6bY8Bdf0jcrZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/23/18 2:03 PM, David Hildenbrand wrote:
> On 23.08.2018 13:53, Janosch Frank wrote:
>> On 8/23/18 1:47 PM, Pierre Morel wrote:
>>> On 23/08/2018 13:33, Janosch Frank wrote:
>>>> On 8/23/18 1:21 PM, David Hildenbrand wrote:
>>>>> On 23.08.2018 13:05, Janosch Frank wrote:
>>>>>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>>>>>> The comment preceding the shadow_crycb function is
>>>>>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>>>>>> guest.
>>>>>>
>>>>>> I beg to differ:
>>>>>>
>>>>>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>>>>> 		return 0;
>>>>>
>>>>> FORMAT2 includes bit FORMAT1 (backwards compatible)
>>>>
>>>> Right, this check is very misleading because of the constant, we
>>>> effectively test against Format 0 and Format 2.
>>>>
>>>> Can we make this clearer by explicitly ANDing 0x01 or adding a comme=
nt?
>>>
>>> yes, done, I modified the comment in front of the function.
>>
>> Which is not what I want, what I want is:
>>
>> /* CRYCB_FORMAT2 includes the bit for CRYCB_FORMAT1, so we allow both
>> formats here */
>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>> 	return 0;
>=20
> While it's not wrong, it is also not required. And it might soon be
> obsolete again (with APXA, as you said, there we always have to check).=

>=20
> But I'll leave that to you
>=20

I have not checked the vfio-ap patches, Pierre just told me that it goes
away in a few weeks anyway, so let's leave it out.


--zPvFN7ypImUmEk1vUgiJV6bY8Bdf0jcrZ--

--MW1CpoAT4Q1oK77EUmv5jn1LEIM13W3K7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbfqRUAAoJEBcO/8Q8ZEV5D9QP/j6BQnrF7UzdDmWWIjNY2LAo
wJV/x6pXOu7Cx/UjUOpAoBQGLysuLvnmH8ORyLl1uS85wj8xvovqXns2w0ze8rIt
NWzljAmpIchYNAWxb8jPtgRkKNq/As/yhAjF7BZoXMgW0KPvPEECS5pt0v2h3rKv
GISF9lP1iCZI0QbrelFCYqeKNSsXi+YYM7eZGfec2Qe94u10/skzJectIaE87aGb
Vt50Q2MmldABdCOjVPudKVm+OIoq4kT9Slu/MkHBunSJOKJGAbPTROpLsWvmNiHX
JxnwKOfjsQMIo7yJJz9b3vg8wOs5Rcw9xl3qIWPLjF4UddUMnnHcXO/tP0SS3OsV
vXIs+zZ/sjlxNgXIryNNTaNxvmFUrGAGFCFR66njWYc6d9G4COdTMhFlKOFPIh9O
R/0LHDox+I00AGrrMzsEYw++MF5VCbKiN6xYIHUehMTkxR9U/VAEpO57v8qV/Yyn
F2XpuIsy3rrMsZpmSis01Z5iuPI9jSUr6uoPj5sQ6w+a5Wh8VpESXtzdN3HkzA9p
fl8POs5TSOENleEKuiIrCpKWZFxTAuaNEbohP1h7WLkENwCbFhY0z/8gN2dXy1oX
uq8mWXP/Q7YjzLRJAecLd3gH0g703su4RMDv7gSx8z7dUNXOpS6bNKzL2zZpiO30
KaqIEnKREMtV9vG/qVEo
=I4i7
-----END PGP SIGNATURE-----

--MW1CpoAT4Q1oK77EUmv5jn1LEIM13W3K7--
