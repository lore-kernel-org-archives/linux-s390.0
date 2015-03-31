From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v4 12/15] Add optional parameters to QMP
	command query-cpu-definitions
Date: Tue, 31 Mar 2015 13:50:57 -0600
Message-ID: <551AFAA1.8080003@redhat.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1427725708-52100-13-git-send-email-mimu@linux.vnet.ibm.com>
	<20150331194656.GK7031@thinpad.lan.raisama.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qFwk5fAc5JfI59jT5aRMvLASBjGkUA52S"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20150331194656.GK7031@thinpad.lan.raisama.net>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qFwk5fAc5JfI59jT5aRMvLASBjGkUA52S
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2015 01:46 PM, Eduardo Habkost wrote:
> On Mon, Mar 30, 2015 at 04:28:25PM +0200, Michael Mueller wrote:
> [...]
>>  ##
>>  # @query-cpu-definitions:
>>  #
>>  # Return a list of supported virtual CPU definitions
>>  #
>> +# @machine: #optional machine type (since 2.4)
>> +#
>> +# @accel: #optional accelerator id (since 2.4)
>> +#
>>  # Returns: a list of CpuDefInfo
>>  #
>>  # Since: 1.2.0
>>  ##
>> -{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'=
] }
>> +{ 'command': 'query-cpu-definitions',
>> +  'data': { '*machine': 'str', '*accel': 'AccelId' },
>> +  'returns': ['CpuDefinitionInfo'] }
>=20
> What happens if the new parameters are provided to an old QEMU version
> that doesn't accept them? It looks like we need an introspection
> mechanism or a new command name.

Providing an optional parameter that a new qemu understands to an older
qemu gracefully errors out about an unknown parameter.  But it's
annoying to have to probe for whether the parameter is understood by
exploiting that particular error message from older qemu.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qFwk5fAc5JfI59jT5aRMvLASBjGkUA52S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJVGvqhAAoJEKeha0olJ0NqNbwH/0AUZOtT/RYcOocmgeEYvjoO
WsgkTB1Pl//qYgXhnHPX/I1ysSMpW6kkjiGZPbm5hqgt1dgSDb0VtCdczSOaMIlL
WW5CkfjsUW08MD10hBq8QZ141pMoMTqanMJhcOmnxm2kmxm7e9f2W6PdFB6lfalD
GJIyZLJDTfiqxODeILLs+PSYQLK98ly7i/+dyM9NOrjLAw9et38Cc0qYwFsZ7xEf
YD317TCf+aYP6isc+Ikf4qBizHlaIzJfWLl/z1RZtOgu1YVAr1q2jnHRFSaqqtxJ
SoThkTT9VLXoqNon4piW6UsK4Eb9sVi3ex9A72tsq4e1qQVeEhp/AM3dHzG+uB8=
=a7bt
-----END PGP SIGNATURE-----

--qFwk5fAc5JfI59jT5aRMvLASBjGkUA52S--
