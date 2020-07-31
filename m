Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733237AbgGaMbb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 08:31:31 -0400
Subject: Re: [kvm-unit-tests GIT PULL 00/11] s390x patches
References: <20200731094607.15204-1-frankja@linux.ibm.com>
 <dfce14f4-5e7b-9060-6520-06e7dd69cfa4@redhat.com>
 <524d5b00-94ec-da47-601a-a5909e3ed63e@linux.ibm.com>
 <00cc99d2-6020-3111-38a4-232991ffcf0d@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <31ec90d3-1544-eb38-536e-33f39e060a41@linux.ibm.com>
Date: Fri, 31 Jul 2020 14:31:22 +0200
MIME-Version: 1.0
In-Reply-To: <00cc99d2-6020-3111-38a4-232991ffcf0d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fhN9CTEG2DAnrIodH8gVbQnWBBpXCm6pL"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fhN9CTEG2DAnrIodH8gVbQnWBBpXCm6pL
Content-Type: multipart/mixed; boundary="sA81tUxVgk4uonqrQ41gPFOXfXtOpD0pT"

--sA81tUxVgk4uonqrQ41gPFOXfXtOpD0pT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/31/20 2:09 PM, Thomas Huth wrote:
> On 31/07/2020 13.31, Janosch Frank wrote:
>> On 7/31/20 12:31 PM, Paolo Bonzini wrote:
>>> On 31/07/20 11:45, Janosch Frank wrote:
>>>>   https://github.com/frankjaa/kvm-unit-tests.git tags/s390x-2020-31-=
07
>>>
>>> Pulled, thanks.  FWIW you may want to gitlab in order to get the CI.
>>>
>>> Paolo
>>>
>>
>> Hey Paolo, that repository is hooked up to travis already:
>> https://travis-ci.com/github/frankjaa/kvm-unit-tests/builds/177931162
>>
>> I'll consider it if it has any benefit.
>> @Thomas: Are there differences in the CI?
>=20
> Not that much, you get a good build test coverage with both. Travis use=
s
> real (nested) KVM tests, but the compiler and QEMU versions are a littl=
e
> bit backlevel (still using Ubuntu bionic). Gitlab-CI uses newer version=
s
> (thanks to Fedora 32), but there is no KVM support here, so the tests
> run with TCG only (I'm thinking of adding the cirrus-run script to the
> Gitlab-CI, maybe we could get some KVM-coverage that way there, too, bu=
t
> that will certainly take some time to figure it out).
>=20
>  Thomas
>=20

Thanks for the answer!

For now I'll stay with github/travis until I have a real reason to move
over. Maybe if the qemu CI run doesn't take ~2h on gitlab I'll start
considering moving.


--sA81tUxVgk4uonqrQ41gPFOXfXtOpD0pT--

--fhN9CTEG2DAnrIodH8gVbQnWBBpXCm6pL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl8kDxoACgkQ41TmuOI4
ufiXGQ/+KvPwwK+au4V2vlSexDOAnkm8wU/NiV8K/icGkl4ZPWmD+DcWVn0JU9v8
jMuJs9OLGpqQ1KlZCwVi2mYiiUm0G5RCPHQfabfWUhItIIzAq2ht3qmd1KLrSSvt
Onp+XHBrhXw0NSEZmEGyebQjCDnQ5Zkj3oiR8xvPhVUZ2tyjHoy0gh34csIfkW5j
khBZl0ANNlPDnSC0lURK+oKXXR6jAmlTFbnK9+qQr7/U3g7YLfVzNV5InNLgx6zz
0Y+kdmi9EgABcIAsqBecR+w+jfWOqRTIH+5r1hy/74oPm+GRdeOBKDzprJp1qOgw
EbFE8rk74+Ji4RXgmfTz0gT7D9E294DRG+qzO3Ha7r5x6jYsyel4Ivz26oC+KUMe
sjvr3swe8HzGKiS1W1+bpRZetKa8ulfJRxnDGb1RvqUZdKjAEFcqn/m7uA7C79+5
GQcNP8UG3OKXRzUo6fafaZIgsoJxvm15adctqj3yheycYAw+4F2DrZ+rURlxvSCI
b8vcTY54O06IZig/9APFHYJP/XGW/ubkesHIWpzDdaGxqFYmXHtO07u0tl5M9ESg
IRUoz2+ev42lIljNg56DM2rPzlLc5MyZFJ8ShuvqWNwWa1TkDh1UVA5mcvwirmRR
WfibpvrDzA2Y/UZu5ABpokHPvB9EXuoGHgOP4mNWAyxCOC0qcT0=
=oVbK
-----END PGP SIGNATURE-----

--fhN9CTEG2DAnrIodH8gVbQnWBBpXCm6pL--
