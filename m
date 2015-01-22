From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: kvms390 tree for Linux next
Date: Fri, 23 Jan 2015 08:39:24 +1100
Message-ID: <20150123083924.77942630@canb.auug.org.au>
References: <54C0FCD0.7080108@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qfOyFbnBRYwWaofcEkbsFzj"; protocol="application/pgp-signature"
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <54C0FCD0.7080108@de.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-next <linux-next@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

--Sig_/qfOyFbnBRYwWaofcEkbsFzj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, 22 Jan 2015 14:36:16 +0100 Christian Borntraeger <borntraeger@de.ib=
m.com> wrote:
>
> can you add the kvms390 tree at
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
>=20
> to linux-next?
>=20
> This tree will almost always be merged via the kvm tree, but it helps us
> anyway detecting broken things before I ask Paolo to pull.

Added from today with just you as the contact (I can add more contacts
if that makes sense).

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/qfOyFbnBRYwWaofcEkbsFzj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUwW4SAAoJEMDTa8Ir7ZwVGaIP/AtwNpb2ApfhkJDZjgmjYxi9
iyX4T4R++rP+/JruvlAbTJGQrhoCm6a3Y9snd784Q5gguWJ6XF9JrVtDPCq6pd3G
mKH2i3iCifoMyG2LC0sWw8qSff2bfxNWUWFREDNKiRnMW9+tj6ItM04sY8CayqAo
GDZ0FtFiKx4HGnZV+UTuhVor1OBN1AgssQzyPfNHRK+LJN5mt6lCK06XZoK0u+cN
76pzoNpnBvGOyMNhN3gDw4Z1hOp/DINCxdh8IlwzCFn0SHoax1PC9Ov4ZAt3Ccy3
i/H89RZZMrROTHj3YqvsrhRG5iTSyJT1Zvbbr/xj6Mo1C7UMgcrsWUWHler7G2LZ
7qi3ngX2VtYfC9/2X4PiMfdyzEDfEGlQBA9w6quDwFnejnri0FPOdRBdvgNMNOhb
l9QzaQlp6MuITJTOgSsuoCLvgGHC2FK6PF4LC0K8wrKSoTxIGQP2+7zbkqQ3rETi
eXRp1wfOXKJSdaHCUzrYwcaLiYpijUB45sit676TZMq42dsw9VIGHv5ZHsEwhd5i
0st/Ya6ErZfOQZvFWSXr+/PDxpYzBUviUTIg5I1a00v4Zch6DcsWZQfNNfeIYkes
qnman+4ae3Jqvah/5TEr9H2e4lKw64Gx00OsSmZRjFtwN6akXG0cwO/xwUSVbMxB
bKaXPhF9a6H6PO03PCO/
=zBYn
-----END PGP SIGNATURE-----

--Sig_/qfOyFbnBRYwWaofcEkbsFzj--
