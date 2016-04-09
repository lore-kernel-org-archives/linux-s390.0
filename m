From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Sat, 9 Apr 2016 04:42:54 +0200
Message-ID: <201604090442.54328.arnd@arndb.de>
References: <20160407121838.GA22098@angband.pl> <CA+=Sn1kx1UumTYHa8AE-XAUNiSXTd5zoDxae1LL5YczC_VXe_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CA+=Sn1kx1UumTYHa8AE-XAUNiSXTd5zoDxae1LL5YczC_VXe_w@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Pinski <pinskia@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Nathan Lynch <Nathan_Lynch@mentor.com>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Yury Norov <ynorov@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

On Friday 08 April 2016, Andrew Pinski wrote:
> On Thu, Apr 7, 2016 at 5:18 AM, Adam Borowski <kilobyte@angband.pl> wrote:
> > On Wed, 6 Apr 2016, Geert Uytterhoeven wrote:
> >> On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> >>>  v6:
> >>>  - time_t, __kenel_off_t and other types turned to be 32-bit
> >>>    for compatibility reasons (after v5 discussion);
> >
> > Introducing a new arch today with y2038 problems is not a good idea.
> > Linus said so with appropriately pointy words in 2011.

This was before we made the decision to fix the y2038 problem for all
architectures.

> This is the third time we had this discussion on time_t for ILP32.  I
> had originally it as 32bit, then Catalin suggested I change it to
> 64bit and then Arnd (with his work for 2038 issue on 32bit arch) said
> ILP32 should match all other 32bit targets and the other 64bit time_t
> be fixed by the current work he was working on.  Now you are
> suggesting we change it again.
> Arnd can you please comment more on why we want 32bit time_t instead
> of the 64bit one?  I Know there was some POSIX (or was it C90)
> violation but I suspect there is an easy way to workaround this inside
> the kernel but the discussion to move over to 32bit time_t was already
> made by the time I started to look into that.

x32 still runs into new problems today, and will continue to have problems
with newly added drivers that pass time_t (or other __kernel_long_t) arguments
through ioctl.

To avoid having to audit every new driver for interfaces that behave
differently based on the __kernel_long_t definition, arm64 is not following
the same route as x86 here and instead uses the normal 32-bit ABI like
any other architecture. This means we use 32-bit time_t, aio_context_t,
size_t and clock_t and share the system call implementation with the
compat handling for arm (aarch32) mode.

Once we have the interfaces for 64-bit time_t in place in the kernel,
we will be able to rebuild glibc on all 32-bit architectures including
arm and arm64/ilp32 that way.

The POSIX and C99 incompatibility you mention is about struct timespec,
which uses 'long' as the type for the tv_nsec member. This is vaguely
related to the issue of 64-bit time_t, but is not the reason for
starting out with 32-bit time_t for the new ABI here.

[side note:
How to precisely handle tv_nsec on 32-bit architectures is still an open
issue that will have to be solved when we nail down the new system call
interfaces:
The issue specifically is what happens when the upper half of the
second 64-bit word in struct timespec argument passed into a system
call is nonzero: the normal 64-bit syscalls must return an error,
while the 32-bit user space expects the kernel to ignore the upper bits.
This means something between the application and the native system call
has to clear the bits, and this can either be done by copying the
data inside of glibc (as done on x32) or by adding an extra system
call entry point in the kernel.]

> >> We're already closer to the (future) y2038 than to the (past) introduction of
> >> LP64...
> >>
> >> These unfixable legacy applications have been spreading through x32 to
> >> the shiny new arm64 server architecture (does ppc64el also have an ILP32 mode,
> >> or is it planned)? Lots of resources are spent on maintaining the status quo,
> >> instead of on fixing the real problems.
> >
> > As an x32 (userland) porter, I can tell you that time_t!=long _did_ cause
> > non-trivial amounts of work.  But that work is already done (at least in
> > Debian), so you might as well benefit from it.
> 
> There is actually private code out there which uses timespec and
> timeval to pass time over the wire; yes I know bad coding style and
> all but they did it that way.  This is code which was working for x86
> and we are porting it to ARM64; a data center code by the way; not
> some networking code even.  This means they have not ported the code
> to fully 64bit yet and they might never.

This code will run into the same problem on arm64/ilp32 when built against
a future libc implementation that defines time_t as 64-bit, but at least
the glibc maintainers so far plan to leave this as a per-application
option for the forseeable future: even on a system that uses 64-bit time_t
in user space and kernel by default, you should be able to build an
application using a 32-bit time_t.

	Arnd
