From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 12 Jan 2009 20:23:21 +0000
Subject: Re: [PATCH] [S390] lcs net: fix building when multicast is disabled
Message-Id: <200901121523.22957.vapier@gentoo.org>
In-Reply-To: <20090112195426.GA5356@osiris.boeblingen.de.ibm.com>
References: <20090112195426.GA5356@osiris.boeblingen.de.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="--nextPart1475529.v6cfo6l3FN"
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

--nextPart1475529.v6cfo6l3FN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 12 January 2009 14:54:26 Heiko Carstens wrote:
> On Mon, Jan 12, 2009 at 08:59:03AM -0500, Mike Frysinger wrote:
> > There is a CONFIG_IP_MULTICAST check missing around some multicast code
> > so that if you try and build lcs with it disabled, it fails like so:
> >
> > drivers/s390/net/lcs.c: In function ???lcs_new_device???:
> > drivers/s390/net/lcs.c:2180: error: implicit declaration of function
> > ???lcs_set_multicast_list??? make[1]: *** [drivers/s390/net/lcs.o] Error
> > 1
> >
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> > ---
>
> Hmm... I fixed this differently more than a month ago and it is still
> not upstream. http://marc.info/?l=3Dlinux-s390&m=3D122891092111879&w=3D2

i hit it in latest git (mainline and s390) which is why i wrote the patch. =
 if=20
you already have a fix pending, that works for me ;).
=2Dmike

--nextPart1475529.v6cfo6l3FN
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJa6a6AAoJEEFjO5/oN/WBcV4QAOCCIcc3QgY8LzTvbBwDwpSF
3WCHVDvs6aVz6BMKIKZ2Ux5dlRo+/+sPMACqTXZpWr80NmasHlCVgSFC+uCKGGOX
11md+N09f67eq9DbnXIXKe/sZhZf8eaoXpPPxmvBr5oqbfGfk4x1nl43pMUSSpcC
+pbpFb0Px3HLH45JizDm9K0mtstyhZLg4JgAMdJtISrDBuoO/Rx+KZES0BFTbiuz
vL2nZqn4IJn7FKW8dk03uFebOPT+PEkyAw5SosDq5yxbuDOIKZLgKCEwQJeZYSzH
jgUG2f3VQe/Y2KU/E3vAwd11yktSoPm3HHIlOubt54dTubcYNQrPwb6LU5O4gjXl
Mg+9qK5mBp2S36m9EFiSf54Qa3tkGXyjsBNf35v+4qOqoS2B/OBD93xQNuy4EA0q
fQ+LRIbvZtmMe0bWC0drQ5z4QSa89i0Z6kMrQSVk1RZgsWU024kheDz6IRyZK+iH
OQ0aMrKE1HoHygPy2h7NYPhAkbZ6xjplwyGhQ2ax5McuBbIDUSiXkgqLgE9ub3ka
cwVOwI1Z3lKRXmkIqr7rnFTqUbjc6M7kxvBl1mtMHTZP3C7u8UJEAN5nmS8bAV/A
z9f/y8w//8eZK+DfiWFCNANdIO+07YkjP2RNIOFe7I84iJIXlSHp+WQsiI2pwJJc
ZRjEXeN7ogO8r+qFTtQm
=/28o
-----END PGP SIGNATURE-----

--nextPart1475529.v6cfo6l3FN--
