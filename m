From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] new SYSCALL_DEFINE/COMPAT_SYSCALL_DEFINE wrappers
Date: Sun, 25 Mar 2018 20:20:52 -1000
Message-ID: <CA+55aFy974z4PQMzSKbvcz02BeyRQTbXxyjw_GgjrXSeAf3wwQ@mail.gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk> <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com> <20180319232342.GX30522@ZenIV.linux.org.uk>
 <20180322001532.GA18399@ZenIV.linux.org.uk> <20180326004017.GA2211@ZenIV.linux.org.uk>
 <20180326034750.GN30522@ZenIV.linux.org.uk> <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFw8VGnVgaWHVFP-LChMNaoANOwT18jJEWzSCRLFeRGcmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 25, 2018 at 8:15 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> HOWEVER.
>
> I didn't actually test any of the compat or x32 ones, and the way I
> did it there also was no type-checking or other automated catching of
> getting it wrong. So it's almost certainly completely buggy, but the
> _intent_ is there and there is a remote possibility that it might even
> work.

Note: the commit message is "broken, but working, ptregs system call
conversion for x86-64".

The "but working" is not because it would be right, but because it
booted a real 64-bit distribution successfully, and I actually used
that kernel.

But that only tests the native 64-bit case, it in no way tests the
compat or x32 cases what-so-ever. That part was literally a "it
compiles - it must be perfect" with absolutely zero testing of even
the most trivial kind.

And it really would have been most trivial to just do a "Hello world"
and build it with "-m32". I didn't do even that, and if I had, I would
have been honestly surprised had it worked.

But there was a _theoretical_ chance that it could have worked. Maybe.

      Linus
