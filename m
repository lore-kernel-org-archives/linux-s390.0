Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59886 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbgAQKlJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Jan 2020 05:41:09 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HAbnwh148982
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:41:08 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qg7rfh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 17 Jan 2020 05:41:07 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 17 Jan 2020 10:41:05 -0000
Subject: Re: [kvm-unit-tests PATCH v2 7/7] s390x: smp: Dirty fpc before
 initial reset test
References: <20200116120513.2244-1-frankja@linux.ibm.com>
 <20200116120513.2244-8-frankja@linux.ibm.com>
 <0ddfb1ce-16e4-017f-078b-80146bfa29a6@redhat.com>
 <3f034419-2342-0571-ea68-0474d45ba552@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 17 Jan 2020 11:41:00 +0100
MIME-Version: 1.0
In-Reply-To: <3f034419-2342-0571-ea68-0474d45ba552@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L0yNv4pyfJXFCX2MOHGsVBsAmzhoupazW"
Message-Id: <39a948f0-d30a-2e98-a836-b87721be5139@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, linux-s390@vger.kernel.org, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L0yNv4pyfJXFCX2MOHGsVBsAmzhoupazW
Content-Type: multipart/mixed; boundary="hg0V4YwW6dOBEbvGe5nupV3AIfEa58pkt"

--hg0V4YwW6dOBEbvGe5nupV3AIfEa58pkt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/17/20 11:29 AM, Thomas Huth wrote:
> On 17/01/2020 11.20, David Hildenbrand wrote:
>> On 16.01.20 13:05, Janosch Frank wrote:
>>> Let's dirty the fpc, before we test if the initial reset sets it to 0=
=2E
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  s390x/smp.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/s390x/smp.c b/s390x/smp.c
>>> index ce3215d..97a9dda 100644
>>> --- a/s390x/smp.c
>>> +++ b/s390x/smp.c
>>> @@ -179,6 +179,9 @@ static void test_emcall(void)
>>>  /* Used to dirty registers of cpu #1 before it is reset */
>>>  static void test_func_initial(void)
>>>  {
>>> +	asm volatile(
>>> +		"	sfpc	%0\n"
>>> +		: : "d" (0x11) : );
>>
>> FWIW, I'd make this one easier to read
>>
>> asm volatile("sfpc %0\n" :: "d" (0x11));
>=20
> By the way, since it's only one line, you can also drop the \n here.
>=20
>  Thomas
>=20

Both suggestions applied :)
Thanks!


--hg0V4YwW6dOBEbvGe5nupV3AIfEa58pkt--

--L0yNv4pyfJXFCX2MOHGsVBsAmzhoupazW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4hjzwACgkQ41TmuOI4
ufhSZg/+Nd/UkZA5v2rRgManexbPR9tnfQ/O6+VXxz5hz3LVW8ZzrGe1IaAGuvLM
iDBvjKRhfLSvXBjXy8A5p/y5KaUt5WSKT8pNwV9dCMxcz5+KqDKwwwyjmRuzKsze
eLqFKHllLPASprnVosKDsicadZ2cMSEaE0ZPWo0Dw7dOMP2TwWJ8pN9i/8hPpYMb
yOFsBJantUb0ZMcFD2ATCGvb4VxQ7DhzVIEbn6w4q8IcjwmNLIH43kOTDQ7Gpj7N
+XY6k7DK+v/eXXTRPYevP6fhnrJVFaCnIESq1ECG8lc+JAFRASkjbRrI+uJ05xB7
0sPsPt/+KnSXwcEXVusnr9Kj7xhTuL7AV0Kt3GwO3fitJzvKDuvH/wH2kc666dun
JyPr1wJHGor0o206ANErN9dTUN81SJMm56vr8VzVDBODY+mcrOCLy+CeXMbwOBkI
6E1gF7Q40s6hV7YDMdHsFi8jXNoaSPN09nMZW0/eMkTqAEHUu0/nX27SJOjoIOvd
JfAJ7FUJ/OCnAT/XKXv3A2tjnB8kfIE1sDHx5yKrlyF3PUJJyPdoGUDGoYVRhS8y
gYC4QisnduEIvG91NGoFTB8boTqNeqCONvwFjRwSzkvMUKR4KeowlwW/wPWZAQKE
Hv5gZBj1xO/lo3NXdh1yTNCFPzWdZDyu9VIn7eF45qaa9KR2LRo=
=6gu5
-----END PGP SIGNATURE-----

--L0yNv4pyfJXFCX2MOHGsVBsAmzhoupazW--
