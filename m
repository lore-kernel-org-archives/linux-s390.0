From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
Date: Fri, 30 Mar 2018 17:54:51 +0200
Message-ID: <20180330155451.4rppf7iy2e3wzimh@angband.pl>
References: <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
 <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
 <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
 <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
 <CA+55aFzHL1L_SEt_xqmJBfRRngTm4qbQGwxFvqSXw-MD2BiAOQ@mail.gmail.com>
 <7753539f-c72d-9e5a-eb2d-939e5514404b@physik.fu-berlin.de>
 <20180330105802.7df5pacjfqsqwa6l@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rubjl4urpbxgxvwa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330105802.7df5pacjfqsqwa6l@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.>
List-ID: <linux-s390.vger.kernel.org>


--rubjl4urpbxgxvwa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 12:58:02PM +0200, Ingo Molnar wrote:
> * John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
>=20
> > On 03/27/2018 12:40 PM, Linus Torvalds wrote:
> > > On Mon, Mar 26, 2018 at 4:37 PM, John Paul Adrian Glaubitz
> > > <glaubitz@physik.fu-berlin.de> wrote:
> > >>
> > >> What about a tarball with a minimal Debian x32 chroot? Then you can
> > >> install interesting packages you would like to test yourself.

> Here's the direct download link:
>   $ wget https://people.debian.org/~glaubitz/chroots/debian-x32-unstable.=
tar.gz

> Seems to work fine here (on a distro kernel) even if I extract all the fi=
les as a=20
> non-root user and do:
>=20
>   ~/s/debian-x32-unstable> fakechroot /usr/sbin/chroot . /usr/bin/dpkg -l=
  | tail -2
>=20
>   ERROR: ld.so: object 'libfakechroot.so' from LD_PRELOAD cannot be prelo=
aded (cannot open shared object file): ignored.
>   ii  util-linux:x32         2.31.1-0.5           x32          miscellane=
ous system utilities
>   ii  zlib1g:x32             1:1.2.8.dfsg-5       x32          compressio=
n library - runtime

> So that 'dpkg' instance appears to be running inside the chroot environme=
nt and is=20
> listing x32 installed packages.

> Although I did get this warning:
>   ERROR: ld.so: object 'libfakechroot.so' from LD_PRELOAD cannot be prelo=
aded (cannot open shared object file): ignored.
> Even with that warning, is still still a sufficiently complex test of x32=
 syscall=20
> code paths?

Instead of mucking with fakechroot which would require installing its :x32
part inside the guest, or running the test as root, what about using any
random static binary?  For example, a shell like sash or bash-static would
have a decentish syscall coverage even by itself.

I've extracted sash from
http://ftp.ports.debian.org/debian-ports//pool-x32/main/s/sash/sash_3.8-4_x=
32.deb
and placed at https://angband.pl/tmp/sash.x32

$ sha256sum sash.x32=20
de24097c859b313fa422af742b648c9d731de6b33b98cb995658d1da16398456  sash.x32

Obviously, you can compile a static binary that uses whatever syscalls you
want.  Without a native chroot, you can "gcc -mx32" although you'd need some
kind of libc unless your program is stand-alone.


It might be worth mentioning my "arch-test:
https://github.com/kilobyte/arch-test
Because of many toolchain pieces it needs, you want a prebuilt copy:
https://github.com/kilobyte/arch-test/releases/download/v0.10/arch-test_pre=
built_0.10.tar.xz
https://github.com/kilobyte/arch-test/releases/download/v0.10/arch-test_pre=
built_0.10.tar.xz.asc
-- while it has _extremely_ small coverage of syscalls (just write() and
_exit(), enough to check endianness and pointer width), concentrating on
instruction set inadequacies (broken SWP on arm, POWER7 vs POWER8, powerpc
vs powerpcspe, etc), it provides minimal test binaries for a wide range of
architectures.


Meow!
--=20
=E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
=E2=A3=BE=E2=A0=81=E2=A2=B0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 I was born =
a dumb, ugly and work-loving kid, then I got swapped on
=E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 the materni=
ty ward.
=E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80

--rubjl4urpbxgxvwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1EvJgtm22kuq1XITcZ3MgL7QB/kFAlq+XcsACgkQcZ3MgL7Q
B/mYBRAAi4LT3AZExNjOZ6td+RWmTVjWPKGJeWViLzuBcVteXwZQnkidx395scxR
jv8kVqCqAxmEMyTdUwBxPQYb1i9e0A9+oPLQCG/U18HN9/4Z5pfAWnv5qgI5xhpM
wLebeo75Irgpg9V40C+7pJ3e6zYit22ehx8YCDqFbj0JXy1aGgcd5URJYFBmGC7S
O2Cvjaehfg/V6gTJ+U/7mbtlxeWVxW94dXHVnV+K1Q9Wh+vQcfHVrp7XmQZPZTSh
H5UqErkBPSX5K8zTYRyfQry87dZblsk4OXdcX8Jld7UBceymu6Cbt7I9CGMRUART
030Y5YUPVKWHaoXkR9GqQOjzp7nauiUcPsekkh+Sym62BIUiXoY6dqKqJpgOuvCe
vhOgTyaspRaT1HRQUQTRLEOGEjK/x9ULY9RaHAwBZunzkz5CS41jq9SHJCza8JL6
ATx6BYhAo0Ulw0YHFxaKugEsiyo6HdEoqsH3IwwGMqvinYguQ76Q19zggjxRei3Z
aa9bS6/6hGJhXiLHi9C35syrsddB/RcijZ6W8jVzrO8zTHUQPcrGAsB0yl+Jfn5s
QD5zvQg1uO7756S6vfYapD6LWZ8pEczStkc1WmJN0cd6BJsgyd5sD5nELGqSCEW5
DYSEmMre+Esljha61BC9FrWAjSxfbUYXa9IipzgB0L3N26s+Qbw=
=nksn
-----END PGP SIGNATURE-----

--rubjl4urpbxgxvwa--
