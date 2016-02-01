From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Date: Mon, 1 Feb 2016 14:42:51 +0300
Message-ID: <20160201114251.GB973@yury-N73SV>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris>
 <20160128163109.GA8529@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160128163109.GA8529@yury-N73SV>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 28, 2016 at 07:31:09PM +0300, Yury Norov wrote:
> On Thu, Jan 28, 2016 at 01:16:18PM +0100, Heiko Carstens wrote:
> > Hello Yury,
> > 
> > On Mon, Jan 25, 2016 at 07:57:23PM +0300, Yury Norov wrote:
> > > __SC_COMPAT_CAST for s390 is too specific due to 31-bit pointer length, so it's
> > > moved to arch/s390/include/asm/compat.h. Generic declaration assumes that long,
> > > unsigned long and pointer types are all 32-bit length.
> > > 
> > > linux/syscalls_structs.h header is introduced, because from now (see next patch)
> > > structure types listed there are needed for both normal and compat mode.
> > > 
> > > cond_syscall_wrapped now defined two symbols: sys_foo() and compat_sys_foo(), if
> > > compat wrappers are enabled.
> > > 
> > > Here __SC_WRAP() macro is introduced as well. s390 doesn't need it as it uses
> > > asm-generated syscall table. But architectures that generate that tables with
> > > C code (ARM64/ILP32) should redefine it as '#define __SC_WRAP(name) compat_##name'.
> > > 
> > > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> > 
> > ...
> > 
> 
> Hi Heiko,
> 
> > How about if you rename SYSCALL_DEFINE_WRAP to SYSCALL_COMPAT_DEFINE which
> > has the semantics that no dedicated compat system call exists (aka system
> > call is compat safe).
> > 
> > Then convert all existing SYSCALL_DEFINE'd system calls for which no compat
> > variant exists to SYSCALL_COMPAT_DEFINE.
> > 
> > This would allow to specify "compat_sys_<syscallname>" in the compat system
> > call table for _all_ system calls.
> > 
> 
> We can modify SYSCALL_DEFINEx macro to declare weak "compat_sys_<syscallname>"
> symbol for each syscall. So if strong compat symbol will be declared
> somwere else, it will owerride the weak one. Being under COMPAT_WRAPPER
> config, it will not affect someone else except s390 and aarch64/ilp32.
> The downside of this approach is that we'll have to move wrapper
> machinery to 'include/linux/syscalls.h', thought under wrapper config.
> 
> > No need to look up if a compat variant (or wrapper) exists or
> > sys_<syscallname> should be used instead. Also no possibility for security
> > bugs that could creep in because SYSCALL_DEFINE has been used instead of
> > SYSCALL_DEFINE_WRAP.
> 
> If we'll choose to stay with current approach, we'll definitely need
> to update documentation.
> 
> > 
> > Ideally the implementation would only generate an alias if no sign/zero
> > extension is necessary.
> > 
> > Trivially this would be true for system calls without arguments like e.g.
> > sys_fork() which would get a compat_sys_fork alias without any further
> > code.
> > 
> > I'm not sure how difficult it is to implement the same logic for system
> > calls that have parameters. That is: either generate a
> > compat_sys_<syscallname> wrapper function, or if the SYSCALL_COMPAT_DEFINE
> > macro figures out that no zero sign extension is required, only an alias
> > without any additional code.
> > 
> > I think in the long term something like this is much easier to maintain.
> > 
> > Does that make sense?
> 
> For me, the most important adwantage of this approach is that we don't
> need the list of 'magic' system calls anymore. It's even more
> important if we'll face a requirement to support ABI that differs from
> both natural and ilp32 ABIs. New __SC_COMPAT_CAST will do all the job
> for us.
> 
> The downsides are that we'll have unneeded wrappers for some syscalls,
> if linker will not clear them, and wasting of space if we'll find no
> way how to explain compiler to generate simple alias when it's
> enough... 
> 
> I'll play with it and write you what I'll come to.
> 
> Yury.

Hi Heiko,

I tried this idea, and I don't like what happened.
 - Wrappers around safe syscalls does exist. We can remove it by
   overcomplicating __SC_COMPAT_CAST, but I don't like it.
 - We still need to declare numerous list of new compat syscalls.
   And it becomes even bigger, as we need to declare all compat
   syscall versions not declared in include/linux/compat.h already.
   (Currently - only for unsafe syscalls.)
 - 'Weak' trick doesn't work for the whole kernel, so we'd figure out
   some new prefix for wrapped syscalls. Or declare all non-compat
   syscalls explicitly with SYSCALL_COMPAT_DEFINE. So the list of
   replacements grow. And for me, it's harder to explain why we are
   wrapping safe syscalls. Or we introduce another bunch of useless
   wrappers (with new prefix), and have to handle it in non-compat code.
 - With all listed above, we move all wrapper logic to non-compat
   'include/linux/syscalls.h' header. Which is not a good idea, if it
   doesn't benefit us much in return.

> > No need to look up if a compat variant (or wrapper) exists or
> > sys_<syscallname> should be used instead. Also no possibility for security
> > bugs that could creep in because SYSCALL_DEFINE has been used instead of
> > SYSCALL_DEFINE_WRAP.

I thought again about it. With current version, it's very easy to
define whether we have wrapper or not - just by macro we use. Once
reviewed, this list is hardly to be changed frequently. If someone is
introducing new syscall, it will attract much attention, so security
risk is minimal.

Maybe I missed some elegant implementation, and if so  I'll be happy
if someone'll point me out. But with what I see, I'd vote for what we
have now. (Plus description in docs, plus renaming new macro.)

Yury.
