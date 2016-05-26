From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Thu, 26 May 2016 16:19:02 +0100
Message-ID: <20160526151902.GC7456@e104818-lin.cambridge.arm.com>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
 <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
 <57470D19.2000501@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57470D19.2000501@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: David Miller <davem@davemloft.net>, nd@arm.com, arnd@arndb.de, ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 26, 2016 at 03:50:01PM +0100, Szabolcs Nagy wrote:
> On 26/05/16 15:20, Catalin Marinas wrote:
> > While writing the above, I realised the current ILP32 patches still miss
> > on converting pointers passed from user space (unless I got myself
> > confused in macros). The new __SC_WRAP() and COMPAT_SYSCALL_WRAPx()
> > macros take care of zero or sign extension via __SC_COMPAT_CAST().
> > However, we have two more existing cases which I don't see covered:
> > 
> > a) Native syscalls taking a pointer argument and invoked directly from
> >    ILP32. For example, sys_read() takes a pointer but I don't see any
> >    __SC_WRAP added by patch 5
> > 
> > b) Current compat syscalls taking a pointer argument. For example,
> >    compat_sys_vmsplice() gets the iov32 pointer and the compiler assumes
> >    it is a 64-bit variable. I don't see where the upper half is zeroed
> 
> on x32 sign/zero extension is currently left to userspace,
> which is difficult to deal with, (long long)arg does the
> wrong thing for pointer args.

I agree, I don't think we should leave sign/zero extension to user. We
should do it in the kernel either in a way similar to s390 (specific
__SC_COMPAT_CAST, __SC_DELOUSE) or by always zeroing the arguments upper
half on kernel entry with a few additional wrappers (where we have
64-bit arguments or they require sign extension). The latter has the
disadvantage of having to split 64-bit arguments in user space while the
former adds more maintenance burden to the kernel.

I can't comment on performance aspects without some real numbers.

-- 
Catalin
