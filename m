Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27996 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728273AbgGJSDv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 Jul 2020 14:03:51 -0400
Date: Fri, 10 Jul 2020 15:03:38 -0300
From: Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH v5] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
Message-ID: <20200710180338.GA10547@glitch>
References: <20200709164647.45153-1-bmeneg@redhat.com>
 <1594401804.14405.8.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594401804.14405.8.camel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org, erichte@linux.ibm.com, nayna@linux.ibm.com, stable@vger.kernel.org

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:23:24PM -0400, Mimi Zohar wrote:
> On Thu, 2020-07-09 at 13:46 -0300, Bruno Meneguele wrote:
> > APPRAISE_BOOTPARAM has been marked as dependent on !ARCH_POLICY in comp=
ile
> > time, enforcing the appraisal whenever the kernel had the arch policy o=
ption
> > enabled.
>=20
> > However it breaks systems where the option is set but the system didn't
> > boot in a "secure boot" platform. In this scenario, anytime an appraisa=
l
> > policy (i.e. ima_policy=3Dappraisal_tcb) is used it will be forced, wit=
hout
> > giving the user the opportunity to label the filesystem, before enforci=
ng
> > integrity.
> >=20
> > Considering the ARCH_POLICY is only effective when secure boot is actua=
lly
> > enabled this patch remove the compile time dependency and move it to a
> > runtime decision, based on the secure boot state of that platform.
>=20
> Perhaps we could simplify this patch description a bit?
>=20
> The IMA_APPRAISE_BOOTPARAM config allows enabling different
> "ima_appraise=3D" modes - log, fix, enforce - at run time, but not when
> IMA architecture specific policies are enabled. =A0This prevents
> properly labeling the filesystem on systems where secure boot is
> supported, but not enabled on the platform. =A0Only when secure boot is
> enabled, should these IMA appraise modes be disabled.
>=20
> This patch removes the compile time dependency and makes it a runtime
> decision, based on the secure boot state of that platform.
>=20

Sounds good to me.

> <snip>
>=20
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity=
/ima/ima_appraise.c
> > index a9649b04b9f1..884de471b38a 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -19,6 +19,11 @@
> >  static int __init default_appraise_setup(c
>=20
> > har *str)
> >  {
> >  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
> > +=09if (arch_ima_get_secureboot()) {
> > +=09=09pr_info("appraise boot param ignored: secure boot enabled");
>=20
> Instead of a generic statement, is it possible to include the actual
> option being denied? =A0Perhaps something like: "Secure boot enabled,
> ignoring %s boot command line option"
>=20
> Mimi
>=20

Yes, sure.

Thanks!

> > +=09=09return 1;
> > +=09}
> > +
> >  =09if (strncmp(str, "off", 3) =3D=3D 0)
> >  =09=09ima_appraise =3D 0;
> >  =09else if (strncmp(str, "log", 3) =3D=3D 0)
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8IrXoACgkQYdRkFR+R
okMw7wf/QLnOgC+jQhpff5dmbxQXCG/rSbdtVKMUjIej817eUaAGovHn4XwicYqn
xCg2qIqTHuF4e5aYOsVB+kRIVdNZI2GVL27O0SArwFrPgvvOan3CKK5nStQkXRr9
XsLBEsgLKDV91xaQxBXrxWSslJWln5YFZNZYxvOsrhiRLwt4m7P0eSIForfL4UI2
OoJhwTCuBBMEi906mhlmOQwFyTi9/NMQluwf2iB+moJzRMo79cfFU6D//rP9RfoP
yttKBvpWqWUbPQ3cAVHkke+Yqr06Cz8BDYT3hP0oRJaludvY2Q/xVjBIOi3sX0gI
dx8A3npnWwj0SUi90M+u4rIHQm9vCA==
=X95t
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
