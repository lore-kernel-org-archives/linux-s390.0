From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Tue, 17 May 2016 17:37:55 +0200
Message-ID: <4173531.IRSphtVpg9@wuerfel>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com> <573B0A4D.4090704@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <573B0A4D.4090704@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nd@arm.com, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, bamvor.zhangjian@huawei.com, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, GNU C Library <libc-alpha@sourceware.org>
List-ID: <linux-s390.vger.kernel.org>

On Tuesday 17 May 2016 13:10:53 Szabolcs Nagy wrote:
> On 05/04/16 23:08, Yury Norov wrote:
> > This version is rebased on kernel v4.6-rc2, and has fixes in signal subsystem.
> > It works with updated glibc [1] (though very draft), and tested with LTP.
> > 
> > It was tested on QEMU and ThunderX machines. No major difference found.
> > This is RFC because ILP32 is not tested in big-endian mode.
> > 
> >  v3: https://lkml.org/lkml/2014/9/3/704
> >  v4: https://lkml.org/lkml/2015/4/13/691
> >  v5: https://lkml.org/lkml/2015/9/29/911
> > 
> >  v6:
> >  - time_t, __kenel_off_t and other types turned to be 32-bit
> >    for compatibility reasons (after v5 discussion);
> 
> i added libc-alpha to cc, the thread is at
> https://lkml.org/lkml/2016/4/5/872
> or http://thread.gmane.org/gmane.linux.kernel.cross-arch/31449
> 
> the kernel position seems to be that the aarch64 ilp32 syscall abi
> will follow regular 32bit abis (apart from signal context and ptrace
> related things and syscalls will take 64bit arguments).
> 
> i think the reasoning is that this allows legacy (non-64bit-safe)
> software to use this abi on aarch64 without trouble.
> 
> i think this design should be ok for glibc.
> 
> there are some interop issues between processes following different abis
> (e.g. shared mutexes, abi specific file formats, lib paths,..) which apply,
> but i assume it is no different from existing 32bit vs 64bit issues.
> 
> the 32bit time_t and off_t are ugly and i wonder if 32bit __kernel_off_t
> is really necessary. (i don't see where that is changed: it is supposed
> to be __kernel_long_t which is 64bit).

__kernel_off_t and __kernel_ino_t are always 'long' and 'unsigned long'
for historic reasons, but they are not used at all on modern architectures.
We could add a few lines with #ifdef to the kernel headers to hide the
definition on architectures that don't use them, but that seems pointless
given that glibc just defines its own version.

For time_t, I'm working on the same thing in the long run: there will
be a 64 bit __kernel_time64_t that is always used on all architectures,
and a __kernel_time_t that is provided for backwards compatibility
with old libc on architectures that started out having it.

__kernel_long_t should not be 64 bit on 32-bit architectures, it is the
size of the 'long' type in the ABI and defining it as 'long long' on
x32 keeps causing problems that we should not add on new architectures.

> i think even legacy software should be able to deal with 64bit off_t,
> so we could avoid having two sets of filesystem apis or is 64bit-only
> off_t more work to do in linux/glibc?

All architectures that got merged in the last 10 years only support
64-bit __kernel_loff_t in the kernel but not __kernel_off_t, this
includes arc, c6x, h8300, hexagon, metag, nios2, openrisc, tile and
unicore32. However, glibc implements 32-bit off_t on top of the
64-bit syscall interfaces. I believe this was done to keep the code
looking more like the older 32-bit architectures.

I think it has become easier to override now and we just need to
update sysdeps/unix/sysv/linux/generic/bits/typesizes.h to set

#define __INO64_T_TYPE          __UQUAD_TYPE
#define __OFF64_T_TYPE          __UQUAD_TYPE
#define __OFF_T_MATCHES_OFF64_T        1
#define __INO_T_MATCHES_INO64_T        1

for new architectures (obviously not the ones that already use the
32-bit types). I haven't tries this, so there may be other things
that are required.

	Arnd
