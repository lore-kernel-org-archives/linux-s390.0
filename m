From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 11/15] target-s390x: New QMP command query-cpu-model
Date: Mon, 30 Mar 2015 14:19:27 -0600
Message-ID: <5519AFCF.2000102@redhat.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com> <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lOu0WC9owl7muqHIrK025CTpCv1eEDagK"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427725708-52100-12-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lOu0WC9owl7muqHIrK025CTpCv1eEDagK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2015 08:28 AM, Michael Mueller wrote:
> This patch implements a new QMP request named 'query-cpu-model'.
> It returns the cpu model of cpu 0 and its backing accelerator.
>=20
> request:
>   {"execute" : "query-cpu-model" }
>=20
> answer:
>   {"return" : {"name": "2827-ga2", "accel": "kvm" }}
>=20
> Alias names are resolved to their respective machine type and GA names
> already during cpu instantiation. Thus, also a cpu model like 'host'
> which is implemented as alias will return its normalized cpu model name=
=2E
>=20
> Furthermore the patch implements the following function:
>=20
> - s390_cpu_models_used(), returns true if S390 cpu models are in use
>=20
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---

> +++ b/qapi-schema.json
> @@ -2516,6 +2516,16 @@
>  { 'command': 'query-machines', 'returns': ['MachineInfo'] }
> =20
>  ##
> +# @AccelId
> +#
> +# Defines accelerator ids
> +#
> +# Since: 2.4
> +##
> +{ 'enum': 'AccelId',
> +  'data': ['qtest', 'tcg', 'kvm', 'xen'  ] }

Unusual spacing (0 spaces after '[' but 2 spaces before closing ']'?),
but not necessarily wrong.


> +##
> +# @CpuModelInfo:
> +#
> +# Virtual CPU model definition.
> +#
> +# @name: the name of the CPU model definition
> +#
> +# @accel: AccelId (name) of this cpu models accelerator

s/models/model's/


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lOu0WC9owl7muqHIrK025CTpCv1eEDagK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVGa/PAAoJEKeha0olJ0NqffQH/1W9huihPCjQt0e1YHT9Vc6c
Yp1jhArwBRTere8b26hkPtkmISgeXLDwQYVdRcSMjZgyVSgiwwCZbZsOaWdNyBqz
XMoJDsafCscdhQjk3bcMbnS2yH6XyvfKA6BZs65rP9TPCnosW191G0gUixYJIuhm
ZG0IqIswQU/xX+nGqFYKBpk/BjHOKgTwtzytkhyBnQuWo9Aqjeu1sVYclbPGEQvm
CMve2wIe0mn4Mec6AvmXgnX9/OMv7wiPVPcjfGv8OucM3e81FbutQJxk6vt8BeAB
D7WVUPanF0+T+JRZ/DIytrPY5jC3GASkpwB5hra1ATHRtHHL/EtoywLn/m840X0=
=MISo
-----END PGP SIGNATURE-----

--lOu0WC9owl7muqHIrK025CTpCv1eEDagK--
