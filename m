Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5474 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728259AbgEZKlL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 06:41:11 -0400
Subject: Re: [kvm-unit-tests PATCH v7 08/12] s390x: css: stsch, enumeration
 test
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-9-git-send-email-pmorel@linux.ibm.com>
 <da731645-c408-2e79-4c78-a55b5f0d477b@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <e87b8573-f227-6e28-9e53-3188b0374754@linux.ibm.com>
Date: Tue, 26 May 2020 12:41:02 +0200
MIME-Version: 1.0
In-Reply-To: <da731645-c408-2e79-4c78-a55b5f0d477b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TtCelGI5WCStgWiYky1TzlW76fe5OEYsB"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TtCelGI5WCStgWiYky1TzlW76fe5OEYsB
Content-Type: multipart/mixed; boundary="WQYpljlZjM5NnYVSdR25ZqrkZiPOuGvTg"

--WQYpljlZjM5NnYVSdR25ZqrkZiPOuGvTg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/25/20 9:12 PM, Thomas Huth wrote:
> On 18/05/2020 18.07, Pierre Morel wrote:
>> First step for testing the channel subsystem is to enumerate the css a=
nd
>> retrieve the css devices.
>>
>> This tests the success of STSCH I/O instruction, we do not test the
>> reaction of the VM for an instruction with wrong parameters.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>  s390x/Makefile      |  1 +
>>  s390x/css.c         | 89 ++++++++++++++++++++++++++++++++++++++++++++=
+
>>  s390x/unittests.cfg |  4 ++
>>  3 files changed, 94 insertions(+)
>>  create mode 100644 s390x/css.c
> [...]
>> diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
>> index 07013b2..a436ec0 100644
>> --- a/s390x/unittests.cfg
>> +++ b/s390x/unittests.cfg
>> @@ -83,3 +83,7 @@ extra_params =3D -m 1G
>>  [sclp-3g]
>>  file =3D sclp.elf
>>  extra_params =3D -m 3G
>> +
>> +[css]
>> +file =3D css.elf
>> +extra_params =3D-device ccw-pong
>=20
> I gave your patch series a try on a normal upstream QEMU (that does not=

> have the ccw-pong device yet), and the css test of course fails there,
> since QEMU bails out with:
>=20
>  -device ccw-pong: 'ccw-pong' is not a valid device model name
>=20
> This is unfortunate - I think we likely have to deal with QEMUs for
> quite a while that do not have this device enabled. Could you maybe add=

> some kind of check to the kvm-unit-tests scripts that only run a test i=
f
> a given device is available, and skip the test otherwise?
>=20
>  Thomas
>=20

Could we for now remove it from unittests.cfg and let Pierre come up
with a solution without delaying this whole series? I expect changes to
run_tests.sh to attract a rather long discussion...


--WQYpljlZjM5NnYVSdR25ZqrkZiPOuGvTg--

--TtCelGI5WCStgWiYky1TzlW76fe5OEYsB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7M8j8ACgkQ41TmuOI4
ufgTYg//VZvMEphzs5HRSEDYnCOOoc4OGRuAoSIkjjuDxPVsVtJHOBT6X+PVYsBZ
9Vu78UBNYn1nv/j6KuAnYgpJjl4a2dc65GDuNPTk3DPFPPle7W23zNhhI2KALIM9
bvTpv9R6polrON5HyrAVmMIzSePSePruoUuqxINtvp/tufqtuzljMSDQduwnNg/U
0PMLg1pcHdN7QtzOeCURKmdCCgGYBlKos4j5vRgfxR4V73p7Qc0DGMr3DEfzad2Y
UWbKdwQ8eH0IJO52/ZIhbGJf27DjGJHaDk6kwDCNl9keEzC9KhM35Y9UXUiJyxj7
FXax0n2jfZ+FK1eX6isPcd3FSteuG4F0JN8E6e7HkBpeJff24CvH0lY54CLASPTd
xWQ3TSwKhzQAUmfbKAj6z5QZYSpWx+f4zIC44d7cWzMg1J9N6KATJICQcEn8UFeL
B5guGMcza5VhmyqSuebELV+AdIpQQiplAzr69hQugmNOXGJMwZR1r1ZOFgrkxb/b
pn+CfHtCJESLWzYGvfKYnjcvfimC0ZTi8ubZ8FpM4UPDk1IBoSWk0mo46lPl75HA
snFTRnV1BiQ9/SKeL5h71vqoYEy7aALcv/tf9725tGlesurJ3fm+Y40HaG/gtLFU
japZ7sUF2X7wA0/yb3XC79BbwtKI27ddZL7CahETMc7U+45RHnQ=
=Olt8
-----END PGP SIGNATURE-----

--TtCelGI5WCStgWiYky1TzlW76fe5OEYsB--
