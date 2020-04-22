Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbgDVHna (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 03:43:30 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M7VoDF112236
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:43:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmv0h69k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:43:29 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Apr 2020 08:42:42 +0100
Subject: Re: [kvm-unit-tests PATCH v5 00/10] s390x: Testing the Channel
 Subsystem I/O
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <028ece05-1429-7761-cf4e-6fabc34e6aa0@linux.ibm.com>
 <4a5f0636-cd73-164a-8c7a-ca5679f01e56@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Apr 2020 09:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <4a5f0636-cd73-164a-8c7a-ca5679f01e56@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OYF0GydMbDu8HxOuTkPPSmnAuccIO8APC"
Message-Id: <2c30fd52-876d-91b0-9a69-363efabdb86e@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OYF0GydMbDu8HxOuTkPPSmnAuccIO8APC
Content-Type: multipart/mixed; boundary="M3I2jByNAOz0jeA9h61PC1o4DevKsR8cF"

--M3I2jByNAOz0jeA9h61PC1o4DevKsR8cF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/21/20 6:18 PM, David Hildenbrand wrote:
> On 21.04.20 18:13, Pierre Morel wrote:
>>
>>
>> On 2020-02-20 13:00, Pierre Morel wrote:
>>
>> ...snip...
>>
>>>
>>>
>>> Pierre Morel (10):
>>>    s390x: saving regs for interrupts
>>>    s390x: Use PSW bits definitions in cstart
>>>    s390x: cr0: adding AFP-register control bit
>>>    s390x: export the clock get_clock_ms() utility
>>
>> Please can you consider applying these 4 patches only.
>> I will send some changes I made for the patches on css tests.
>>
>=20
> The first one requires a little more brain power - can anybody at IBM
> help reviewing that?
>=20

I'll try to understand it :)

But I think we need a new series anyway.
@Pierre: You told me, that you removed delay() and this series still has
it. With the changes needed to the second patch and the delay change we
need all information to make decisions, so a new version of the series
would make sense.



--M3I2jByNAOz0jeA9h61PC1o4DevKsR8cF--

--OYF0GydMbDu8HxOuTkPPSmnAuccIO8APC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6f9ZoACgkQ41TmuOI4
ufi3EhAAp8SxlhgUDsqAMFa9aK3fOyIyY6jE53bUGQnYKbTk7IW1EB0B8+TLAvRf
QxvgsPqYGpQJVqNW8DsnYvTiseTROUi0R9BUi/otGLuE8nSB1S0jGfLtwjQQGIP/
NqhOuZuGnEZUDEP8CrTEORKQdPEkFwJ69v8TAw+5HGEl2+K1c15SxlRfAVv1HCp2
AkD2Yw6YyJD4M8ywhtsuda2DJPzZRNdDkcIggUQjBXTR7Db7VvE9wLhpxQd4WYWm
wLI7iVV80Qf0KVU7WZzlGfDpKLEwXfzQTVzupvCUAnw/cyDFGf0Yd4UO8dYIL8w0
z3sd3ElcgHsoBEvTrwbpuqRNnIGDL8a7u9bendmiInDbSgvlfqAFLIB4JXKiToMj
tsCvpGtKv1PuyUuC7J1mb8K7GrFoIvl+twNhW9fnu58iwIFo1OSMj5T0eBg0yhb2
BU4rL1SPleJ9dhrTmYxN0o2wqZtR21LoliRAfVLx782jjBp4iwndSIe2EGwEV76P
q528UweaNJsSRmGEWdF90LC918AkgrqCLWJ7FAFLldYR19dx7l/A4n2vInwFDHeC
FAlpWLYjcQCMJYEEygLKxe0+x8dEKqqSz2jXNoqCeDgMlO16uVb1wxouZyJ8ZGRZ
6I0haqwkNexKFQp30zOUBrCM2FcMQi6a3himPl+PQGWuNBgJENA=
=qs4e
-----END PGP SIGNATURE-----

--OYF0GydMbDu8HxOuTkPPSmnAuccIO8APC--
