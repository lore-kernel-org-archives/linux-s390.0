From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 12/15] cpu-model/s390: Extend QMP
 command query-cpu-definitions
Date: Tue, 17 Feb 2015 11:09:34 -0700
Message-ID: <54E383DE.5060902@redhat.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com> <1424183053-4310-13-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AkPf2Iu5Vm8JwwOh7KLTTRwLEXEVtPbVv"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-13-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AkPf2Iu5Vm8JwwOh7KLTTRwLEXEVtPbVv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2015 07:24 AM, Michael Mueller wrote:
> This patch implements the QMP command 'query-cpu-definitions' in the S3=
90
> context. The command returns a in terms of machine release date descend=
ing
> sorted list of cpu model names in the current host context.

returns a list of cpu model names sorted by descending release dates.

Does guaranteeing the sorting as part of the interface really matter, or
would it be better to just return the list with no documented sorting
(where callers treat it as unsorted)?

> A consumer may
> successfully request each listed cpu model as long for a given accelera=
tor
> this model is runnable.
>=20
> Thy QMP type AccelCpuModelInfo is introduced and the type CpuDefinition=
Info
> is extended by the optional field 'accelerators'. It contains a list of=
 named
> accelerators and some indication whether the associated cpu model is ru=
nnable
> or the default cpu model. The default cpu model is used either no speci=
fic cpu
> was requested during QEMU startup or the cpu model with named 'host'.
>=20
> request:
>   {"execute": "query-cpu-definitions"}
>=20
> answer:
>   {"return":
>     [{"name":"2964-ga1","accelerators":[{"name":"kvm","runnable":false,=
"default":false}]},
>      {"name":"2828-ga1","accelerators":[{"name":"kvm","runnable":false,=
"default":false}]},
>      {"name":"2827-ga2","accelerators":[{"name":"kvm","runnable":true,"=
default":true}]},
>      {"name":"2827-ga1","accelerators":[{"name":"kvm","runnable":true,"=
default":false}]},
>      {"name":"2818-ga1","accelerators":[{"name":"kvm","runnable":true,"=
default":false}]},
>      ...
>      {"name":"2064-ga1","accelerators":[{"runnable":true,"name":"kvm","=
default":false}]}
>     ]
>    }
>=20

Looks okay from an interface perspective.

> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
>  qapi-schema.json          |  21 +++++++++-
>  target-s390x/cpu-models.c |  15 +++++++
>  target-s390x/cpu-models.h |   1 +
>  target-s390x/cpu.c        | 100 ++++++++++++++++++++++++++++++++++++++=
+++++---
>  4 files changed, 130 insertions(+), 7 deletions(-)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 9431fc2..a5d38ae 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2485,16 +2485,35 @@
>    'data': ['qtest', 'tcg', 'kvm', 'xen'  ] }
> =20
>  ##
> +# @AccelCpuModelInfo:
> +#
> +# Accelerator specific CPU model data
> +#
> +# @id: the accelerator id
> +#

There is no 'id' field below, did you mean 'name'?

> +# @default: cpu model for 'host'
> +#
> +# @runnable: cpu model can be activated on hosting machine
> +#
> +# Since: 2.3.0
> +#
> +##
> +{ 'type': 'AccelCpuModelInfo',
> +  'data': { 'name': 'AccelId', 'default': 'bool', 'runnable': 'bool' }=
 }
> +
> +##
>  # @CpuDefinitionInfo:
>  #
>  # Virtual CPU definition.
>  #
>  # @name: the name of the CPU definition
>  #
> +# @accelerators: #optional cpu model offered per accelerator (since 2.=
3.0)
> +#

Must the field be optional, or will we always provide it?  Since this is
an output-only field, it is okay for back-compat to make the new field
unconditional.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--AkPf2Iu5Vm8JwwOh7KLTTRwLEXEVtPbVv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJU44PeAAoJEKeha0olJ0NqtZ0H/3MOR8cWeakx5I7EHeahe3Tw
xnpjf9OgBB/UHH8AEivQdWWRTOv3jmZAvITAxEfu86hZZcA1U1a2orKs2WyMbfNQ
DYIm/W/TgB1ipUfXL9Cu46TYYsEvpedYWSRTrc3Vg6TGuSUhjoK6fig3I7qf3G/N
OUcXRPEff/roeyGk/OrmgWNuKB4DWy+qta56hTmrxIVekyaqX1E0s7cmoh0ZpCpc
1nEBhhgQHody2SYepgidiw2L61S5W+OGDmR8/zi7y703PMr/5BzkR+eHFuzcFRPJ
SBsYbP+BATvifLG0N2Hl9y6FAwNhNE7wXUwBj1OsBxCW19hy+oV0y04MyTpsN14=
=t/Zn
-----END PGP SIGNATURE-----

--AkPf2Iu5Vm8JwwOh7KLTTRwLEXEVtPbVv--
