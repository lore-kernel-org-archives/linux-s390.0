From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/5] all: s390: move wrapper infrastructure to generic
 headers
Date: Tue, 2 Feb 2016 17:08:26 +0100
Message-ID: <20160202160826.GF3990@osiris>
References: <1453741047-5498-1-git-send-email-ynorov@caviumnetworks.com>
 <1453741047-5498-2-git-send-email-ynorov@caviumnetworks.com>
 <20160128121618.GB5418@osiris>
 <20160128163109.GA8529@yury-N73SV>
 <20160201114251.GB973@yury-N73SV>
 <20160202073913.GB3990@osiris>
 <20160202154331.GA3003@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160202154331.GA3003@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, catalin.marinas@arm.com, Nathan_Lynch@mentor.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, broonie@kernel.org, joseph@codesourcery.com, schwidefsky@de.ibm.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 02, 2016 at 06:43:31PM +0300, Yury Norov wrote:
> > Well, I'd like to have some proof by the compiler or linker that nothing
> > went wrong. Which seems hard if only selected system call defines will be
> > converted to the new defines.
> > 
> > How can you tell that nothing has been forgotten?
> > 
> > Also, what happens if the prototype of a system call get's changed shortly
> > after it was merged. We might miss such changes and have bugs.
> > 
> 
> As for now, there's no such proof, and everything is OK. Syscall ABI
> is extremely conservative, and Greg KH, and other people spent a lot
> of efforts to keep it that way. This is the only reason for me to not
> worry much about it. Modification of syscall ABI is virtually
> impossible now, because it breaks binary compatibility. Even addition
> of new syscall is very difficult procedure.
> (Documentation/adding-syscalls.txt begins with section "System Call
> Alternatives".)

Well... during the years a lot of system calls have been added. And we've
also seen last-minute changes or reverts. So I don't share your optimistic
view here :)

See e.g. 485d52768685 ("sys_personality: change sys_personality() to accept
"unsigned int" instead of u_long") would have been a candidate which could
silently break architectures which need compat wrappers.

> We can invent some protection, but it will cost us in complexity and/or
> runtime delays. Because syscall ABI is so stable, I think it's OK to
> review wrappers carefully once, and they will be fine for long time.

Here I don't agree with you. These interfaces are so important that I'd
like to have a waterproof method that these don't break.  If this involves
a couple of superfluous instructions then that's what I'm willing to pay
for it.

> > Before doing that I think you should actually revert this patch: my commit
> > 7681df456f97 ("s390/compat: remove superfluous compat wrappers") probably
> > wasn't a very bright idea :)
> This patch is OK for me. pid_t, uid_t, gid_t, unsigned and signed int
> types are all 32-bit both on LP64 and ILP32. Normally, compiler should
> care about top halves... Did I miss something?

The patch was correct when writing it, but e.g. a patch like named above
would introduce a possible bug which would go in unnoticed.
The only thing we save is a _single_ unconditional branch here. I'd say
that's well worth it if you get a (hopefully) always bug free sign and zero
extension infrastructure in return.

> I don't know much about s390 specifics. Maybe because of that I do not
> understand completely your worries. I'm OK with both 1st and 2nd
> version, but I'd choose 2nd one because it allows inlines, and we
> don't need the compat_wrapper.c.

It would be only nicer if we can guarentee correctness all the time. That
being said I'm about to revert my own commit :)

So if you want to go without compat_wrapper.c then we should have a
solution which will do the right thing all the time without that a system
call author has to know about the sign and zero extension issue some
architectures face. It _will_ go wrong.
