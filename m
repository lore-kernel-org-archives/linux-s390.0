From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Dec 2018 10:07:28 +0000
Subject: Re: [kvm-unit-tests PATCH v3 08/13] s390x: Add linemode console
Message-Id: <a4b5669a-0162-82a9-464c-801fc7e084fc@linux.ibm.com>
In-Reply-To: <79f381be-5bff-b57c-2941-9144045d13a9@redhat.com>
References: <79f381be-5bff-b57c-2941-9144045d13a9@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--d8sDhMmsKWEow1YbaIbkSqKWMOL7HOlZQ"
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d8sDhMmsKWEow1YbaIbkSqKWMOL7HOlZQ
Content-Type: multipart/mixed; boundary="lld28NiD4rB4NxAAJDiPX6chnOR6E2N5H";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com
Message-ID: <a4b5669a-0162-82a9-464c-801fc7e084fc@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3 08/13] s390x: Add linemode console
References: <20181218092657.46466-1-frankja@linux.ibm.com>
 <20181218092657.46466-9-frankja@linux.ibm.com>
 <e658521b-b46f-3e81-067e-4b886a67ad27@redhat.com>
 <b7973fa5-b628-d760-54f7-dfccc8d50f2b@linux.ibm.com>
 <79f381be-5bff-b57c-2941-9144045d13a9@redhat.com>
In-Reply-To: <79f381be-5bff-b57c-2941-9144045d13a9@redhat.com>

--lld28NiD4rB4NxAAJDiPX6chnOR6E2N5H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.12.18 13:28, Thomas Huth wrote:
> On 2018-12-18 13:01, Janosch Frank wrote:
>> On 18.12.18 12:50, Thomas Huth wrote:
> [...]
>>> Maybe rather assert(sccb->h.response_code =3D=3D SCLP_RC_NORMAL_COMPL=
ETION) ?
>>> It does not make much sense to continue otherwise, does it?
>>
>> Will the assert abort without any further prints?
>=20
> No ... so that does not work. So maybe do a disabled wait with irqs
> disabled instead to signal a crash to the host?
>=20
>  Thomas
>=20

Honestly, I'm thinking about dropping the check.
It often works without any init because the stage 3 bootloader does an
init and we do not check the print functions for errors.

It's best effort at this point :)
I'm more concerned with interrupts that print things while a printf
holds the sclp_busy lock. But that mostly happens if you mess up a sclp
call.


--lld28NiD4rB4NxAAJDiPX6chnOR6E2N5H--

--d8sDhMmsKWEow1YbaIbkSqKWMOL7HOlZQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJcGhhgAAoJEONU5rjiOLn4L1wQAJzUQtpi4nnFU/NcT+MLIO+i
rUYPe4SF3kntlV/4O88ak+6fq9A1fRA2qJbEeyGWVggQpmZcYmqfP6cGEKONy4Nx
GTcXT2aV208LheeoDQY1b8R5ia7Gp4ynO9qo6ZUiSnAY7PkkcZiPExk2drDz2C+d
l+tY2ZfuUGiOPSz8psM1JTjTyHmz/UqTO7dS0LlPF1IS0xpsmdAioAZvnhuacra9
ZKpAhuLmFSGP4VrMJ1/o0JamjpbmI6lasKOIzhhrGskTbJZeXh/Y5I9GpXNcfCB6
qgZTFC0C9P78HDPOWhlFhXQbA3P3OxsFvATGTrOoxJC1BCqMwUgtahIsqCF3+Ssy
yrMbo9d0sI+evX9ToLSgo3Q23Xbc22wGsKYX4zFVQRAOgJNYPWtIsdzSPjTanwZN
Nu54jmoxjPOVwcGvCQKFL+9zzly0z2tSIq/GbXnZY4ik6X4KxADZuKbaVhgMAKwy
sC0NI11GWznjir8JOY2HocWUwn0vTsSaOiSP+oaR6+mPNVcYINtslF9DEwr702+u
UA+JT7Zu53w6xtEP8LHVIbv9CXa+V0fhusAI3fo5G/SBSD7ZkSw/vbO4+29nWM/x
srQYjyHRdDikHGCRRVZfEOYgmVxR7VEJSbYL4phPZJNDaFpLVN/3/nQn88iklcXS
AKZ3kliogZr5Z7Qy+CVa
=trkz
-----END PGP SIGNATURE-----

--d8sDhMmsKWEow1YbaIbkSqKWMOL7HOlZQ--
