From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ipc: provide generic compat versions of IPC syscalls
Date: Sat, 10 Dec 2011 00:21:35 +0100
Message-ID: <1690400.7yOAjHVqTH@wuerfel>
In-Reply-To: <20111209134852.f5b5bcbc.akpm@linux-foundation.org>
References: <201112091536.pB9Fa5f7002738@farm-0002.internal.tilera.com> <201112091903.pB9J39pd031553@farm-0002.internal.tilera.com> <20111209134852.f5b5bcbc.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@tilera.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Hellwig <hch@lst.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "J. Bruce Fields" <bfields@redhat.com>, NeilBrown <neilb@suse.de>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Friday 09 December 2011 13:48:52 Andrew Morton wrote:
> What would we need to do to get all architectures using the new
> interfaces, and remove __ARCH_WANT_OLD_COMPAT_IPC?

We would change the various compat_sys_ipc functions (mips, powerpc,
s390, sparc, x86) to call the new functions instead of the existing
ones, and test each architecture. For parisc, we might not
actually need the either version, but I'd have to take a closer look
to be sure.

> Regarding the implementation: rather than patching the header
> files, it would be more conventional (and arguably better) to add
> 
>         select ARCH_WANT_OLD_COMPAT_IPC
> 
> to arch/*/Kconfig, then use CONFIG_ARCH_WANT_OLD_COMPAT_IPC.

Yes.

	Arnd
