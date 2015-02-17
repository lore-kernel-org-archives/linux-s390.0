From: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH v2 02/15] cpu-model: Introduce option
 --probe to switch into probe mode
Date: Tue, 17 Feb 2015 12:16:20 -0700
Message-ID: <54E39384.6000308@redhat.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
	<1424183053-4310-3-git-send-email-mimu@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s4ofQgLFQKxuu22LXFGNFiRn5fJOftGLd"
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1424183053-4310-3-git-send-email-mimu@linux.vnet.ibm.com>
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
To: Michael Mueller <mimu@linux.vnet.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s4ofQgLFQKxuu22LXFGNFiRn5fJOftGLd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2015 07:24 AM, Michael Mueller wrote:
> The option --probe allows to switch into probe mode also for machines
> different from none. If one or more accelerators are specified these
> accelerators are used to provide probable properties. If no accelerator=

> is given a list of accellerators that support probing is used.

s/accellerators/accelerators/

>=20
> Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
> ---
>  accel.c                | 13 ++++++++-----
>  include/sysemu/accel.h |  2 +-
>  qemu-options.hx        |  8 ++++++++
>  vl.c                   |  7 ++++++-
>  4 files changed, 23 insertions(+), 7 deletions(-)
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--s4ofQgLFQKxuu22LXFGNFiRn5fJOftGLd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJU45OEAAoJEKeha0olJ0NqyWsH+wV+yxv2ghyVHqoLxNIG+f2+
y36C9k8c46wcZfvUtpOmfU93cFwEqnO8NL1RUt3h2Yz16P9UZ+rx+vB2/gDKztll
UE7Oagg+CjCHWDO7+Yu0Virkp2qHSk1cxeubMoxYaojAFo8x58NI9PBPDlsLzvSt
FJlRVt4dvtnpdmh2XiFX/Xvcu7uMLQe+upsNUMVIaJfe6TBFu6IDAgI+CNqUM4wd
qLcbrPuTPf7b8xjjJmlaCbb+4cxJr37mEN4/l0SFkNoWOH9lAweaZ6HixX1wCocE
BhMarkh1LcE7gwDAwIVZ/Xgz/fpNmS5rf7KQjgI38g0gbtup1emOcPpiSDaiYOo=
=6G06
-----END PGP SIGNATURE-----

--s4ofQgLFQKxuu22LXFGNFiRn5fJOftGLd--
