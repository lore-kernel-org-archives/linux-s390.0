From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Wed, 18 May 2016 20:58:59 +0300
Message-ID: <20160518175859.GA2560@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <20160514150352.GA30533@yury-N73SV>
 <20160516170605.GB19290@e104818-lin.cambridge.arm.com>
 <20160517190526.GA3731@yury-N73SV>
 <20160518112145.GD22378@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160518112145.GD22378@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwab@suse.de, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 18, 2016 at 12:21:46PM +0100, Catalin Marinas wrote:
> On Tue, May 17, 2016 at 10:05:26PM +0300, Yury Norov wrote:
> > On Mon, May 16, 2016 at 06:06:05PM +0100, Catalin Marinas wrote:
> > > On Sat, May 14, 2016 at 06:03:52PM +0300, Yury Norov wrote:
> > > > +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> > > > +       unsigned long, prot, unsigned long, flags, unsigned long, fd,
> > > > +       unsigned long, pgoff)
> > > 
> > > To avoid the types confusion we could add __SC_WRAP to mmap2 in unistd.h
> > > and use COMPAT_SYSCALL_DEFINE6 here (together with compat_ptr_t etc.).
> > > 
> > > > +{
> > > > +       if (pgoff & (~PAGE_MASK >> 12))
> > > > +               return -EINVAL;
> > > > +
> > > > +       return sys_mmap_pgoff((compat_uptr_t) addr, (compat_size_t) len,
> > > > +		       (int) prot, (int) flags, (int) fd,
> > > > +		       pgoff >> (PAGE_SHIFT-12));
> > > 
> > > Then we wouldn't need the explicit casting here.
> > 
> > See below
> > 
> > > > +}
> > > > +
> > > > +COMPAT_SYSCALL_DEFINE4(pread64, unsigned int, fd, compat_uptr_t __user *, ubuf,
> > > > +		       compat_size_t, count, off_t, offset)
> > > > +{
> > > > +	return sys_pread64(fd, (char *) ubuf, count, offset);
> > > > +}
> > > > +
> > > > +COMPAT_SYSCALL_DEFINE4(pwrite64, unsigned int, fd, compat_uptr_t __user *, ubuf,
> > > > +		       compat_size_t, count, off_t, offset)
> > > > +{
> > > > +	return sys_pwrite64(fd, (char *) ubuf, count, offset);
> > > 
> > > Nitpick: no space between cast type and variable name: (char *)ubuf, ...
> > 
> > I think it's really a matter of taste. I prefer to have a space, and
> > there's no solid rule in coding style.
> > 
> > And there are 13032 insertions of my version vs 35030 of yours:
> > ~/work/linux$ git grep ' \*)[a-zA-Z]'|wc -l
> > 35030
> > ~/work/linux$ git grep ' \*) [a-zA-Z]'|wc -l
> > 13032
> > 
> > Of course, I will change it if you insist.
> 
> Not really, I thought it's covered by CodingStyle but it doesn't seem
> to.
> 
> > > We can also make these functions static as they are not used outside
> > > this file.
> > 
> > If it's OK, we can use just compat_sys_xxx() instead of
> > COMPAT_SYSCALL_DEFINEx(xxx),
> 
> I got lost in macros, what difference would COMPAT_SYSCALL_DEFINE vs
> compat_sys_*() make? Is this the delouse stuff?
> 

Hmm... I looked again. It seems that COMPAT delouses all arguments,
including off_t, and that's what we try to avoid. So we *should* use
naked functions. 

include/linux/compat.h:
53 #define COMPAT_SYSCALL_DEFINEx(x, name, ...) \
54         asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
55              __attribute__((alias(__stringify(compat_SyS##name))));  \
56         static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
57         asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));\
58         asmlinkage long compat_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))\
59         { \
60                 return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__)); \
61         } \
62         static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))


> > and for mmap2 we'll not need to change _SYSCALL to _SC_WRAP in
> > unistd.h that way.
> 
> Looking at the generic unistd.h, adding _SC_WRAP for sys_mmap2 is
> indeed not easy:
> 
> #define __NR3264_mmap 222
> __SC_3264(__NR3264_mmap, sys_mmap2, sys_mmap)
> 
> So defining a compat_sys_mmap2() would work but I think you'd also need:
> 

> #define sys_mmap2	compat_sys_mmap2()

OK.

> 
> -- 
> Catalin
