From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Date: Tue, 2 Feb 2016 18:43:31 +0300
Message-ID: <20160202154331.GA3003@yury-N73SV>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris>
 <20160128163109.GA8529@yury-N73SV>
 <20160201114251.GB973@yury-N73SV>
 <20160202073913.GB3990@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202073913.GB3990@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 02, 2016 at 08:39:13AM +0100, Heiko Carstens wrote:
> On Mon, Feb 01, 2016 at 02:42:51PM +0300, Yury Norov wrote:
> > Hi Heiko,
> > 
> > I tried this idea, and I don't like what happened.
> >  - Wrappers around safe syscalls does exist. We can remove it by
> >    overcomplicating __SC_COMPAT_CAST, but I don't like it.
> >  - We still need to declare numerous list of new compat syscalls.
> >    And it becomes even bigger, as we need to declare all compat
> >    syscall versions not declared in include/linux/compat.h already.
> >    (Currently - only for unsafe syscalls.)
> >  - 'Weak' trick doesn't work for the whole kernel, so we'd figure out
> >    some new prefix for wrapped syscalls. Or declare all non-compat
> >    syscalls explicitly with SYSCALL_COMPAT_DEFINE. So the list of
> >    replacements grow. And for me, it's harder to explain why we are
> >    wrapping safe syscalls. Or we introduce another bunch of useless
> >    wrappers (with new prefix), and have to handle it in non-compat code.
> >  - With all listed above, we move all wrapper logic to non-compat
> >    'include/linux/syscalls.h' header. Which is not a good idea, if it
> >    doesn't benefit us much in return.
> > 
> > > > No need to look up if a compat variant (or wrapper) exists or
> > > > sys_<syscallname> should be used instead. Also no possibility for security
> > > > bugs that could creep in because SYSCALL_DEFINE has been used instead of
> > > > SYSCALL_DEFINE_WRAP.
> > 
> > I thought again about it. With current version, it's very easy to
> > define whether we have wrapper or not - just by macro we use. Once
> > reviewed, this list is hardly to be changed frequently. If someone is
> > introducing new syscall, it will attract much attention, so security
> > risk is minimal.
> > 
> > Maybe I missed some elegant implementation, and if so  I'll be happy
> > if someone'll point me out. But with what I see, I'd vote for what we
> > have now. (Plus description in docs, plus renaming new macro.)
> 
> Well, I'd like to have some proof by the compiler or linker that nothing
> went wrong. Which seems hard if only selected system call defines will be
> converted to the new defines.
> 
> How can you tell that nothing has been forgotten?
> 
> Also, what happens if the prototype of a system call get's changed shortly
> after it was merged. We might miss such changes and have bugs.
> 

As for now, there's no such proof, and everything is OK. Syscall ABI
is extremely conservative, and Greg KH, and other people spent a lot
of efforts to keep it that way. This is the only reason for me to not
worry much about it. Modification of syscall ABI is virtually
impossible now, because it breaks binary compatibility. Even addition
of new syscall is very difficult procedure.
(Documentation/adding-syscalls.txt begins with section "System Call
Alternatives".)

We can invent some protection, but it will cost us in complexity and/or
runtime delays. Because syscall ABI is so stable, I think it's OK to
review wrappers carefully once, and they will be fine for long time.

> Therefore, and to get to a solution, I think we should stick with your
> first idea, which only moves the compat_wrapper.c file.
> 
> Before doing that I think you should actually revert this patch: my commit
> 7681df456f97 ("s390/compat: remove superfluous compat wrappers") probably
> wasn't a very bright idea :)
> 

This patch is OK for me. pid_t, uid_t, gid_t, unsigned and signed int
types are all 32-bit both on LP64 and ILP32. Normally, compiler should
care about top halves... Did I miss something?

> This again allows me to use only compat system calls in s390's system call
> table (execpt for system calls without parameters, but that can be easily
> fixed).
> 
> What I still don't like is that you need to add all the protoypes. Why are
> the system call tables actually written in C and not in asm?

Because generic unistd code is multi-platform by intention.

I don't know much about s390 specifics. Maybe because of that I do not
understand completely your worries. I'm OK with both 1st and 2nd
version, but I'd choose 2nd one because it allows inlines, and we
don't need the compat_wrapper.c. 
