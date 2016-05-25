From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Wed, 25 May 2016 22:47:33 +0200
Message-ID: <6293194.tGy03QJ9ME@wuerfel>
References: <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com> <20160525200327.GA22395@yury-N73SV> <20160525.132145.1271448744307448631.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20160525.132145.1271448744307448631.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: ynorov@caviumnetworks.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wednesday, May 25, 2016 1:21:45 PM CEST David Miller wrote:
> From: Yury Norov <ynorov@caviumnetworks.com>
> Date: Wed, 25 May 2016 23:03:27 +0300
> 
> > On Wed, May 25, 2016 at 12:30:17PM -0700, David Miller wrote:
> >> From: Yury Norov <ynorov@caviumnetworks.com>
> >> Date: Tue, 24 May 2016 03:04:30 +0300
> >> 
> >> > +To clear that top halves, automatic wrappers are introduced. They clear all
> >> > +required registers before passing control to regular syscall handler.
> >> 
> >> Why have one of these for every single compat system call, rather than
> >> simply clearing the top half of all of these registers unconditionally
> >> in the 32-bit system call trap before the system call is invoked?
> >> 
> >> That's what we do on sparc64.
> >> 
> >> And with that, you only need wrappers for the case where there needs
> >> to be proper sign extention of a 32-bit signed argument.
> > 
> > It was discussed as one of possible solutions. The downside of it is
> > that we cannot pass 64-bit types (like off_t) in single register.
> 
> Wrappers can be added for the cases where you'd like to do that.

If we clear the upper halves on the initial entry, we can't use a wrapper
to restore them, so would have to instead pass them as register
pairs as we do on the other 32-bit architectures.

> > The other downside is that we clear top halves for every single
> > syscall, and it looks excessive. So, from spark64 and s390 approaches
> > we choosed second.
> 
> It's like 4 cpu cycles even on crappy sparc64 cpus which only dual
> issue. :)
> 
> And that's a pretty low cost for the benefits if you ask me.

To clarify what we are talking about: These syscalls that normally
pass 64-bit arguments as register pairs are intentionally overridden
to make them faster on ilp32 mode compare to other compat modes:

+#define compat_sys_fadvise64_64        sys_fadvise64_64
+#define compat_sys_fallocate           sys_fallocate
+#define compat_sys_ftruncate64         sys_ftruncate
+#define compat_sys_lookup_dcookie      sys_lookup_dcookie
+#define compat_sys_readahead           sys_readahead
+#define compat_sys_sync_file_range     sys_sync_file_range
+#define compat_sys_truncate64          sys_truncate
+#define sys_llseek                     sys_lseek
+static unsigned long compat_sys_pread64(unsigned int fd,
+               compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
+{
+       return sys_pread64(fd, (char *) ubuf, count, offset);
+}
+
+static unsigned long compat_sys_pwrite64(unsigned int fd,
+               compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
+{
+       return sys_pwrite64(fd, (char *) ubuf, count, offset);
+}

If we use the normal calling conventions, we could remove these overrides
along with the respective special-case handling in glibc. None of them
look particularly performance-sensitive, but I could be wrong there.

	Arnd
