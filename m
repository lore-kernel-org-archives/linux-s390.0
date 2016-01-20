From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] Rename is_compat_task to in_compat_syscall
Date: Wed, 20 Jan 2016 09:58:12 +0100
Message-ID: <20160120085812.GC3395@osiris>
References: <79347eb4ec12be34098b36693bcf613eb597cbe9.1453239942.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <79347eb4ec12be34098b36693bcf613eb597cbe9.1453239942.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 19, 2016 at 01:47:24PM -0800, Andy Lutomirski wrote:
> Essentially all users of is_compat_task in the kernel are trying to
> determine whether they are executing in the context of a compat
> syscall.  On at least x86_64 and sparc, these are not at all the
> same question.
> 
> On x86_64 and sparc, therefore, is_compat_task doesn't return the
> overall compat state of the task; it returns true if the task is
> currently in a compat syscall.
> 
> This confusion has been the source of bugs in the past.  Rename the
> function to make it much clearer what it does.
> 
> This results in some odd definitions in the s390 headers.  s390
> maintainers, are you okay with that?  If not, I'd be happy to clean
> it up if you let me know how you'd like me to do it.

Indeed, ignoring the sparc vs x86 issue, this leads to rather odd code at
least in s390 code, where the statement "in_compat_syscall()" doesn't make
sense.  E.g. when handling uprobes caused traps we are not in a system
call. The same is true when setting up a compat signal frame when returning
e.g. from a trap to user space.

Looks like x86 has explicit test_thread_flag() invocations for such things.
While we can change s390 to do the same, I'm not sure if this is really a
change for the better.

I'd probably keep an s390 private variant of is_compat_task() for such
code.
