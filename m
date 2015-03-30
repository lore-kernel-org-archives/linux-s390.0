From: Eric Blake <eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 12/15] Add optional parameters to QMP
 command query-cpu-definitions
Date: Mon, 30 Mar 2015 14:28:01 -0600
Message-ID: <5519B1D1.5060503@redhat.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com> <1427725708-52100-13-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XWT1U9SnCRBQTvbAw9qQJQ8pVQt7MPpK0"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427725708-52100-13-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XWT1U9SnCRBQTvbAw9qQJQ8pVQt7MPpK0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2015 08:28 AM, Michael Mueller wrote:
> The patch adds optional parameters to the QMP command query-cpu-definit=
ions.
> Thus the signature of routine arch_query_cpu_definitions needs to be ch=
anged
> for the stub function and all target implementations:
>=20
> target-arm
> target-i386
> target-ppc
> target-s390
>=20
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---

> +++ b/qapi-schema.json
> @@ -2532,21 +2532,31 @@
>  #
>  # @name: the name of the CPU definition
>  #
> +# @default: #optional defines if cpu model is the default (since 2.4)

Reads poorly.  How about:

# @default: #optional true if cpu model is the default, omitted if false
(since 2.4)


> +#
> +# @runnable: #optional defines if cpu model is runnable (since 2.4)

Similarly:

# @runnable: #optional true if cpu model is runnable, omitted if false
(since 2.4)

> +#
>  # Since: 1.2.0
>  ##
>  { 'type': 'CpuDefinitionInfo',
> -  'data': { 'name': 'str' } }
> +  'data': { 'name': 'str', '*is-default': 'bool', '*runnable': 'bool' =
} }
> =20
>  ##
>  # @query-cpu-definitions:
>  #
>  # Return a list of supported virtual CPU definitions
>  #
> +# @machine: #optional machine type (since 2.4)
> +#
> +# @accel: #optional accelerator id (since 2.4)

Maybe mention that these two fields are for filtering results.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--XWT1U9SnCRBQTvbAw9qQJQ8pVQt7MPpK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVGbHRAAoJEKeha0olJ0NqLJcH/Asu74Bf16iPO/zOTs0J3I1T
w1lm0WOv24eARofEZIA1FA2q0XkrWqaG61OaBMnytLqV4ogD5mk9lJzvxuiPi2wg
NeuLyXtydDMvSsLwCsNZVNM0hTBrxK+JRm20DqSEflyVT4TEZPNFdCeHqZsys41+
6IhIpT+cB4beZy2ks5lcVc7x4TU3XKsYdSEbmkARkD/N3IwboJKO0U0mV8G8zfz9
9hFitDjybzl/r+FqllOwK/Skql1DIRR65DhfOgz+vlLgxgcS6Itq/+fiAUtjoUI1
tTu/o6VgHGTD7KE4QSaIB8ncNC9nAk5h8vbcyDPCkXa7zMqVqklKrS97R9ibrnc=
=dheX
-----END PGP SIGNATURE-----

--XWT1U9SnCRBQTvbAw9qQJQ8pVQt7MPpK0--
