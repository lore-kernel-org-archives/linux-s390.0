Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50043 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729928AbgGUTij (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jul 2020 15:38:39 -0400
Date: Tue, 21 Jul 2020 16:38:30 -0300
From: Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH v6] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
Message-ID: <20200721193830.GE2716@glitch>
References: <20200713164830.101165-1-bmeneg@redhat.com>
 <d337cbba-e996-e898-1e75-9f142d480e5e@linux.vnet.ibm.com>
 <1595257015.5055.8.camel@linux.ibm.com>
 <20200720153841.GG10323@glitch>
 <1595352376.5311.8.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1595352376.5311.8.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k3qmt+ucFURmlhDS"
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Nayna <nayna@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org, erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org

--k3qmt+ucFURmlhDS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 01:26:16PM -0400, Mimi Zohar wrote:
> On Mon, 2020-07-20 at 12:38 -0300, Bruno Meneguele wrote:
> > On Mon, Jul 20, 2020 at 10:56:55AM -0400, Mimi Zohar wrote:
> > > On Mon, 2020-07-20 at 10:40 -0400, Nayna wrote:
> > > > On 7/13/20 12:48 PM, Bruno Meneguele wrote:
> > > > > The IMA_APPRAISE_BOOTPARAM config allows enabling different "ima_=
appraise=3D"
> > > > > modes - log, fix, enforce - at run time, but not when IMA archite=
cture
> > > > > specific policies are enabled. =A0This prevents properly labeling=
 the
> > > > > filesystem on systems where secure boot is supported, but not ena=
bled on the
> > > > > platform. =A0Only when secure boot is actually enabled should the=
se IMA
> > > > > appraise modes be disabled.
> > > > >
> > > > > This patch removes the compile time dependency and makes it a run=
time
> > > > > decision, based on the secure boot state of that platform.
> > > > >
> > > > > Test results as follows:
> > > > >
> > > > > -> x86-64 with secure boot enabled
> > > > >
> > > > > [    0.015637] Kernel command line: <...> ima_policy=3Dappraise_t=
cb ima_appraise=3Dfix
> > > > > [    0.015668] ima: Secure boot enabled: ignoring ima_appraise=3D=
fix boot parameter option
> > > > >
> > >=20
> > > Is it common to have two colons in the same line? =A0Is the colon bei=
ng
> > > used as a delimiter when parsing the kernel logs? =A0Should the secon=
d
> > > colon be replaced with a hyphen? =A0(No need to repost. =A0I'll fix i=
t
> > > up.)
> > > =A0
> >=20
> > AFAICS it has been used without any limitations, e.g:
> >=20
> > PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> > clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns=
: 133484873504 ns
> > microcode: CPU0: patch_level=3D0x08701013
> > Lockdown: modprobe: unsigned module loading is restricted; see man kern=
el_lockdown.7
> > ...
> >=20
> > I'd say we're fine using it.
>=20
> Ok. =A0FYI, it's now in next-integrity.
>=20
> Mimi
>=20

Thanks Mimi.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--k3qmt+ucFURmlhDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8XRDUACgkQYdRkFR+R
okOv3QgAidrD9B9w904OYqq3pVlZyT8GUdDpbIr0jliOvPKjHKVooNHQemfJhGU+
HzoVi2pG8ARlFC4elJBAwVXR8S9KWCT/xNL9C6N0VMg8FDik0TjmMJ0DRwh4s3oZ
oriQmx4vxaS4eNEfh5gBJrG4EwJdH2rCrbWtc4ojOzEhXE06xCsK9SN9PHy4x2Gp
zMleiQuD/YVOQK5+A3DII5/BQquL5r5zcwmZ82jho8dZGo5Ot/wc0xq6W5dSLdJw
7EScY58JI/z7H0JbxQuUG3qVmQNa4pVVx9v75cyoTwn5UeZ7XtOvshiO0pRY7M3z
8xueI7dSvd0gv2/Z6BsTFphHrfjQVw==
=mPff
-----END PGP SIGNATURE-----

--k3qmt+ucFURmlhDS--
