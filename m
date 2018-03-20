From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Date: Tue, 20 Mar 2018 09:59:32 +0100
Message-ID: <20180320085932.xnwkpiz5gpegnw5d@gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
 <20180319232342.GX30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319232342.GX30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>


* Al Viro <viro@ZenIV.linux.org.uk> wrote:

> > For example this attempt at creating a new system call:
> > 
> >   SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)
> > 
> > ... would translate into something like:
> > 
> > 	.name = "moron", .pattern = "WWW", .type = "int",    .size = 4,
> > 	.name = NULL,                      .type = "loff_t", .size = 8,
> > 	.name = NULL,                      .type = "size_t", .size = 4,
> > 	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */
> > 
> > i.e. "WDW". The build-time constraint checker could then warn about:
> > 
> >   # error: System call "moron" uses invalid 'WWW' argument mapping for a 'WDW' sequence
> >   #        please avoid long-long arguments or use 'SYSCALL_DEFINE3_WDW()' instead
> 
> ... if you do 32bit build.

Yeah - but the checking tool could do a 32-bit sizing of the types and thus the 
checks would work on all arches and on all bitness settings.

I don't think doing part of this in CPP is a good idea:

 - It won't be able to do the full range of checks

 - Wrappers should IMHO be trivial and open coded as much as possible - not hidden
   inside several layers of macros.

 - There should be a penalty for newly introduced, badly designed system call
   ABIs, while most CPP variants I can think of will just make bad but solvable 
   decisions palatable, AFAICS.

I.e. I think the way out of this would be two steps:

 1) for new system calls: hard-enforce the highest quality at the development
    stage and hard-reject crap. No new 6-parameter system calls or badly ordered
    arguments. The tool would also check new extensions to existing system calls, 
    i.e. no more "add a crappy 4th argument to an existing system call that works 
    on x86 but hurts MIPS".

 2) for old legacies: cleanly open code all our existing legacies and weird
    wrappers. No new muck will be added to it so the line count does not matter.

... is there anything I'm missing?

Thanks,

	Ingo
