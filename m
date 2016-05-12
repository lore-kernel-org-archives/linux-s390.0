From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Thu, 12 May 2016 16:44:31 +0300
Message-ID: <20160512134431.GB30205@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
 <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, schwab@suse.de, schwidefsky@de.ibm.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 12, 2016 at 02:35:34PM +0100, Catalin Marinas wrote:
> On Thu, May 12, 2016 at 03:20:00AM +0300, Yury Norov wrote:
> > I debugged preadv02 and pwritev02 failures and found very weird bug.
> > Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
> > of vector, and kernel reports successful read/write.
> > 
> > There are 2 problems:
> > 1. How kernel allows such address to be passed to fs subsystem;
> > 2. How fs successes to read/write at non-mapped, and in fact non-user
> > address.
> > 
> > I don't know the answer on 2'nd question, and it might be something
> > generic. But I investigated first problem.
> > 
> > The problem is that compat_rw_copy_check_uvector() uses access_ok() to
> > validate user address, and on arm64 it ends up with checking buffer
> > end against current_thread_info()->addr_limit.
> > 
> > current_thread_info()->addr_limit for ilp32, and most probably for
> > aarch32 is equal to aarch64 one, and so adress_ok() doesn't fail.
> > It happens because on thread creation we call flush_old_exec() to set 
> > addr_limit, and completely ignore compat mode there.
> 
> I assume accesses beyond this address would fault anyway but I haven't
> checked the code paths.
> 
> > diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> > index 7a39683..6ba4952 100644
> > --- a/arch/arm64/include/asm/elf.h
> > +++ b/arch/arm64/include/asm/elf.h
> > @@ -146,6 +146,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
> >  do {						\
> >  	clear_thread_flag(TIF_32BIT_AARCH64);	\
> >  	clear_thread_flag(TIF_32BIT);		\
> > +	set_fs(TASK_SIZE_64);			\
> >  } while (0)
> 
> See below.
> 
> > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > index 19cfdc5..3b0dd8d 100644
> > --- a/arch/arm64/include/asm/uaccess.h
> > +++ b/arch/arm64/include/asm/uaccess.h
> > @@ -51,7 +51,7 @@
> >  #define KERNEL_DS	(-1UL)
> >  #define get_ds()	(KERNEL_DS)
> >  
> > -#define USER_DS		TASK_SIZE_64
> > +#define USER_DS		TASK_SIZE
> 
> I agree with this.
> 
> >  #define get_fs()	(current_thread_info()->addr_limit)
> >  
> >  static inline void set_fs(mm_segment_t fs)
> > diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
> > index 5487872..2e8d9f3 100644
> > --- a/arch/arm64/kernel/binfmt_elf32.c
> > +++ b/arch/arm64/kernel/binfmt_elf32.c
> > @@ -12,6 +12,7 @@
> >  do {						\
> >  	clear_thread_flag(TIF_32BIT_AARCH64);	\
> >  	set_thread_flag(TIF_32BIT);		\
> > +	set_fs(TASK_SIZE_32);			\
> >  } while (0)
> >  
> >  #define COMPAT_ARCH_DLINFO
> > diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
> > index a934fd4..a8599c6 100644
> > --- a/arch/arm64/kernel/binfmt_ilp32.c
> > +++ b/arch/arm64/kernel/binfmt_ilp32.c
> > @@ -59,6 +59,7 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
> >  do {									\
> >  	set_thread_flag(TIF_32BIT_AARCH64);				\
> >  	clear_thread_flag(TIF_32BIT);					\
> > +	set_fs(TASK_SIZE_32);						\
> >  } while (0)
> 
> I don't think we need these two. AFAICT, flush_old_exec() takes care of
> setting the USER_DS for the new thread.

That's true, but USER_DS depends on personality which is not set yet
for new thread, as I wrote above. In fact, I tried correct USER_DS
only, and it doesn't work

> 
> -- 
> Catalin
