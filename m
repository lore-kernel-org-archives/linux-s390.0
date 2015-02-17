From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/15] cpu-model/s390: Add QMP command
 query-cpu-model
Date: Tue, 17 Feb 2015 11:03:11 -0700
Message-ID: <54E3825F.7080701@redhat.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-12-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KG2gT66tkhurAeW1Erl9S1O5QIigvwowh"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-12-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KG2gT66tkhurAeW1Erl9S1O5QIigvwowh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2015 07:24 AM, Michael Mueller wrote:
> This patch implements a new QMP request named 'query-cpu-model'.
> It returns the cpu model of cpu 0 and its backing accelerator.
>=20
> request:
>   {"execute" : "query-cpu-model" }
>=20
> answer:
>   {"return" : {"name": "2827-ga2", "accelerator": "kvm" }}
>=20
> Alias names are resolved to their respective machine type and GA names
> already during cpu instantiation. Thus, also a cpu model like 'host'
> which is implemented as alias will return its normalized cpu model name=
=2E
>=20
> Furthermore the patch implements the following functions:
>=20
> - s390_cpu_typename(), returns the currently selected cpu type name or =
NULL
> - s390_cpu_models_used(), returns true if S390 cpu models are in use
>=20
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
> =20
> +##
> +# @CpuModelInfo:
> +#
> +# Virtual CPU model definition.
> +#
> +# @name: the name of the CPU model definition
> +#
> +# Since: 2.3.0
> +##
> +{ 'type': 'CpuModelInfo',
> +  'data': { 'name': 'str', '*accelerator': 'AccelId' } }

You didn't document '*accelerator', including mention that it is
optional (why would it not be output always?).

> +
> +##
> +# @query-cpu-model:
> +#
> +# Return to current virtual CPU model

s/to/the/

> +#
> +# Returns: CpuModelInfo
> +#
> +# Since: 2.3.0

We aren't very consistent on '2.3' vs. '2.3.0', so I won't complain
about that.

> +##
> +{ 'command': 'query-cpu-model', 'returns': 'CpuModelInfo' }

Seems reasonable from the interface point of view; I have not closely
reviewed the implementation.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--KG2gT66tkhurAeW1Erl9S1O5QIigvwowh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJU44JfAAoJEKeha0olJ0Nqen8IAKixtAzkha8h62rvrFdvnyYg
xg0JafG+wBEjaLjN2GOeNWoRsUsiXCSvARBF6adfwlPhOnTjHc4ASmMMMS1rYfx5
MrCgmYU992qxzntlLbgzbLuVjm9oDf3fanwBwtI4SBg/f9BTzM6I/tn/KfpGmk3L
bPsyHgSeyFGqtVKFcXYtXTEZe5xJ6FCJwMJXuFtRnXbUBKP0oo+9Hu9hYhA+tfj3
jG3Q2Lppw1NCzN97V5po/+nTdku7IsqlJd4xmMiGJ08/UNtaiyHh3Psi72Y9Ry7V
aDfV2qeq4s/UU3s5W8aXdkVriZcgnynzkhX5qw+nUv7pvHJUKm2+N/nhaP/W5vU=
=qrNX
-----END PGP SIGNATURE-----

--KG2gT66tkhurAeW1Erl9S1O5QIigvwowh--
