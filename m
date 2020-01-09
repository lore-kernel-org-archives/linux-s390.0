Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731467AbgAIRFw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 12:05:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009H2aSp130071
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 12:05:50 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe5rxe6nr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 12:05:50 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 9 Jan 2020 17:05:48 -0000
Subject: Re: [kvm-unit-tests PATCH v6 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
 <20200109161625.154894-4-imbrenda@linux.ibm.com>
 <5c6f563e-3d09-5274-b050-a64122097e9b@redhat.com>
 <20200109175027.362d8440@p-imbrenda>
 <3dc2cf13-4829-53cd-a0a6-734fdddeb0ac@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 9 Jan 2020 18:05:42 +0100
MIME-Version: 1.0
In-Reply-To: <3dc2cf13-4829-53cd-a0a6-734fdddeb0ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zr67qUUwMF4HbjZpi0SDrVLCAGEKlUtFu"
Message-Id: <920208a7-562f-9a54-11cc-6ece021469ec@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zr67qUUwMF4HbjZpi0SDrVLCAGEKlUtFu
Content-Type: multipart/mixed; boundary="qEuZ6r7k8Bu8J0ttgt5ZJgwqJGKX7UwDd"

--qEuZ6r7k8Bu8J0ttgt5ZJgwqJGKX7UwDd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/9/20 5:58 PM, Thomas Huth wrote:
> On 09/01/2020 17.50, Claudio Imbrenda wrote:
>> On Thu, 9 Jan 2020 17:43:55 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> On 09/01/2020 17.16, Claudio Imbrenda wrote:
>>>> Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
>>>> use it instead of using inline assembly everywhere.
>>>>
>>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>>> ---
>>>>  lib/s390x/asm/arch_def.h | 10 ++++++++++
>>>>  s390x/intercept.c        | 33 +++++++++++++--------------------
>>>>  2 files changed, 23 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>>>> index 1a5e3c6..465fe0f 100644
>>>> --- a/lib/s390x/asm/arch_def.h
>>>> +++ b/lib/s390x/asm/arch_def.h
>>>> @@ -284,4 +284,14 @@ static inline int servc(uint32_t command,
>>>> unsigned long sccb) return cc;
>>>>  }
>>>> =20
>>>> +static inline void spx(uint32_t *new_prefix) =20
>>>
>>> Looking at this a second time ... why is new_prefix a pointer? A
>>> normal value should be sufficient here, shouldn't it?
>>
>> no. if you look at the code in the same patch, intercept.c at some
>> points needs to pass "wrong" pointers to spx and stpx in order to test=

>> them, so this needs to be a pointer
>>
>> the instructions themselves expect pointers (base register + offset)
>=20
> Ah, you're right, that "Q" constraint always confuses me... I guess you=

> could do it without pointers when using the "r" constraint, but it's
> likely better to do it the same way as stpx, so your patch should be fi=
ne.

Honestly, I'd rather have stpx return a u32 than passing a ptr.
That's how the kernel does it and is in-line with epswe/lpswe and
sctlg/lctlg which are already in the library.

Also, if possible names like set_prefix and store_prefix (or better
get_prefix) prefix would make it much more readable.

>=20
>>>> +{
>>>> +	asm volatile("spx %0" : : "Q" (*new_prefix) : "memory");
>>>> +}
>>>> +
>>>> +static inline void stpx(uint32_t *current_prefix)
>>>> +{
>>>> +	asm volatile("stpx %0" : "=3DQ" (*current_prefix));
>>>> +}
>>>> + =20
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20



--qEuZ6r7k8Bu8J0ttgt5ZJgwqJGKX7UwDd--

--zr67qUUwMF4HbjZpi0SDrVLCAGEKlUtFu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4XXWYACgkQ41TmuOI4
ufjBWhAA0BLaCmqO5xIMN106t3qhouiw4IyXNW9CicOtalmcGSDQtU6JJufArLko
3XT/wxE3OWEzPPSmQloRbiJP72NZhxOtaK8+rbl3gMFOTC5e2eKwvGLv7V3ryn2U
UI8PtCzXhsDIWNee7YoaLl857/7bbT9kiYsQIOUZdxBKAgsSFXK1H0zWRRCZ5xiL
km5a9pT6BEC587UBViwgO/VKClLttCZXvBEeNkWkg2sb2R9/2MK9G5f68cn197DJ
lc7Lc00RdmT2bpucfl0RxS0TUl45L8ymReBFgYXiV85pmS9SqvXtQFF/fEHZPrGJ
FAJoupLpSPsqk2ipq0YMYIfZsalQ/8FF4dyp/xcZ/cIlgtglKwq0QRLAbbvpsGQr
coF4klQWtn15n1tJ7QlxoTOSkjXTF8OSnsdHcFV6YlChDy0tax8jXxrHSGOIi6AS
d1VgsyezeEjk9Oel8c80dcXA6Rx5sQB6twABLv8lXcwAuhW+CG7hmRv8GsMMtjxU
95CPut4po955lpsb+v79nJRuMnvtFT48tk1DvS7l8XHpeykHEWLnGUCcAZr2G1R5
+aeR0/MVdW7+nsJkyuxG5O7Ue6bLWPHipe2TWFSrFDyRawbO7qZJuXi7ctqzwXLy
I6miNvZDhkDcKZLdMs+UYa26vBU/AJFYH40jPhQ0Y6ynnhQ3iGA=
=fB/S
-----END PGP SIGNATURE-----

--zr67qUUwMF4HbjZpi0SDrVLCAGEKlUtFu--
