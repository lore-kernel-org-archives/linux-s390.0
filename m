Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732239AbfKFRiS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 12:38:18 -0500
Date: Wed, 6 Nov 2019 18:37:54 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC 30/37] DOCUMENTATION: protvirt: Diag 308 IPL
Message-ID: <20191106183754.68e1be0f.cohuck@redhat.com>
In-Reply-To: <6dd98dfe-63ce-374c-9b04-00cdeceee905@linux.ibm.com>
References: <20191024114059.102802-1-frankja@linux.ibm.com>
        <20191024114059.102802-31-frankja@linux.ibm.com>
        <20191106174855.13a50f42.cohuck@redhat.com>
        <6dd98dfe-63ce-374c-9b04-00cdeceee905@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KFFssDcS.y.elHxVLw6NCDc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

--Sig_/KFFssDcS.y.elHxVLw6NCDc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2019 18:05:22 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/6/19 5:48 PM, Cornelia Huck wrote:
> > On Thu, 24 Oct 2019 07:40:52 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Description of changes that are necessary to move a KVM VM into
> >> Protected Virtualization mode.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  Documentation/virtual/kvm/s390-pv-boot.txt | 62 +++++++++++++++++++++=
+
> >>  1 file changed, 62 insertions(+)
> >>  create mode 100644 Documentation/virtual/kvm/s390-pv-boot.txt

> > So... what do we IPL from? Is there still a need for the bios?
> >=20
> > (Sorry, I'm a bit confused here.)
> >  =20
>=20
> We load a blob via the bios (all methods are supported) and that blob
> moves itself into protected mode. I.e. it has a small unprotected stub,
> the rest is an encrypted kernel.
>=20

Ok. The magic is in the loaded kernel, and we don't need modifications
to the bios?

--Sig_/KFFssDcS.y.elHxVLw6NCDc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3DBPIACgkQ3s9rk8bw
L68O9Q/+PNV0FWP35V+Byn2eX/IP2pwYzdpktSY2sS/oEIJ2PnUHuJbTqazcwyul
JEJx6NWOunSsqLE4kJHUqncbfLzq+LkbuO+/IXVW7SWuf+J3XhMbT8JyHSSksI6e
LVZgI4D40G4kfCmMT4UubszAnpmpwnxZcgIiCy7Ry5qZEx2jPVxAo6HR3zQ9nkW2
yk+xhrjGmjk0uVR5Ec76jmSTeqMlcDNNQ+wjrZI5TV8HlrxOyaAaJd27MJPuaoPL
GvWjYvVzt8MePAa+T8OXTwR4JSI6YMwUx9X4OuOFIunfgg18f8rWwVqJ0Y/DPw8g
c/rhM3wTfWnOOKCl8qFSBbYXv3ps7YSuJHUIMjRdbNIj4JWXEjpEC4oolMJe5gT7
rNf14r6ERv2y5jMgojSKjwCuh7ZO0ocPeJCTuYxOt3GM8bZ9kSJXE2oxnXXrRchS
MaLTVQj/GUmgowh/8yyBBksrXRapzQ9V08iBkATKn5fUN89/xcVFTZnCUe3VkZfI
KQ15yj7LrDKMAMBwJh3G7MHaNoQnO7GlOFpRluWVNaLRmw84jFBHufxKnm7urTHe
YhC+KH4rPuAerO+VtTHWqSFH3UPyP/8w96q1LLj9kCXXutYKQwcyg29m98L/MCFV
qeNEKJfWDyw+PQl5CVtX6hogkMfhpzWQ2eDeTDkLn544d7DeR1E=
=VQrj
-----END PGP SIGNATURE-----

--Sig_/KFFssDcS.y.elHxVLw6NCDc--
