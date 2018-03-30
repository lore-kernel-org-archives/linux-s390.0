From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
Date: Fri, 30 Mar 2018 12:58:02 +0200
Message-ID: <20180330105802.7df5pacjfqsqwa6l@gmail.com>
References: <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk>
 <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk>
 <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
 <428751c8-6920-096b-8694-a3f1b8990bdf@physik.fu-berlin.de>
 <CA+55aFwp-T-WFN95j7u5nn2BExxviJCx1-RgD3Mnu1AN_GYD3w@mail.gmail.com>
 <8a8ee344-fb19-3ed9-f7dc-db63f703e6d3@physik.fu-berlin.de>
 <CA+55aFzHL1L_SEt_xqmJBfRRngTm4qbQGwxFvqSXw-MD2BiAOQ@mail.gmail.com>
 <7753539f-c72d-9e5a-eb2d-939e5514404b@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7753539f-c72d-9e5a-eb2d-939e5514404b@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redha>
List-ID: <linux-s390.vger.kernel.org>


* John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> On 03/27/2018 12:40 PM, Linus Torvalds wrote:
> > On Mon, Mar 26, 2018 at 4:37 PM, John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >>
> >> What about a tarball with a minimal Debian x32 chroot? Then you can
> >> install interesting packages you would like to test yourself.
> > 
> > That probably works fine.
> 
> I just created a fresh Debian x32 unstable chroot using this command:
> 
> $ debootstrap --no-check-gpg --variant=minbase --arch=x32 unstable debian-x32-unstable http://ftp.ports.debian.org/debian-ports
> 
> It can be downloaded from my Debian webspace along checksum files for
> verification:
> 
> > https://people.debian.org/~glaubitz/chroots/
> 
> Let me know if you run into any issues.

Here's the direct download link:

  $ wget https://people.debian.org/~glaubitz/chroots/debian-x32-unstable.tar.gz

Checksum should be:

  $ sha256sum debian-x32-unstable.tar.gz
  010844bcc76bd1a3b7a20fe47f7067ed8e429a84fa60030a2868626e8fa7ec3b  debian-x32-unstable.tar.gz

Seems to work fine here (on a distro kernel) even if I extract all the files as a 
non-root user and do:

  ~/s/debian-x32-unstable> fakechroot /usr/sbin/chroot . /usr/bin/dpkg -l  | tail -2

  ERROR: ld.so: object 'libfakechroot.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
  ii  util-linux:x32         2.31.1-0.5           x32          miscellaneous system utilities
  ii  zlib1g:x32             1:1.2.8.dfsg-5       x32          compression library - runtime

So that 'dpkg' instance appears to be running inside the chroot environment and is 
listing x32 installed packages.

Although I did get this warning:

  ERROR: ld.so: object 'libfakechroot.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.

Even with that warning, is still still a sufficiently complex test of x32 syscall 
code paths?

BTW., "fakechroot /usr/sbin/chroot ." crashes instead of giving me a bash shell.

Thanks,

	Ingo
