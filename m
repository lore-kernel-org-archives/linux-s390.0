From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
Date: Thu, 12 May 2016 15:20:16 +0100
Message-ID: <20160512142016.GH11226@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <20160512002000.GA30997@yury-N73SV>
 <20160512133533.GF11226@e104818-lin.cambridge.arm.com>
 <20160512134431.GB30205@yury-N73SV>
 <20160512140734.GG11226@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160512140734.GG11226@e104818-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, Nathan_Lynch@mentor.com, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, joseph@codesourcery.com, schwab@suse.de, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 12, 2016 at 03:07:35PM +0100, Catalin Marinas wrote:
> On Thu, May 12, 2016 at 04:44:31PM +0300, Yury Norov wrote:
> > On Thu, May 12, 2016 at 02:35:34PM +0100, Catalin Marinas wrote:
> > > On Thu, May 12, 2016 at 03:20:00AM +0300, Yury Norov wrote:
> > > > I debugged preadv02 and pwritev02 failures and found very weird bug.
> > > > Test passes {iovec_base = 0xffffffff, iovec_len = 64} as one element
> > > > of vector, and kernel reports successful read/write.
> > > > 
> > > > There are 2 problems:
> > > > 1. How kernel allows such address to be passed to fs subsystem;
> > > > 2. How fs successes to read/write at non-mapped, and in fact non-user
> > > > address.
> > > > 
> > > > I don't know the answer on 2'nd question, and it might be something
> > > > generic. But I investigated first problem.
> > > > 
> > > > The problem is that compat_rw_copy_check_uvector() uses access_ok() to
> > > > validate user address, and on arm64 it ends up with checking buffer
> > > > end against current_thread_info()->addr_limit.
> > > > 
> > > > current_thread_info()->addr_limit for ilp32, and most probably for
> > > > aarch32 is equal to aarch64 one, and so adress_ok() doesn't fail.
> > > > It happens because on thread creation we call flush_old_exec() to set 
> > > > addr_limit, and completely ignore compat mode there.
> 
> [...]
> 
> > > > --- a/arch/arm64/kernel/binfmt_elf32.c
> > > > +++ b/arch/arm64/kernel/binfmt_elf32.c
> > > > @@ -12,6 +12,7 @@
> > > >  do {						\
> > > >  	clear_thread_flag(TIF_32BIT_AARCH64);	\
> > > >  	set_thread_flag(TIF_32BIT);		\
> > > > +	set_fs(TASK_SIZE_32);			\
> > > >  } while (0)
> > > >  
> > > >  #define COMPAT_ARCH_DLINFO
> > > > diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
> > > > index a934fd4..a8599c6 100644
> > > > --- a/arch/arm64/kernel/binfmt_ilp32.c
> > > > +++ b/arch/arm64/kernel/binfmt_ilp32.c
> > > > @@ -59,6 +59,7 @@ static void cputime_to_compat_timeval(const cputime_t cputime,
> > > >  do {									\
> > > >  	set_thread_flag(TIF_32BIT_AARCH64);				\
> > > >  	clear_thread_flag(TIF_32BIT);					\
> > > > +	set_fs(TASK_SIZE_32);						\
> > > >  } while (0)
> > > 
> > > I don't think we need these two. AFAICT, flush_old_exec() takes care of
> > > setting the USER_DS for the new thread.
> > 
> > That's true, but USER_DS depends on personality which is not set yet
> > for new thread, as I wrote above. In fact, I tried correct USER_DS
> > only, and it doesn't work
> 
> Ah, it looks like load_elf_binary() sets the personality after
> flush_old_exec(). Looking at powerpc and x86, they set USER_DS to the
> maximum 64-bit task value, so they should have a similar issue with
> native 32-bit vs compat behaviour.

I think we have another problem. flush_old_exec() calls the arm64
flush_thread() where tls_thread_flush() checks for is_compat_task(). So
starting a 32-bit application from a 64-bit one not go on the correct
path.

-- 
Catalin
