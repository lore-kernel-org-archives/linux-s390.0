Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbgDXLbJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Apr 2020 07:31:09 -0400
Subject: Re: [PATCH v2 07/10] s390x: smp: Use full PSW to bringup new cpu
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-8-frankja@linux.ibm.com>
 <f13b31f6-80ef-9cfc-0cde-fe1c1601cf1f@redhat.com>
 <0f4ceb74-4ac4-4e26-3d2c-d8572b970cc8@linux.ibm.com>
 <03965ad8-c1e0-005a-b77a-9af740f0aa59@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <45d9fce9-124c-2099-283b-320a44610516@linux.ibm.com>
Date: Fri, 24 Apr 2020 13:31:02 +0200
MIME-Version: 1.0
In-Reply-To: <03965ad8-c1e0-005a-b77a-9af740f0aa59@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eTJISOPRBmzmZzu3V2zBKOepKZlMbW9LT"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eTJISOPRBmzmZzu3V2zBKOepKZlMbW9LT
Content-Type: multipart/mixed; boundary="90qIhZiSELB1AkS0tCK9ut6siq1xqZASx"

--90qIhZiSELB1AkS0tCK9ut6siq1xqZASx
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/24/20 1:23 PM, David Hildenbrand wrote:
> On 24.04.20 13:16, Janosch Frank wrote:
>> On 4/24/20 12:09 PM, David Hildenbrand wrote:
>>> On 23.04.20 11:10, Janosch Frank wrote:
>>>> Up to now we ignored the psw mask and only used the psw address when=

>>>> bringing up a new cpu. For DAT we need to also load the mask, so let=
's
>>>> do that.
>>>>
>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  lib/s390x/smp.c  | 2 ++
>>>>  s390x/cstart64.S | 3 ++-
>>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>> index 3f86243..6ef0335 100644
>>>> --- a/lib/s390x/smp.c
>>>> +++ b/lib/s390x/smp.c
>>>> @@ -202,6 +202,8 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)=

>>>>  	cpu->stack =3D (uint64_t *)alloc_pages(2);
>>>> =20
>>>>  	/* Start without DAT and any other mask bits. */
>>>> +	cpu->lowcore->sw_int_psw.mask =3D psw.mask;
>>>> +	cpu->lowcore->sw_int_psw.addr =3D psw.addr;
>>>>  	cpu->lowcore->sw_int_grs[14] =3D psw.addr;
>>>
>>> Do we still have to set sw_int_grs[14] ?
>>>
>> r14 is saved to restart_new so we don't go through setup twice.
>> We could instead copy cpu->lowcore->sw_int_psw.addr to restart new, bu=
t
>> that means more changes than the removal of one line.
>>
>> Also, what about backtraces or plain old debug?
>> Having r14 is a good backup to have IMHO.
>>
>=20
> Fine with me
>=20
> Reviewed-by: David Hildenbrand <david@redhat.com>
>=20

Thanks!
Also we need that if the cpu returns from its assigned function, so it
drops into the infinite loop.


--90qIhZiSELB1AkS0tCK9ut6siq1xqZASx--

--eTJISOPRBmzmZzu3V2zBKOepKZlMbW9LT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6izfYACgkQ41TmuOI4
ufisqBAAyHytv2+evWGqpO319+SuvLpVWX112WwJs++wF8DBnQQ2rRgVkkMLPMrT
1rSXcJu3e3SJkLLxwtZE31vLGDmXQu68ggTlNmBHUpdRQ+oEpOWOJ4HYe/moQp5z
rBO9tKqtkLRzDtRpL3H6/kCvBBvxhuCY8qt8EhG3LAVedpVV3LOp3ngzS7O5VNvE
R9BFUvoacW9hWHGNW6PIomoM0aIWXCbE1THfD+7iNhEMdJkobTzdbBV/I9EhAFBT
jeuav9IH14yOrX71qWw2HrGu3lOBLDRNPawAP24+CEr3icXuJpLkkFLnB3R1d1BH
PhbrZwJR3r76inJTH1Io7j31FUuuJsFBvAaevrdwCpPSFRsNj16FtSdnUxjIQTA3
rlsqZo3pFxTlTTuFE5QHYvykcq7NgUNZaxjhLXnMDEwG6gshnarLCyVPaD5nl0Mg
tARBm4bgAEyIr22lTIY1OlddHFSTGgvcvSoauWdGFvg/hztigFoojJSln1RYmXlh
X3xsb8BostsHypPXgacS5thHzgOI49J8camuGk/to/zPDjI6oyPlVYQWBAK55fjX
cUzi+0oLEyWiHjpk+2SkaaPkc6/zH3hj2N5E56gFK9vkahCXPTaQSXuByIKaODMU
cagx+PH+V8jdjmXd0aWCQG2M0LRtRBCxgI8boctiP014QPvzpV8=
=v04f
-----END PGP SIGNATURE-----

--eTJISOPRBmzmZzu3V2zBKOepKZlMbW9LT--
