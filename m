Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390030AbgFYHQe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 03:16:34 -0400
Subject: Re: [PATCH 1/2] docs: kvm: add documentation for KVM_CAP_S390_DIAG318
References: <20200624202200.28209-1-walling@linux.ibm.com>
 <20200624202200.28209-2-walling@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <151bb070-f083-5011-2f04-291058bc9cc2@linux.ibm.com>
Date: Thu, 25 Jun 2020 09:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200624202200.28209-2-walling@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vJnE9patHWFoMs28sZEFRJ1LVv7O4Itzz"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vJnE9patHWFoMs28sZEFRJ1LVv7O4Itzz
Content-Type: multipart/mixed; boundary="kXDCd5XXqK4Hxw1TE07VIQfzWtJuGYsEb"

--kXDCd5XXqK4Hxw1TE07VIQfzWtJuGYsEb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/24/20 10:21 PM, Collin Walling wrote:
> Documentation for the s390 DIAGNOSE 0x318 instruction handling.
>=20
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  Documentation/virt/kvm/api.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/ap=
i.rst
> index 426f94582b7a..056608e8f243 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -6150,3 +6150,22 @@ KVM can therefore start protected VMs.
>  This capability governs the KVM_S390_PV_COMMAND ioctl and the
>  KVM_MP_STATE_LOAD MP_STATE. KVM_SET_MP_STATE can fail for protected
>  guests when the state change is invalid.
> +
> +8.24 KVM_CAP_S390_DIAG318
> +-------------------------
> +
> +:Architecture: s390
> +
> +This capability allows for information regarding the control program t=
hat may
> +be observed via system/firmware service events. The availability of th=
is

I'm not sure if control program is understood universally, it's a rather
old term to say guest kernel.

How about:

This capability allows a guest to set information about its control
program (i.e. guest kernel type and version). The information is helpful
on system/firmware service events, providing additional data about what
environments are running on the machine.


> +capability indicates that KVM handling of the register synchronization=
, reset,
> +and VSIE shadowing of the DIAGNOSE 0x318 related information is presen=
t.
> +
> +The information associated with the instruction is an 8-byte value con=
sisting
> +of a one-byte Control Program Name Code (CPNC), and a 7-byte Control P=
rogram
> +Version Code (CPVC). The CPNC determines what environment the control =
program
> +is running in (e.g. Linux, z/VM...), and the CPVC is used for extraneo=
us
> +information specific to OS (e.g. Linux version, Linux distribution...)=

> +
> +If this capability is available, then the CPNC and CPVC can be synchro=
nized
> +between KVM and userspace via the sync regs mechanism (KVM_SYNC_DIAG31=
8).
>=20



--kXDCd5XXqK4Hxw1TE07VIQfzWtJuGYsEb--

--vJnE9patHWFoMs28sZEFRJ1LVv7O4Itzz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl70T0oACgkQ41TmuOI4
ufhIhRAAwACTo5f/gomKkXDle3RSy0JM4QV7pqW0FGE0UFaxzOki7eFekLrPxwrG
V1tudVHgQWQtHxiV7zo/Qqki+fSRcrlU8aTCdaCMPs2xgbvLw2uNucyliR9YbMnf
NrEBnPNW2sbD4GD3IZEElAz/4SYm793EqO4VPwhICYzZT7460mkl9+QfITYMtIgd
c0FrjeC+PDL4w9qCyFPqpTeYwWtQHMJaOwRNMB90xw7Hh0d8Xx4bQBC0hta6R86Y
slqaEO9mfCQo3AdahIHMLLmkO2p6jS6J2b/nwHWkIoudhbOtI9EbGODE2CrWB8eU
RRVUZUGWOYpUkf/6xE+YzKYGrH/yBspdFvJqGGxzRf/CbBjlX+m9cwQ6PdRKBBaL
lzSUzCboLam/5ARsVoNpcwOPeKtS+Kdaw4DLCJxQqTiNcc678ahUCtGlX/luCLbb
YasltjE43ND0fpVNM66Rnk+3x/SqxHbOJs1xsJw4cPP57ETk42Hs6owDQp+yAEkN
GN2AwkTtwhfm2KWOwActGnGR6M4Z5x63v8IU+GnXeJQHT8Rq4zDyqR26ZMV/TY60
VjV6G7wmyzMEeTleJwF67u+/rNNHKiy1Vs0EB9g4KFwFhGtM54fhSBAYkuuu5BlN
BihpKbsGiQZ6AAYG6GWc8cTliiwSwOnNIR2g2oHD09cPIa5wyNQ=
=ucC4
-----END PGP SIGNATURE-----

--vJnE9patHWFoMs28sZEFRJ1LVv7O4Itzz--
