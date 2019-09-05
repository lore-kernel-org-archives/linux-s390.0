Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 5 Sep 2019 12:57:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 01/12] lib: introduce copy_struct_{to,from}_user
 helpers
Message-ID: <20190905105749.GW2386@hirez.programming.kicks-ass.net>
References: <20190904201933.10736-1-cyphar@cyphar.com>
 <20190904201933.10736-2-cyphar@cyphar.com>
 <20190905073205.GY2332@hirez.programming.kicks-ass.net>
 <20190905092622.tlb6nn3uisssdfbu@yavin.dot.cyphar.com>
 <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905094305.GJ2349@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Christian Brauner <christian@brauner.io>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org, patrick.bellasi@arm.com

On Thu, Sep 05, 2019 at 11:43:05AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 05, 2019 at 07:26:22PM +1000, Aleksa Sarai wrote:
> > On 2019-09-05, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Thu, Sep 05, 2019 at 06:19:22AM +1000, Aleksa Sarai wrote:
> > > > +/**
> > > > + * copy_struct_to_user: copy a struct to user space
> > > > + * @dst:   Destination address, in user space.
> > > > + * @usize: Size of @dst struct.
> > > > + * @src:   Source address, in kernel space.
> > > > + * @ksize: Size of @src struct.
> > > > + *
> > > > + * Copies a struct from kernel space to user space, in a way that guarantees
> > > > + * backwards-compatibility for struct syscall arguments (as long as future
> > > > + * struct extensions are made such that all new fields are *appended* to the
> > > > + * old struct, and zeroed-out new fields have the same meaning as the old
> > > > + * struct).
> > > > + *
> > > > + * @ksize is just sizeof(*dst), and @usize should've been passed by user space.
> > > > + * The recommended usage is something like the following:
> > > > + *
> > > > + *   SYSCALL_DEFINE2(foobar, struct foo __user *, uarg, size_t, usize)
> > > > + *   {
> > > > + *      int err;
> > > > + *      struct foo karg = {};
> > > > + *
> > > > + *      // do something with karg
> > > > + *
> > > > + *      err = copy_struct_to_user(uarg, usize, &karg, sizeof(karg));
> > > > + *      if (err)
> > > > + *        return err;
> > > > + *
> > > > + *      // ...
> > > > + *   }
> > > > + *
> > > > + * There are three cases to consider:
> > > > + *  * If @usize == @ksize, then it's copied verbatim.
> > > > + *  * If @usize < @ksize, then kernel space is "returning" a newer struct to an
> > > > + *    older user space. In order to avoid user space getting incomplete
> > > > + *    information (new fields might be important), all trailing bytes in @src
> > > > + *    (@ksize - @usize) must be zerored
> > > 
> > > s/zerored/zero/, right?
> > 
> > It should've been "zeroed".
> 
> That reads wrong to me; that way it reads like this function must take
> that action and zero out the 'rest'; which is just wrong.
> 
> This function must verify those bytes are zero, not make them zero.
> 
> > > >                                          , otherwise -EFBIG is returned.
> > > 
> > > 'Funny' that, copy_struct_from_user() below seems to use E2BIG.
> > 
> > This is a copy of the semantics that sched_[sg]etattr(2) uses -- E2BIG for
> > a "too big" struct passed to the kernel, and EFBIG for a "too big"
> > struct passed to user-space. I would personally have preferred EMSGSIZE
> > instead of EFBIG, but felt using the existing error codes would be less
> > confusing.
> 
> Sadly a recent commit:
> 
>   1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and code")
> 
> Made the situation even 'worse'.

And thinking more about things; I'm not convinced the above patch is
actually right.

Do we really want to simply truncate all the attributes of the task?

And should we not at least set sched_flags when there are non-default
clamp values applied?

See; that is I think the primary bug that had chrt failing; we tried to
publish the default clamp values as !0.
